require 'net/ssh'

module Alatir
  class SshConnector < Connector
    attr_reader :options

    def run_command(command_in_executor)
      return dependency_not_ok_result unless dependency_ok?

      # https://net-ssh.github.io/ssh/v1/chapter-1.html
      result = run_command_via_ssh(command_in_executor)

      session.close

      Result.new(
        activity: activity,
        errors: result[:std_error],
        result: result[:std_out],
        success: result[:exit_code] == 0
      )
    end

    private

    def session
      @session = Net::SSH.start(
        options[:endpoint],
        options[:user],
        password: options[:password]
      )
      @session
    end

    def run_command_via_ssh(command)
      result = {}
      channel = session.open_channel do |ch|
        ch.exec command do |ch, success|
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
        end
      end
      channel.wait
      result
    end

    def platform_ok?
      activity.platforms.include? current_platform
    end

    def current_platform
      result = run_command_via_ssh("sh -c 'uname -a'")
      return :unknown if result.fetch(:std_error, false)
      result = find_platform_in_string(result[:std_out])
      return result unless result == :unknown
      result = run_command_via_ssh("cmd /c 'ver'")
      return :unknown if result.fetch(:std_error, false)
      find_platform_in_string(result[:std_out])
    end

    def dependency_ok?
      true
    end
  end
end
