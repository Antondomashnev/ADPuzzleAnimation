module Pod
  class Command
    class Trunk
      # @CocoaPods 0.33.0
      #
      class Push < Trunk
        self.summary = 'Publish a podspec'
        self.description = <<-DESC
                Publish the podspec at `PATH` to make it available to all users of
                the ‘master’ spec-repo. If `PATH` is not provided, defaults to the
                current directory.

                Before pushing the podspec to cocoapods.org, this will perform a local
                lint of the podspec, including a build of the library. However, it
                remains *your* responsibility to ensure that the published podspec
                will actually work for your users. Thus it is recommended that you
                *first* try to use the podspec to integrate the library into your demo
                and/or real application.

                If this is the first time you publish a spec for this pod, you will
                automatically be registered as the ‘owner’ of this pod. (Note that
                ‘owner’ in this case implies a person that is allowed to publish new
                versions and add other ‘owners’, not necessarily the library author.)
        DESC

        self.arguments = [
          CLAide::Argument.new('PATH', false),
        ]

        def self.options
          [
            ['--allow-warnings', 'Allows push even if there are lint warnings'],
            ['--use-libraries', 'Linter uses static libraries to install the spec'],
          ].concat(super)
        end

        def initialize(argv)
          @allow_warnings = argv.flag?('allow-warnings', false)
          @use_frameworks = !argv.flag?('use-libraries')
          @path = argv.shift_argument || '.'
          find_podspec_file if File.directory?(@path)
          super
        end

        def validate!
          super
          unless token
            help! 'You need to register a session first.'
          end
          unless @path
            help! 'Please specify the path to the podspec file.'
          end
          unless File.exist?(@path) && !File.directory?(@path)
            help! "The specified path `#{@path}` does not point to " \
                    'an existing podspec file.'
          end
        end

        def run
          update_master_repo
          validate_podspec
          json = push_to_trunk
          update_master_repo
          print_messages(json['data_url'], json['messages'])
        end

        private

        def push_to_trunk
          response = request_path(:post, "pods?allow_warnings=#{@allow_warnings}",
                                  spec.to_json, auth_headers)
          url = response.headers['location'].first
          json(request_url(:get, url, default_headers))
        rescue REST::Error => e
          raise Informative, 'There was an error pushing a new version ' \
                                   "to trunk: #{e.message}"
        end

        def find_podspec_file
          podspecs = Dir[Pathname(@path) + '*.podspec{.json,}']
          case podspecs.count
          when 0
            UI.notice "No podspec found in directory `#{@path}`"
          when 1
            UI.notice "Found podspec `#{podspecs[0]}`"
          else
            UI.notice "Multiple podspec files in directory `#{@path}`. " \
                        'You need to explicitly specify which one to use.'
          end
          @path = (podspecs.count == 1) ? podspecs[0] : nil
        end

        def spec
          @spec ||= Pod::Specification.from_file(@path)
        rescue Informative => e # TODO: this should be a more specific error
          raise Informative, 'Unable to interpret the specified path ' \
                             "#{UI.path(@path)} as a podspec (#{e})."
        end

        # Performs a full lint against the podspecs.
        #
        # TODO: Currently copied verbatim from `pod push`.
        def validate_podspec
          UI.puts 'Validating podspec'.yellow

          validator = Validator.new(spec, %w(https://github.com/CocoaPods/Specs.git))
          validator.allow_warnings = @allow_warnings
          validator.use_frameworks = @use_frameworks
          validator.validate
          unless validator.validated?
            raise Informative, "The spec did not pass validation, due to #{validator.failure_reason}."
          end
        end

        def update_master_repo
          sources_manager = if defined?(Pod::SourcesManager)
                              Pod::SourcesManager
                            else
                              config.sources_manager
                            end
          if sources_manager.master_repo_functional?
            sources_manager.update('master')
          else
            Setup.invoke
          end
        end
      end
    end
  end
end
