module Alatir
  class ExecutorFabrica
    def self.make(activity, connector)
      case activity.executor.to_sym
      when :cmd
        CmdExecutor.new(activity, connector)
      when :powershell
        PsExecutor.new(activity, connector)
      when :sh
        ShExecutor.new(activity, connector)
      else
        Errors.unknown_executor(activity.executor)
      end
    end
  end
end
