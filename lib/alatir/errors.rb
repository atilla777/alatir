module Alatir
  module Errors
    module_function

    def wrong_command(command)
      raise(
        ArgumentError,
        "Don`t know command '#{command}'"
      )
    end

    def not_implemented
      raise(
        NotImplementedError,
        "#{self.class} has not implemented method '#{__method__}'"
      )
    end

    def unknown_executor(executor)
      raise(
        StandardError,
        "#{self.class} don`t know executor '#{executor}'"
      )
    end

    def wrong_executor_for_connector(executor, platform)
      raise(
        StandardError,
        "#{self.class} wrong executor (#{executor}) for platform (#{platform})"
      )
    end
  end
end
