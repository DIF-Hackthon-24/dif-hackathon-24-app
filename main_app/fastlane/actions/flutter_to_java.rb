require 'fileutils'

module Fastlane
  module Actions
    module SharedValues
      FLUTTER_TO_JAVA_CUSTOM_VALUE = :FLUTTER_TO_JAVA_CUSTOM_VALUE
    end

    class FlutterToJavaAction < Action

      def self.is_this_class_name(line)
          if line.include?("class")
            return true
          end

          return false
      end

      def self.string_between_markers(string, marker1, marker2)
        string[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
      end

      def self.write_data_classes(lines)
        new_file_data = ""
        is_json_serializable_class = false
        class_name = ""

        ignore_lines = false

        lines.each_with_index { |line, idx|
          puts "line #{line}"
          if ignore_lines
            if line.include?("}")
              ignore_lines = false
            end
          else
            if is_this_class_name(line)
              new_file_data += line + "\n"
            elsif line.include?("@JsonSerializable")
              is_json_serializable_class = true
              new_file_data += "\n"

              class_name_line = lines[idx + 1]
              class_name_line_split = class_name_line.split(" ")

              if class_name_line_split != nil && class_name_line_split.length > 1
                class_name = class_name_line_split[1]
              end

              puts "class_name #{class_name}, class_name_line #{class_name_line}, class_name_line_split #{class_name_line_split}"
            else
              create_line = line
              if line.include?("}") && is_json_serializable_class
                is_json_serializable_class = true
              end

              if is_json_serializable_class
                if line.include?("@JsonKey")
                  create_line = line.gsub("@JsonKey", "@SerializedName")
                elsif line.include?("_$" + class_name)
                  create_line = ""
                elsif line.include?(class_name) 
                  # this is the class constructor
                  ignore_lines = true
                  create_line = ""
                else
                  split_line = line.split(" ")

                  if split_line != nil && split_line.length > 1
                    write_word = split_line[1].gsub(";", "")
                    new_file_data += "@SerializedName(" + '"' + write_word + '"' + ")\n"
                  end
                end
              end

              new_line = create_line.gsub("late", "")
              new_line = create_line.gsub("@override", "@Override")
              new_file_data += new_line + "\n"
            end
          end
        }
        new_file_data
      end

      def self.fileList(package_pattern, file_pattern, package_name, generated_folder_path, root_folder_name)
        files_list = Dir.entries(root_folder_name)
        files_list = files_list.reject { |file|
          file == "." || file == ".."
        }
        UI.message "files_list #{files_list}"
          
        files_list.each { |file|
          if File.directory?("#{root_folder_name}/#{file}")
            fileList(package_pattern, file_pattern, package_name, "#{generated_folder_path}/#{file}", "#{root_folder_name}/#{file}")
          elsif file.include?(".g.") == false && file.end_with?(".dart")

            # UI.message "root_folder_name #{root_folder_name}"

            folder_pattern_list = package_pattern.split(",")
            folder_pattern_list.each { |folder_pattern_element|

              if root_folder_name.include?(folder_pattern_element) 

                patterns_list = file_pattern.split(",")
                patterns_list.each { |pattern|
                  if file.end_with?(pattern)
                    FileUtils.mkdir_p("#{generated_folder_path}")
                    writeFile(package_name, generated_folder_path, "#{root_folder_name}/#{file}")
                  end
                }
              end
            }
          end
        }
      end

      def self.findVariableName(variable)
        variable_name_split = variable.split(" ")
        variable_name = variable_name_split[1]
        variable_name = variable_name.gsub(";", "")
        variable_name
      end

      def self.writeVariables(variable)
        new_file_data = ""

        variable_name = findVariableName(variable)       
        new_file_data += "@SerializedName(" + '"' + variable_name + '"' + ")\n"
        new_file_data += variable + "\n"
        new_file_data
      end 

      def self.mandatory_constructor(variables_list)
        new_file_data = ""

        variables_list.each_with_index { |variable, idx|
          constructor_parameters = variable.gsub(";", ",\n")
          if idx == variables_list.length-1
            constructor_parameters = constructor_parameters.gsub(",", "")
          end
          new_file_data += constructor_parameters
        }

        new_file_data
      end

      def self.get_variables_names(variables_list)
        new_file_data = ""

        variables_list.each_with_index { |variable, idx|
          variable_name = findVariableName(variable) 
          new_file_data += variable_name
          if idx != variables_list.length-1
            new_file_data += ","
          end
        }

        new_file_data
      end

      def self.optional_variables_names_with_null(variables_list)
        new_file_data = ""

        variables_list.each_with_index { |variable, idx|
          new_file_data += "null"
          if idx != variables_list.length-1
            new_file_data += ","
          end
        }

        new_file_data
      end

      def self.add_this_variable_assignment(variables_list)
        new_file_data = ""

        variables_list.each_with_index { |variable, idx|
          variable_name = findVariableName(variable)
          new_file_data += "\tthis." + variable_name + " = " + variable_name + ";\n"
        }

        new_file_data
      end

      def self.writeFile(package_name, generated_folder_path, file)
        # puts "writeFile #{file}"  

        file_name = File.basename(file, File.extname(file))
          
        new_file_data = ""
        file_data = File.read(file)

        delimiters = ["\n"]
        lines = file_data.split(Regexp.union(delimiters))

        is_serializale_class = false
        extends_base_class_name = ""
        implements_base_class_name = ""
        class_name = ""
        optional_class_variables = []
        mandatory_class_variables = []

        puts "class_name : #{class_name.length}"

        lines.each_with_index { |line, idx|
          if class_name.length > 0
            if line.include?("}")
              new_file_data += "class " + class_name + " "

              if extends_base_class_name.length > 0
                new_file_data +=  " extends " + extends_base_class_name  + "\n"
              elsif implements_base_class_name.length > 0
                new_file_data += " implements " + implements_base_class_name  + "\n"
              else
                new_file_data += "{\n"
              end

              optional_class_variables.each { |variable|
                new_file_data += writeVariables(variable)
              }

              mandatory_class_variables.each { |variable|
                new_file_data += writeVariables(variable)
              }

              # Create constructor with all variables
              new_file_data += class_name + "(\n"
              new_file_data += mandatory_constructor(mandatory_class_variables)
              if mandatory_class_variables.length > 0 && optional_class_variables.length > 0
                new_file_data += ","
              end
              new_file_data += mandatory_constructor(optional_class_variables)
              new_file_data += ")\n"

              # Now add this parameter for the variables
              new_file_data += "{\n"
              new_file_data += add_this_variable_assignment(mandatory_class_variables)
              new_file_data += add_this_variable_assignment(optional_class_variables)
              new_file_data += "}\n"

              # Create constructor with mandatory variables
              # create only if there are optional variables, else we have already create a constructor above
              if mandatory_class_variables.length > 0 && optional_class_variables.length > 0
                new_file_data += class_name + "(\n"
                new_file_data += mandatory_constructor(mandatory_class_variables)
                new_file_data += ")\n"

                new_file_data += "{\n"
                new_file_data += class_name + "("
                new_file_data += get_variables_names(mandatory_class_variables)
                new_file_data += optional_variables_names_with_null(optional_class_variables)
                new_file_data += ");\n"
                # new_file_data += add_this_variable_assignment(mandatory_class_variables)
                # new_file_data += add_this_variable_assignment(optional_class_variables)
                new_file_data += "}\n"
              end

              # end the class
              new_file_data += "}\n"
              class_name = ""
              implements_base_class_name = ""
              extends_base_class_name = ""
              is_serializale_class = false
              optional_class_variables = []
              mandatory_class_variables = []

            elsif line.include?(";") && line.include?(class_name) == false && line.include?("fromJson") == false
              if line.include?("?")
                variable = line.gsub("?", "")
                variable = variable.gsub("late", "")
                optional_class_variables.append(variable)
              else
                variable = line.gsub("?", "")
                variable = variable.gsub("late", "")
                mandatory_class_variables.append(variable)
              end
            end
          elsif line.include?("class")
            class_name_line_split = line.split(" ")
            if class_name_line_split != nil && class_name_line_split.length > 1
              class_name = class_name_line_split[1]
            end
            
            implements_line_split = line.split("implements")
            if implements_line_split != nil && implements_line_split.length > 1
              implements_base_class_name = implements_line_split[1]
            else
              implements_line_split = line.split("extends")
              if implements_line_split != nil && implements_line_split.length > 1
                extends_base_class_name = implements_line_split[1]
              end
            end

            if idx > 0
              previous_line = lines[idx - 1]
              if previous_line.include?("@JsonSerializable")
                is_serializale_class = true
              end
            end
          end
        }
            
        file_path = generated_folder_path + "/" + file_name + ".java"

        File.open(file_path, "w+") { |generatedFile|
          generated_folder_path = generated_folder_path.gsub("/", ".")
          new_file_data.insert(0, "package " + package_name + "." + generated_folder_path + ";\n\n")
          generatedFile.write(new_file_data) 
        }

      end

      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        # UI.message "Parameter API Token: #{params[:api_token]}"

        package_name = params[:package_name]
        UI.message "package_name #{package_name}"

        folder_name = params[:folder_name]
        UI.message "path #{folder_name}"

        # path = "network_manager/app-mobile-networkmanager/src/lib"

        file_pattern = params[:file_pattern]
        UI.message "file_pattern #{file_pattern}"

        package_pattern = params[:package_pattern]
        UI.message "package_pattern #{package_pattern}"

        sh 'pwd'

        generated_folder_path = "CodeGenerated"

        if Dir.exist?(generated_folder_path)
          FileUtils.rm_r(generated_folder_path)
        end
        Dir.mkdir(generated_folder_path)
        fileList(package_pattern, file_pattern, package_name, generated_folder_path, folder_name)

        Dir.glob(generated_folder_path + "/**/*").select { |d| 
          File.directory?(d)
        }.reverse_each { |d| 
          if ((Dir.entries(d) - %w[ . .. ]).empty?)
            Dir.rmdir(d)
          end
        }

        # java_project_path = "Java_Test/app/src/Core"

        # if Dir.exist?(java_project_path)
        #   FileUtils.rm_r(java_project_path)
        # end
        # FileUtils.mkdir_p(java_project_path)
        # FileUtils.cp_r(generated_folder_path, java_project_path)
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
          FastlaneCore::ConfigItem.new(key: :file_pattern,
                                       env_name: "FL_FILE_PATTERN",
                                       description: "Enter the file pattern",
                                       default_value: ""), # the default value if the user didn't provide one,
          FastlaneCore::ConfigItem.new(key: :folder_name,
                                       env_name: "FL_FOLDER_NAME",
                                       description: "Enter the folder name",
                                       default_value: ""), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :package_name,
                                       env_name: "FL_PACKAGE_NAME",
                                       description: "Enter the package name",
                                       default_value: ""), # the default value if the user didn't provide one,
          FastlaneCore::ConfigItem.new(key: :package_pattern,
                                       env_name: "FL_PACKAGE_PATTERN",
                                       description: "Enter the package pattern",
                                       default_value: "") # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['FLUTTER_TO_JAVA_CUSTOM_VALUE', 'A description of what this value contains']
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
