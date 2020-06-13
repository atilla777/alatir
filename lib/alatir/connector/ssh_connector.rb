require 'net/ssh'

module Alatir
  class SshConnector < Connector
    attr_reader :options

    def run_command(command_in_executor)
      if dependency_ok?
        Net::SSH.start(
          options[:endpoint],
          options[:user],
          password: options[:password]
        ) do |ssh|
          result = {}
          channel = ssh.open_channel do |ch|
            ch.exec command_in_executor do |ch, success|
              raise "could not execute command" unless success

              # "on_data" is called when the process writes something to stdout
              ch.on_data do |c, data|
                result[:std_out] = data.chomp
              end

              # "on_extended_data" is called when the process writes something to stderr
              ch.on_extended_data do |c, type, data|
                result[:std_error] = data.chomp
              end

              #exit code
              #http://groups.google.com/group/comp.lang.ruby/browse_thread/thread/a806b0f5dae4e1e2
              channel.on_request('exit-status') do |ch, data|
                result[:exit_code] = data.read_long
              end

  #            channel.on_request("exit-signal") do |ch, data|
  #              puts "SIGNAL: #{data.read_long}"
  #            end
            end
          end

          channel.wait


#          res = ssh.exec! command_in_executor do |ch, stream, data|
#            if stream == :stderr
#              result[:errors] = data
#            else
#              result[:result] = data
#            end
#          end

          @result = Result.new(
            activity: activity,
            errors: result[:std_error],
            result: result[:std_out],
            success: result[:exit_code] == 0
          )

#          result = ssh.exec!(command_in_executor)
#          @result = Result.new(
#            activity: activity,
#            #errors: output.stderr.chomp,
#            result: result.chomp,
#            success: result.exitstatus == 0
#          )
#          result = ssh.exec!(command_in_executor) do |channel, stream, data|
#            #stdout << data if stream == :stdout && /foo/.match(data)
#            @result = Result.new(
#              activity: activity,
#              errors: output.stderr.chomp,
#              result: output.stdout.chomp,
#              success: output.exitcode == 1
#            )
#          end
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
