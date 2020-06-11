module Alatir
  class PsExecutor < Executor
    private

    def command_in_executor
      "powershell.exe iex #{activity.command}"
    end
  end
end
