module Fastlane
  module Actions
    module SharedValues
      MODIFY_PUBSPEC_CUSTOM_VALUE = :MODIFY_PUBSPEC_CUSTOM_VALUE
    end

    class ModifyPubspecAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        # UI.message "Parameter API Token: #{params[:api_token]}"

        path = params[:folder_name]
        UI.message "path #{path}"

        sh 'pwd'
        pubspec_data = File.read("#{path}common_pubspec.yaml")
        common_pubspec_file_data = JSON.parse pubspec_data.gsub('=>', ':')

        dependencies_data = common_pubspec_file_data["dependencies"]
        UI.message "dependencies_data #{dependencies_data.keys}"
        
        dev_dependencies_data = common_pubspec_file_data["dev_dependencies"]
        UI.message "dev_dependencies_data #{dev_dependencies_data.keys}"

        file = File.open("#{path}pubspec.yaml")
        file_data = file.readlines.map(&:chomp)

        dependencies_index = file_data.find_index("dependencies:")
        dev_dependencies_index = file_data.find_index("dev_dependencies:")
        
        if dev_dependencies_index == nil
          UI.message "no dev dependencies"
          file_data.append("dev_dependencies:")
          dev_dependencies_data.each { |key, value|
            package = '  ' + key + ": " + value
            file_data.append(package)
            dev_dependencies_data.delete(key)
          }
          # UI.message("#{file_data}")
        else
          line_index = 0
          file_data.each_with_index { |line, idx|
            current_package = line.split(":")
            current_package = current_package[0]
            
            if current_package.is_a?(String)
              current_package = current_package.strip

              if dependencies_data.keys.include?(current_package)
                package_string = "  " + current_package + ": " + dependencies_data[current_package]
                file_data[idx] = package_string
                dependencies_data.delete(current_package)
              else
                if dev_dependencies_data.keys.include?(current_package)
                  package_string = "  " + current_package + ": " + dev_dependencies_data[current_package]
                  file_data[idx] = package_string
                  dev_dependencies_data.delete(current_package)
                # else
                #   package_string = "    " + current_package + ": " + dev_dependencies_data[current_package] 
                #   file_data.insert(dev_dependencies_index, package_string)
                end
              end
            end
          }
        end

        
        dev_dependencies_index = file_data.find_index("dev_dependencies:")
        UI.message "dev_dependencies_index: #{dev_dependencies_index}, dev_dependencies_data_key: #{dev_dependencies_data.keys}"

        dev_dependencies_data.keys.each { |key, value|
          package_string = "  " + key + ": " + dev_dependencies_data[key]
          file_data.insert(dev_dependencies_index + 1, package_string)
        }

        UI.message "dependencies_index: #{dependencies_index}"
        dependencies_data.keys.each { |key, value|
          package_string = "  " + key + ": " + dependencies_data[key]
          file_data.insert(dependencies_index + 1, package_string)
        }

        file_data = file_data.join("\n")
        # UI.message("#{file_data}")
        File.write("#{path}pubspec.yaml", file_data)
        file.close
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
        #   FastlaneCore::ConfigItem.new(key: :api_token,
        #                                env_name: "FL_MODIFY_PUBSPEC_API_TOKEN", # The name of the environment variable
        #                                description: "API Token for ModifyPubspecAction", # a short description of this parameter
        #                                verify_block: proc do |value|
        #                                   UI.user_error!("No API token for ModifyPubspecAction given, pass using `api_token: 'token'`") unless (value and not value.empty?)
        #                                   # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
        #                                end),
          FastlaneCore::ConfigItem.new(key: :folder_name,
                                       env_name: "FL_MODIFY_FOLDER_NAME",
                                       description: "Enter the root path",
                                       default_value: "") # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['MODIFY_PUBSPEC_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
