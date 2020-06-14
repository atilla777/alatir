module Alatir
  class Connector
    attr_reader :activity

    def initialize(activity, options = {})
      @activity = activity
      @options = options
    end

    def run
      return executor.run if platform_ok?
      Result.new(activity: activity, platform_check: false)
    end

    private

    def dependency_ok?
      Errors.not_implemented
    end

    def dependency_not_ok_result
        @result = Result.new(
          activity: activity,
          dependency_chehck: false
        )
    end

    def platform_ok?
      Errors.not_implemented
    end

    def executor
      ExecutorFabrica.new(activity, self).run
    end

    def run_command
      Errors.not_implemented
    end

    def find_platform_in_string(string)
      case string
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/i
        'windows'
      when /darwin|mac os/i
        'macos'
      when /linux/i
        'linux'
      when /solaris/i
        'solaris'
      when /bsd/i
        'bsd'
      else
        :unknown
      end
    end
  end
end
