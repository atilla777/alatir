module Alatir
  class AttackSimulation
    attr_reader :results

    def initialize(activity_path, *activity_names)
      @activity_names = activity_names
      @activity_path = activity_path
      @results = []
    end

    def run
      @activity_names.each do |name|
        activity_config = FileLoader.new(name, @activity_path).run
        activity = Activity.new(activity_config)
        @results << LocalConnector.new(activity).run
      end
      @results
    end
  end
end
