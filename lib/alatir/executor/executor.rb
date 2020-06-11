module Alatir
  class Executor
    attr_reader :activity
    attr_reader :connector

    def initialize(activity, connector)
      @activity = activity
      @connector = connector
    end

    def run
      connector.run_command(command_in_executor)
    end

    private

    def command_in_executor
      Errors.not_implemented
    end
  end
end
