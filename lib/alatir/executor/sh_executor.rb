module Alatir
  class ShExecutor < Executor
    private

    def prepare_command
      @prepared_command = "sh -c '#{activity.command}'"
    end
  end
end
