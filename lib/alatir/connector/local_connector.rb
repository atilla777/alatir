require 'open3'

module Alatir
  class LocalConnector < Connector

    def run_command(executor)
      if dependency_ok?
        std_out, std_error, process_status = Open3.capture3(
          executor.prepared_command
        )
        {
          std_error: std_error.chomp,
          std_out: std_out.chomp,
          success: process_status.success?
        }
      else
        {dependency_chehck: false}
      end
    end

    private

    def get_name
      :local
    end

    def used_options
      []
    end

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
