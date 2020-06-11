module Alatir
  class AttackSimulation
    attr_reader :results

    def initialize
      options = cast_options
      @activity_names = options.fetch(:names, [])
      @activity_path = options.fetch(:path, nil)
      @results = []
    end

    def run
      @activity_names.each do |name|
        activity_config = FileLoader.new(name, @activity_path).run
        activity = Activity.new(activity_config)
        @results << LocalConnector.new(activity).run
      end
      print_results
    end

    private

    def cast_options
      option_parser = OptionParser.new do |opts|
        opts.on '-p', '--path=PATH', String, 'Path to activities folder (-p ./activities)'
        opts.on '-n', '--names=NAMES', Array, 'List of activities names (-n activity1, activityN)'
      end
      options = {}
      option_parser.parse!(into: options) # place ARGV to 'options' hash
      options
    end

    def print_results
      @results.each_with_index do |result, index|
        puts '*******************************'
        tactic = "(#{result.activity.tactic})" if result.activity.tactic
        puts "#{index + 1}. #{result.activity.name} #{tactic}"
        Colors.color_puts result.activity.command, :brown
        if result.result && result.result != ''
          puts '-------------------------------'
          Colors.color_puts result.result, :green
        end
        puts '-------------------------------'
        print_platform_check(result)
        print_dependency_check(result)
        print_errors(result)
        print_process_succes(result)
      end
      Colors.color_puts '********Alatir finished********', :blue
    end

    def print_platform_check(result)
      return if result.platform_check
      Colors.color_puts(
        "Platform check: #{result.platform_check}",
        :red
      )
    end

    def print_dependency_check(result)
      return if result.dependency_chehck
      Colors.color_puts(
        "Dependency check: #{result.dependency_chehck}",
        :red
      )
    end

    def print_errors(result)
      return if result.errors.nil? || result.errors.empty?
      Colors.color_puts(
        "Errors: #{result.errors}",
        :red
      )
    end

    def print_process_succes(result)
      return if result.success || result.success.nil?
      Colors.color_puts(
        "Process fineshed succes: #{result.success}",
        :red
      )
    end
  end
end
