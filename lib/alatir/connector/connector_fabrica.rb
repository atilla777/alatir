module Alatir
  class ConnectorFabrica
    def self.make(activity, options)
      self.new.execute(activity, options)
    end

    def execute(activity, options)
      send options.fetch(:connector, :localhost).to_sym, activity, options
    end

    private

    def winrm(activity, options)
      WinrmConnector.new(
        activity,
        host: options[:host], # http://localhost:5985/wsman
        user: options[:user],
        password: options[:password]
      )
    end

    def ssh(activity, options)
      SshConnector.new(
        activity,
        host: options[:host], # 192.168.1.1
        user: options[:user],
        password: options[:password]
      )
    end

    def localhost(activity, options)
      LocalConnector.new(activity)
    end
  end
end
