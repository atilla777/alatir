module Alatir
  class CmdExecutor < Executor
    private

    def prepare_command
      @prepared_command = "cmd.exe /c #{activity.command}"
    end
  end
end
