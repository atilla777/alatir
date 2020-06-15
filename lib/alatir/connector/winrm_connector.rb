require 'winrm'

module Alatir
  class WinrmConnector < Connector
    attr_reader :options

    def run_command(executor)
      return dependency_not_ok_result unless dependency_ok?
      connection = WinRM::Connection.new(options.merge(no_ssl_peer_verification: true))
      connection.shell(get_shell) do |shell|
        output = shell.run(executor.prepared_command)
        @result = {
          std_error: output.stderr.chomp,
          std_out: output.stdout.chomp,
          exit_code: output.exitcode == 1
        }
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
