module Alatir
  class Connector
    attr_reader :activity

    def initialize(activity)
      @activity = activity
    end

    def run
      if platform_ok?
        executor.run
      else
        Result.new(platform_check: false)
      end
    end

    private

    def dependency_ok?
      Errors.not_implemented
    end

    def platform_ok?
      Errors.not_implemented
    end

    def executor
      ExecutorFabrica.new(activity, self)
    end

    def run_command
      Errors.not_implemented
    end
  end
end
