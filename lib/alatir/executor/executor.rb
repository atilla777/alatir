module Alatir
  class Executor
    attr_reader :activity
    attr_reader :connector
    attr_reader :prepared_command

    def initialize(activity, connector)
      @activity = activity
      @connector = connector
      prepare_command
    end

    def run
      connector.run_command(self)
    end

    private

    def command_in_executor
      Errors.not_implemented
    end

    def prepare_command
      Errors.not_implemented
    end
  end
end
