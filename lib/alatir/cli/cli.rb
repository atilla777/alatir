require 'optparse'
require 'yaml'
require "csv"

require 'alatir/cli/options'
require 'alatir/cli/activity_file_loader'
require 'alatir/cli/simulation_file_loader'
require 'alatir/cli/execute'
require 'alatir/cli/simulate'
require 'alatir/cli/print'
require 'alatir/cli/colors'
require 'alatir/tools'

module Alatir
  class Cli
    include Options
    include Colors
    include Print
    include Simulate
    include Execute

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

    # Check activity file
    def test
    end

    # Create activity file
    def create
    end

    private

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
