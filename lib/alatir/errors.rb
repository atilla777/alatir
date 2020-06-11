module Alatir
  module Errors
    module_function

    def not_implemented
      raise(
        NotImplementedError,
        "#{self.class} has not implemented method '#{__method__}'"
      )
    end

    def unknown_executor(executor)
      raise(
        NotImplementedError,
        "#{self.class} don`t know executor '#{executor}'"
      )
    end
  end
end
