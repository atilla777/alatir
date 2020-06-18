module Alatir
  module Tools
    module_function

    # Take hash and convert all (include nestet hashes) string keys to symbol keys
    def symbolize_keys(x)
      if x.is_a? Hash
        x.inject({}) do |result, (key, value)|
          new_key = case key
                    when String then key.to_sym
                    else key
                    end
          new_value = case value
                      when Hash then symbolize_keys(value)
                      when Array then symbolize_keys(value)
                      else value
                      end
          result[new_key] = new_value
          result
        end
      elsif x.is_a? Array
        x.map {|el| symbolize_keys(el)}
      else
        x
      end
    end
  end
end
