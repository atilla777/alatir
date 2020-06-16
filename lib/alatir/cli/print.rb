module Alatir
  module Print
    private

    def print_results
      #@results.each_with_index do |result, index|
      @activities.each_with_index do |activity, index|
        puts '*******************************'
        tactic = "(#{activity.tactic})" if activity.tactic
        puts "#{index + 1}. #{activity.name} #{tactic}"
        Colors.color_puts activity.command, :brown
        if activity.result[:std_out] && activity.result.fetch(:std_out, '') != ''
          puts '-------------------------------'
          Colors.color_puts activity.result.fetch(:std_out, ''), :green
        end
        puts '-------------------------------'
        print_platform_check(activity.result)
        print_dependency_check(activity.result)
        print_std_error(activity.result)
        print_process_succes(activity.result)
        print_error(activity.result)
      end
      Colors.color_puts '********Alatir finished********', :blue
    end

    def print_platform_check(result)
      return if result[:platform_check]
      Colors.color_puts(
        "Platform check: #{result[:platform_check]}",
        :red
      )
    end

    def print_dependency_check(result)
      return if result[:dependency_check]
      Colors.color_puts(
        "Dependency check: #{result[:dependency_check]}",
        :red
      )
    end

    def print_std_error(result)
      return if result[:std_error].nil? || result[:std_error].empty? || result[:std_error] == ' '
      Colors.color_puts(
        "Errors: #{result[:std_error]}",
        :red
      )
    end

    def print_process_succes(result)
      return if result[:success] || result[:success].nil?
      Colors.color_puts(
        "Process finished succes: #{result[:success]}",
        :red
      )
    end
    def print_error(result)
      return unless result[:error]
      Colors.color_puts(
        "Error: #{result[:error]}",
        :red
      )
    end
  end
end
