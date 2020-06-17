module Alatir
  class Simulation
    attr_accessor :name
    attr_accessor :description
    attr_accessor :activities
    attr_accessor :targets

    def initialize(options = {})
      @name = options[:name]
      @description = options[:description]
      @activities = options[:activities]
      @targets = options[:targets]
    end
  end
end
