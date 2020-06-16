require 'alatir/version'

require 'alatir/connector/connector_fabrica'
require 'alatir/connector/connector'
require 'alatir/connector/local_connector'
require 'alatir/connector/winrm_connector'
require 'alatir/connector/ssh_connector'

require 'alatir/executor/executor_fabrica'
require 'alatir/executor/executor'
require 'alatir/executor/cmd_executor'
require 'alatir/executor/sh_executor'
require 'alatir/executor/ps_executor'

require 'alatir/activity'
require 'alatir/simulation'
# require 'alatir/result'
require 'alatir/errors'

module Alatir
end
