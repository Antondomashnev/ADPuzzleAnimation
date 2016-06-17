require File.expand_path('../../../spec_helper', __FILE__)
require 'tmpdir'

module Pod
  describe Command::Trunk::Push do
    before do
      Command::Trunk::Push.any_instance.stubs(:update_master_repo)
    end

    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w( trunk push        )).should.be.instance_of Command::Trunk::Push
      end
    end

    it "should error if we don't have a token" do
      Netrc.any_instance.stubs(:[]).returns(nil)
      command = Command.parse(%w( trunk push ))
      exception = lambda { command.validate! }.should.raise CLAide::Help
      exception.message.should.include 'register a session'
    end

    it 'should error when the trunk service returns an error' do
      url = 'https://trunk.cocoapods.org/api/v1/pods?allow_warnings=false'
      WebMock::API.stub_request(:post, url).to_return(:status => 422, :body => {
        'error' => 'The Pod Specification did not pass validation.',
        'data' => {
          'warnings' => [
            'A value for `requires_arc` should be specified until the migration to a `true` default.',
          ],
        },
      }.to_json)
      command = Command.parse(%w(trunk push))
      command.stubs(:validate_podspec)
      command.stubs(:spec).returns(Pod::Specification.new)
      exception = lambda { command.run }.should.raise Informative
      exception.message.should.include 'following validation failed'
      exception.message.should.include 'should be specified'
      exception.message.should.include 'The Pod Specification did not pass validation'
    end

    describe 'PATH' do
      before do
        UI.output = ''
      end
      it 'defaults to the current directory' do
        # Disable the podspec finding algorithm so we can check the raw path
        Command::Trunk::Push.any_instance.stubs(:find_podspec_file) { |path| path }
        command = Command.parse(%w(        trunk push        ))
        command.instance_eval { @path }.should == '.'
      end

      def found_podspec_among_files(files)
        # Create a temp directory with the dummy `files` in it
        Dir.mktmpdir do |dir|
          files.each do |filename|
            path = Pathname(dir) + filename
            File.open(path, 'w') {}
          end
          # Execute `pod trunk push` with this dir as parameter
          command = Command.parse(%w(          trunk push          ) + [dir])
          path = command.instance_eval { @path }
          return File.basename(path) if path
        end
      end

      it 'should find the only JSON podspec in a given directory' do
        files = %w(foo bar.podspec.json baz)
        found_podspec_among_files(files).should == files[1]
      end

      it 'should find the only Ruby podspec in a given directory' do
        files = %w(foo bar.podspec baz)
        found_podspec_among_files(files).should == files[1]
      end

      it 'should warn when no podspec found in a given directory' do
        files = %w(foo bar baz)
        found_podspec_among_files(files).should.nil?
        UI.output.should.match /No podspec found in directory/
      end

      it 'should warn when multiple podspecs found in a given directory' do
        files = %w(foo bar.podspec bar.podspec.json baz)
        found_podspec_among_files(files).should.nil?
        UI.output.should.match /Multiple podspec files in directory/
      end
    end

    describe 'validation' do
      before do
        Installer.any_instance.stubs(:aggregate_targets).returns([])

        Validator.any_instance.stubs(:check_file_patterns)
        Validator.any_instance.stubs(:validate_url)
        Validator.any_instance.stubs(:validate_screenshots)
        Validator.any_instance.stubs(:xcodebuild).returns('')
        Validator.any_instance.stubs(:install_pod)
        Validator.any_instance.stubs(:build_pod)
        Validator.any_instance.stubs(:add_app_project_import)
        %i(prepare resolve_dependencies download_dependencies).each do |m|
          Installer.any_instance.stubs(m)
        end
      end

      it 'validates specs as frameworks by default' do
        Validator.any_instance.expects(:podfile_from_spec).
          with(:ios, '8.0', true).once.returns(Podfile.new)
        Validator.any_instance.expects(:podfile_from_spec).
          with(:osx, nil, true).once.returns(Podfile.new)
        Validator.any_instance.expects(:podfile_from_spec).
          with(:tvos, nil, true).once.returns(Podfile.new)
        Validator.any_instance.expects(:podfile_from_spec).
          with(:watchos, nil, true).once.returns(Podfile.new)

        cmd = Command.parse(%w(trunk push spec/fixtures/BananaLib.podspec))
        cmd.send(:validate_podspec)
      end

      it 'validates specs as libraries if requested' do
        Validator.any_instance.expects(:podfile_from_spec).
          with(:ios, nil, false).once.returns(Podfile.new)
        Validator.any_instance.expects(:podfile_from_spec).
          with(:osx, nil, false).once.returns(Podfile.new)
        Validator.any_instance.expects(:podfile_from_spec).
          with(:tvos, nil, false).once.returns(Podfile.new)
        Validator.any_instance.expects(:podfile_from_spec).
          with(:watchos, nil, false).once.returns(Podfile.new)

        cmd = Command.parse(%w(trunk push spec/fixtures/BananaLib.podspec --use-libraries))
        cmd.send(:validate_podspec)
      end

      it 'prints the failure reason' do
        Validator.any_instance.expects(:validated?).returns(false)
        Validator.any_instance.expects(:validate)
        Validator.any_instance.expects(:failure_reason).returns('failure_reason')

        cmd = Command.parse(%w(trunk push spec/fixtures/BananaLib.podspec --use-libraries))
        e = should.raise(Informative) { cmd.send(:validate_podspec) }
        e.message.should.include 'The spec did not pass validation, due to failure_reason.'
      end
    end

    describe 'updating the master repo' do
      before do
        @cmd = Command.parse(%w(trunk push spec/fixtures/BananaLib.podspec))
        @cmd.stubs(:validate_podspec)
        version_response = {
          'messages' => [
            {
              '2015-12-05 02:00:25 UTC' => "Push for `BananaLib 0.96.3' initiated.",
            },
            {
              '2015-12-05 02:00:26 UTC' => "Push for `BananaLib 0.96.3' has been pushed (1.02409270 s).",
            },
          ],
          'data_url' => 'https://raw.githubusercontent.com/CocoaPods/Specs/ce4efe9f986d297008e8c61010a4b0d5881c50d0/Specs/BananaLib/0.96.3/BananaLib.podspec.json',
        }
        @cmd.stubs(:push_to_trunk).returns(version_response)
        Command::Trunk::Push.any_instance.unstub(:update_master_repo)
      end

      it 'updates the master repo when it exists' do
        Config.instance.sources_manager.stubs(:master_repo_functional?).returns(true)
        Config.instance.sources_manager.expects(:update).with('master').twice

        @cmd.run
      end

      it 'sets up the master repo when it does not exist' do
        Config.instance.sources_manager.stubs(:master_repo_functional?).returns(false)
        Config.instance.sources_manager.expects(:update).never
        Command::Setup.any_instance.expects(:run).twice

        @cmd.run
      end
    end
  end
end
