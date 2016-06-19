module Fastlane
  module Actions
    module SharedValues
      UPDATE_GITHUB_RELEASE_INFO = :UPDATE_GITHUB_RELEASE_INFO
    end

    # To share this integration with the other fastlane users:
    # - Fork https://github.com/KrauseFx/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

    class EditGithubReleaseAction < Action
      def self.run(params)

        require 'net/http'
        require 'net/https'
        require 'json'
        require 'base64'

        begin
          uri = URI("https://api.github.com/repos/#{params[:repository_name]}/releases/#{params[:id]}")

          # Create client
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER

          dict = Hash.new
          dict["draft"] = params[:draft] if params[:draft] != nil
          dict["prerelease"] = params[:prerelease] if params[:prerelease] != nil
          dict["body"] = params[:description] if params[:description]
          dict["tag_name"] = params[:tag_name] if params[:tag_name]
          dict["name"] = params[:name] if params[:name]
          body = JSON.dump(dict)

          # Create Request
          req =  Net::HTTP::Patch.new(uri)
          # Add headers
          req.add_field "Content-Type", "application/json"
          # Add headers
          api_token = params[:api_token]
          req.add_field "Authorization", "Basic #{Base64.strict_encode64(api_token)}"
          # Add headers
          req.add_field "Accept", "application/vnd.github.v3+json"
          # Set header and body
          req.add_field "Content-Type", "application/json"
          req.body = body

          # Fetch Request
          res = http.request(req)
        rescue StandardError => e
          Helper.log.info "HTTP Request failed (#{e.message})".red
        end

        case res.code.to_i
          when 200
          json = JSON.parse(res.body)
          Helper.log.info "Github Release updated".green

          Actions.lane_context[SharedValues::UPDATE_GITHUB_RELEASE_INFO] = json
          return json
          when 400..499
          json = JSON.parse(res.body)
          raise "Error Updating Github Release (#{res.code}): #{json["message"]}".red
          else
          Helper.log.info "Status Code: #{res.code} Body: #{res.body}"
          raise "Error Updating Github Release".red
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Edit a Github Release"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :owner,
                                       env_name: "GITHUB_OWNER",
                                       description: "The Github Owner",
                                       is_string:true,
                                       optional:false),
           FastlaneCore::ConfigItem.new(key: :repository_name,
                                        env_name: "GITHUB_REPOSITORY",
                                        description: "The Github Repository",
                                        is_string:true,
                                        optional:false),
          FastlaneCore::ConfigItem.new(key: :id,
                                       env_name: "GITHUB_RELEASE_ID",
                                       description: "The Github Release ID",
                                       is_string:true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "GITHUB_API_TOKEN",
                                       description: "Personal API Token for GitHub - generate one at https://github.com/settings/tokens",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :tag_name,
                                       env_name: "GITHUB_RELEASE_TAG_NAME",
                                       description: "Pass in the tag name",
                                       is_string: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :target_commitish,
                                       env_name: "GITHUB_TARGET_COMMITISH",
                                       description: "Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists",
                                       is_string: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :name,
                                       env_name: "GITHUB_RELEASE_NAME",
                                       description: "The name of the release",
                                       is_string: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :description,
                                       env_name: "GITHUB_RELEASE_BODY",
                                       description: "Text describing the contents of the tag",
                                       is_string: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :draft,
                                       env_name: "GITHUB_RELEASE_DRAFT",
                                       description: "true to create a draft (unpublished) release, false to create a published one",
                                       is_string: false,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :prerelease,
                                       env_name: "GITHUB_RELEASE_PRERELEASE",
                                       description: "true to identify the release as a prerelease. false to identify the release as a full release",
                                       is_string: false,
                                       optional: true),

        ]
      end

      def self.output
        [
          ['UPDATE_GITHUB_RELEASE_INFO', 'Contains all the information about updated release'],
        ]
      end

      def self.return_value
        "The Hash representing the API response"
      end

      def self.authors
        ["Multiple"]
      end

      def self.is_supported?(platform)
        return true
      end
    end
  end
end
