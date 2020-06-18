module Alatir
  class Connector
    attr_reader :activity
    attr_reader :options
    attr_reader :name
    attr_reader :connector

    def initialize(activity, options = {})
      @activity = activity
      @name = get_name
      @activity.connector = self
      @options = get_options(options)
    end

    def run
      return activity.result.merge!(platform_check: false) unless platform_ok?
      result = run_command(executor)
      result[:timestamp] = Time.now
      activity.result.merge!(result)
    rescue StandardError => e
      connector_error_result(e)
    end

    private

    def get_name
      Errors.not_implemented
    end

    def get_options(opts)
      opts.select { |opt_name, opt_value| used_options.include? opt_name }
    end

    def used_options
      Errors.not_implemented
    end

    def platform_ok?
      Errors.not_implemented
    end

    def dependency_ok?
      Errors.not_implemented
    end

    def dependency_not_ok_result
      activity.result.merge!(dependency_chehck: false)
    end

    def connector_error_result(e)
      activity.result.merge!(error: e)
    end

    def executor
      ExecutorFabrica.make(activity, self)
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
