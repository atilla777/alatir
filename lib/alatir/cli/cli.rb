require 'optparse'
require 'yaml'

require 'alatir/cli/options'
require 'alatir/cli/activity_file_loader'
require 'alatir/cli/simulation_file_loader'
require 'alatir/cli/print'
require 'alatir/cli/colors'
require 'alatir/tools'

module Alatir
  class Cli
    include Options
    include Colors
    include Print

    attr_reader :results
    attr_reader :options

    def initialize
      @options = cast_options
      @command = cast_command
      @activities = []
    end

    def run
      self.send(@command)
    end

    # Run activities described in simulation file
    def simulate
      simulation_config = SimulationFileLoader.new(options[:simulation_file])
                                              .run
      @simulation = Simulation.new(simulation_config)
      @simulation.targets.each do |target|
        execute_on_target target
      end
      print_results
    end

    # Run activities enumerated in -a option
    def execute
      files = activity_files(options[:names], options[:activities_path])
      execute_activities(files, options)
      print_results
    end

    # Check activity file
    def test
    end

    # Create activity file
    def create
    end

    private

    def execute_on_target(target)
      target_activities = @simulation.activities.select do |activity|
        activity[:target] == target.keys.first.to_s
      end
      target_activities.each do |activity|
        activity
      end
      names = target_activities.map { |activity| activity[:name] }
      names = names.reject { |name| name.blank? }
      files = activity_files(names, options[:activities_path])
      execute_activities(files, target[target.keys.first])
    end

    # Execute activities on target (target config in opt hash)
    def execute_activities(files, opt)
      files.each do |path|
        activity_config = ActivityFileLoader.new(path).run
        activity = Activity.new(activity_config)
        @activities << activity
        ConnectorFabrica.make(activity, opt).run
      end
    end

    # Find activity files in "-path" subfolders recursive
    def activity_files(activity_names, activities_path)
      Dir.glob("#{activities_path}/**/*.yml").select do |path|
        activity_names.any? { |name| path.include?("#{name}.yml") }
      end
    end
  end
end
