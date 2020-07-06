module Alatir
  module Simulate
    private

    # Run activities described in simulation file
    def simulate
      simulation_config = SimulationFileLoader.new(options[:simulation_file])
        .run
      @simulation = Simulation.new(simulation_config)
      @simulation.targets.each do |target|
        run_activity_on target
      end
      print_results
    end

    def run_activity_on(target)
      # Group activities by target
      target_activities = @simulation.activities.select do |activity|
        activity[:target] == target[:name]
      end
      names = target_activities.map { |activity| activity[:name] }
      names = names.reject { |name| name.blank? }
      files = activity_files(names, options[:activities_path])
      execute_activities(files, target)
    end
  end
end
