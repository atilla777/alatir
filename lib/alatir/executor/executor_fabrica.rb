module Alatir
  class ExecutorFabrica
    attr_reader :activity
    attr_reader :connector

    def initialize(activity, connector)
      @activity = activity
      @connector = connector
    end

    def run
      case activity.executor.to_sym
      when :cmd
        CmdExecutor.new(activity, connector)
      when :powershell
        PSExecutor.new(activity, connector)
      when :sh
        ShExecutor.new(activity, connector)
      else
        Errors.unknown_executor(activity.executor)
      end
    end
  end
end
