require 'alatir/version'

require 'yaml'
#require 'optparser'

module Alatir
  class Loader
    attr_reader :checks

    def initialize(cheks_names, checks_path)
      @checks_names = get_checks(checks)
      @checks_path = checks_path
    end

    def run(name)
      check_file = File.join(@checks_path, "#{name}.yml")
      @checks << YAML.safe_load(check_file)
    end
  end

  class AttackSimulation
    def initialize(checks_names)
      @checks_names = @checks_names
      @resuls = []
    end

    def run
      @checks_names.each do |check_name|
        check_config = Alatir::Loader.new(
          check_name,
          checks_path).run
          @resuls << Check.new(check_config).run
      end
      @resuls
    end
  end

  class Executor
    def initialize(connector, command)
      @command = command
    end

    def run
      connector.run(command)
    end

    private

    def command; end
  end

  class CmdExecutor < Executor
    private

    def command
      "cmd.exe /c #{@command}"
    end
  end

  class Connector
    def initialize(command)
      @command = command
    end

    def run
      connection
    end

    private

   def connection; end
  end

  class SshConnector < Connector
    private

    def connection

    end
  end

  class LocalConnector < Connector
    require 'open3'

    private

    def connection
      Open3.capture3(@command)
    end
  end

  class WinrmConnector < Connector
    require 'winrm'

    private

    def connection

    end
  end


  class Check
    EXECUTORS = {
      'cmd' => 'CmdExecutor',
      'sh' => 'ShExecutor',
      'bash' => 'BashExecutor',
      'powershell' => 'PowershellExecutor'
    }

    ResultStruct = Struct.new(
      :platform_check,
      :dependency_chehck,
      :result,
      :errors,
      :succes
    )

    attr_accessor :result

    def initialize(config)
      @config = config
      @executor = executor
      @result = ResultStruct.new
    end

    def run
      unless @config['platforms'].include? current_platform
        @result.platform_check = false
        return @result
      end
      @result.result, @result.errors, @result.success = @executor.run(@config['command'])
      @result
    end

    private

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

    def executor
      EXECUTORS.fetch(@config['executor'], nil)
               .constantize
    end
  end
end

p Alatir::AttackSimulation.new('T003', './').run
