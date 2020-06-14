require 'winrm'

module Alatir
  class WinrmConnector < Connector
    attr_reader :options

    def run_command(command_in_executor)
      return dependency_not_ok_result unless dependency_ok?
      connection = WinRM::Connection.new(options)
      connection.shell(get_shell) do |shell|
        output = shell.run(command_in_executor)
        @result = Result.new(
          activity: activity,
          errors: output.stderr.chomp,
          result: output.stdout.chomp,
          success: output.exitcode == 1
        )
      end
      @result
    end

    private

    def get_shell
      case activity.executor.to_sym
      when :powershell
        :powershell
      when :cmd
        :cmd
      else
        wrong_executor_for_connector(activity.executor, activity.platforms)
      end
    end

    def platform_ok?
      activity.platforms.include? 'windows'
    end

    def dependency_ok?
      true
    end
  end
end
