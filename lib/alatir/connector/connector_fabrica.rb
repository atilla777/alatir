module Alatir
  class ConnectorFabrica
    def self.make(activity, options)
      self.new.execute(activity, options)
    end

    def execute(activity, options)
#      connector_name = if options[:connector]
#                       elsif options['connector']
#                         options['connector'].to_sym
#                       else
#                         :localhost
#                       end
#      send connector_name, activity, options
      send options.fetch(:connector, :localhost).to_sym, activity, options
    end

    private

    def winrm(activity, options)
      WinrmConnector.new(
        activity,
        endpoint: options[:host], # http://localhost:5985/wsman
        user: options[:user],
        password: options[:password]
      )
    end

    def ssh(activity, options)
      SshConnector.new(
        activity,
        endpoint: options[:host], # 192.168.1.1
        user: options[:user],
        password: options[:password]
      )
    end

    def localhost(activity, options)
      LocalConnector.new(activity)
    end
  end
end
