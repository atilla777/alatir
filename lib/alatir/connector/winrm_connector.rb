require 'winrm'

module Alatir
  class WinrmConnector < Connector
    attr_reader :options

    def run_command(command_in_executor)
      if dependency_ok?
        connection = WinRM::Connection.new(options)
        connection.shell(get_shell) do |shell|
          output = shell.run(command_in_executor) # do |stdout, stderr|
#            std_out = stdout
#            std_err = stderr
          #end
          @result = Result.new(
            activity: activity,
            errors: output.stderr.chomp,
            result: output.stdout.chomp,
            success: output.exitcode == 1
          )
        end
      else
        @result = Result.new(
          activity: activity,
          dependency_chehck: false
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
