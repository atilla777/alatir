module Alatir
  class Activity
    attr_accessor :name
    attr_accessor :tactic
    attr_accessor :platforms
    attr_accessor :executor
    attr_accessor :command
    attr_accessor :description
    attr_accessor :result

    def initialize(options = {})
      @name = options['name']
      @tactic = options['tactic']
      @description = options['description']
      @platforms = options['platforms']
      @executor = options['executor']
      @command = options['command']
      @result = {
        platform_check: true, # Is platform (OS) apropriate to run activity command?
        dependency_check: true, # Is platform (OS) contains all needed soft to run activity command?
        error: nil, # Alatir error (connector ptoblem e.t.c.)
        std_out: nil, # activity command result - standard out
        std_error: nil,# activity command result - standard error
        success: nil # activity command result - is exit status code = 0 ?
      }
    end
  end
end
