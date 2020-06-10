module Alatir
  class FileLoader
    attr_reader :activity_path, :activity_name

    def initialize(activity_name, activity_path)
      @activity_name = activity_name
      @activity_path = activity_path
    end

    def run
      activity_file = File.join(activity_path, "#{activity_name}.yml")
      YAML::load_file(activity_file)
    end
  end
end
