module Alatir
  class Result
    attr_reader :platform_check
    attr_reader :dependency_chehck
    attr_reader :result
    attr_reader :errors
    attr_reader :success

    def initialize(params = {})
      @platform_check = params.fetch(:platform_check, true)
      @dependency_chehck = params.fetch(:dependency_chehck, true)
      @result = params.fetch(:result, nil)
      @errors = params.fetch(:errors, nil)
      @success = params.fetch(:success, false)
    end
  end
end
