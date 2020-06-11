module Alatir
  class ShExecutor < Executor
    private

    def command_in_executor
      "sh -c '#{activity.command}'"
    end
  end
end
