require 'net/ssh'

module Alatir
  class SshConnector < Connector
    attr_reader :options

    def run_command(executor)
      return dependency_not_ok_result unless dependency_ok?
      # https://net-ssh.github.io/ssh/v1/chapter-1.html
      result = run_command_via_ssh(executor.prepared_command)
      session.close
      {
        std_error: result[:std_error],
        std_out: result[:std_out],
        success: result[:exit_code] == 0
      }
    end

    private

    def session
      if @session
        @session
      else
        @session = Net::SSH.start(
          options[:endpoint],
          options[:user],
          password: options[:password],
          non_interactive: true
        )
        @session
      end
    end

    def run_command_via_ssh(command)
      result = {}
      channel = session.open_channel do |cha| # channel = cha = ch = _c
        cha.exec command do |ch, success|
          # "on_data" is called when the process writes something to stdout
          ch.on_data do |_c, data|
            result[:std_out] = data.chomp
          end

          # "on_extended_data" is called when the process writes something to stderr
          ch.on_extended_data do |_c, type, data|
            result[:std_error] = data.chomp
          end

          #exit code
          #http://groups.google.com/group/comp.lang.ruby/browse_thread/thread/a806b0f5dae4e1e2
          ch.on_request('exit-status') do |_c, data|
            result[:exit_code] = data.read_long
          end
        end
      end
      channel.wait
      result
    end

    # TODO: use this method
    def run_sudo_command_via_ssh(command, password)
      result = {}
      channel = session.open_channel do |cha| # channel = cha = ch = _c
        # "on_data" is called when the process writes something to stdout
        cha.on_data do |c, data|
          if data =~ /^\[sudo\] password for /
            c.send_data "#{password}\n"
          else
            result[:std_out] = data.chomp
          end
        end

        # "on_extended_data" is called when the process writes something to stderr
        cha.on_extended_data do |_c, type, data|
          result[:std_error] = data.chomp
        end

        #exit code
        #http://groups.google.com/group/comp.lang.ruby/browse_thread/thread/a806b0f5dae4e1e2
        cha.on_request('exit-status') do |_c, data|
          result[:exit_code] = data.read_long
        end
        cha.request_pty
        cha.exec command
        cha.wait
      end
      channel.wait
      result
    end

    def platform_ok?
      activity.platforms.include? current_platform.to_s
    end

    def current_platform
      result = run_command_via_ssh("sh -c 'uname -a'")
      result = find_platform_in_string(result[:std_out])
      return result unless result == :unknown
      result = run_command_via_ssh("dir")
      return 'windows' if result[:exit_code] == 0
      :unknown
    end

    def dependency_ok?
      true
    end
  end
end
