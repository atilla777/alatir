require 'open3'

module Alatir
  class LocalConnector < Connector

    private

    def run_command(command_in_executor)
      if dependency_ok?
        std_out, std_error, exit_code = Open3.capture3(command_in_executor)
        result = Result.new(
          errors: std_error,
          result: std_out,
          success: exit_code.true?
        )
      else
        result = Result.new(
          dependency_chehck: false
        )
      end
      result
    end

    def platform_ok?
      activity.platforms.include? current_platform
    end

    def dependency_ok?
      true
    end

    def current_platform
      case RbConfig::CONFIG['host_os']
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        'windows'
      when /darwin|mac os/
        'macos'
      when /linux|solaris|bsd/
        'linux'
      end
    end
  end
end
