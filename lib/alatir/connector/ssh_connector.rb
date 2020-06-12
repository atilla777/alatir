require 'net/ssh'

module Alatir
  class SshConnector < Connector
    attr_reader :options

    def run_command(command_in_executor)
      if dependency_ok?
        Net::SSH.start('host', 'user', password: "password") do |ssh|
          enssh.exec!("ls -l /home/jamis") do |channel, stream, data|
            stdout << data if stream == :stdout && /foo/.match(data)
            @result = Result.new(
              activity: activity,
              errors: output.stderr.chomp,
              result: output.stdout.chomp,
              success: output.exitcode == 1
            )
          end
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

    def platform_ok?
      true
    end

    def dependency_ok?
      true
    end
  end
end
