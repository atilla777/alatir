module Alatir
  class Executor
    attr_reader :connector
    attr_reader :activity

    def initialize(connector, activity)
      @connector = connector
      @activity = activity
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
