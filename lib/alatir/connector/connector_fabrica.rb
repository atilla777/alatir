module Alatir
  class ConnectorFabrica
    attr_reader :activity
    attr_reader :options

    def initialize(activity, options)
      @activity = activity
      @options = options
    end

    def run
      send options.fetch(:connector, :localhost).to_sym, activity
    end


    private

    def winrm(activity)
      WinrmConnector.new(
        activity,
        endpoint: options[:host], # http://localhost:5985/wsman
        user: options[:user],
        password: options[:secret]
      )
    end

    def ssh(activity)
      SshConnector.new(
        activity,
        endpoint: options[:host], # 192.168.1.1
        user: options[:user],
        password: options[:secret]
      )
    end

    def localhost(activity)
      LocalConnector.new(activity)
    end
  end
end
