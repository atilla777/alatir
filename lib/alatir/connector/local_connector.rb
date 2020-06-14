require 'open3'

module Alatir
  class LocalConnector < Connector
    def run_command(command_in_executor)
      if dependency_ok?
        std_out, std_error, process_status = Open3.capture3(command_in_executor)
        Result.new(
          activity: activity,
          errors: std_error.chomp,
          result: std_out.chomp,
          success: process_status.success?
        )
      else
        Result.new(
          activity: activity,
          dependency_chehck: false
        )
      end
    end

    private

    def platform_ok?
      activity.platforms.include? current_platform
    end

    def dependency_ok?
      true
    end

    def current_platform
      string = RbConfig::CONFIG['host_os']
      find_platform_in_string(string)
    end
  end
end
