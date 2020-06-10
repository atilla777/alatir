module Alatir
  class CmdExecutor < Executor
    private

    def command_in_executor
      "cmd.exe /c #{activity.command}"
    end
  end
end
