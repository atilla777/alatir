module Alatir
  class SimulationFileLoader
    def initialize(activity_path)
      @activity_path = activity_path
    end

    def run
      yaml = YAML::load_file(@activity_path)
      Tools.symbolize_keys(yaml)
    end
  end
end
