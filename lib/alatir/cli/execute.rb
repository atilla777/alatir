module Alatir
  module Execute
    private

    # Run activities enumerated in -a option
    def execute
      files = activity_files(options[:names], options[:activities_path])
      execute_activities(files, options)
      print_results
    end
  end
end
