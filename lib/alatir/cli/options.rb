module Alatir
  module Options
    COMMANDS = %i[simulate execute test create]

    private

    # alatir -a ./test -n sh_activity -c ssh -h localhost -u user -p password
    def cast_options
      option_parser = OptionParser.new do |opts|
        opts.on '-a', '--activities_path=ACTIVITIES_PATH', String, 'Path to activities folder (-a ./activities)'
        opts.on '-s', '--simulation_file=SIMULATION_FILE', String, 'Path to simulation file (-s simulation.yml)'
        opts.on '-n', '--names=NAMES', Array, 'List of activities names (-n activity1, activityN)'
        opts.on '-c', '--connector=CONNECTOR', 'Connector name (-c ssh)'
        opts.on '-h', '--host=HOST', 'Host for connector (-h 192.168.1.1)'
        opts.on '-u', '--user=USER', 'User for connector (-u test_user)'
        opts.on '-p', '--password=PASSWORD', 'Password for connector user (-p Passw@rd1)'
      end
      options = default_options
      option_parser.parse!(into: options) # place dashed (-o) ARGV to 'options' hash
      options
    end

    def default_options
      {
        activities_path: './activities',
        simulation_file: 'simulation.yml',
        names: []
      }
    end

    def cast_command
      return :execute if ARGV.length < 1
      if COMMANDS.include? ARGV.first.to_sym
        ARGV.first.to_sym
      else
        raise Errors.wrong_command(ARGV.first)
      end
    end
  end
end
