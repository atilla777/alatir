module Alatir
  class Activity
    attr_accessor :platforms
    attr_accessor :executor
    attr_accessor :command

    def initialize(options = {})
      @platforms = options['platforms']
      @executor = options['executor']
      @command = options['command']
    end
  end
end
