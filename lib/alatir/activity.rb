module Alatir
  class Activity
    attr_accessor :name
    attr_accessor :tactic
    attr_accessor :platforms
    attr_accessor :executor
    attr_accessor :command
    attr_accessor :description

    def initialize(options = {})
      @name = options['name']
      @tactic = options['tactic']
      @description = options['description']
      @platforms = options['platforms']
      @executor = options['executor']
      @command = options['command']
    end
  end
end
