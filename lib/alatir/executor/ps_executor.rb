module Alatir
  class PsExecutor < Executor
    private

    def prepare_command
      @prepared_command = "powershell.exe iex '#{activity.command}'"
    end
  end
end
