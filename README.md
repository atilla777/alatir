# Alatir
Alarmist attack incident response (alatir) is the library (and CLI app) for test security app and devices to know is they are worked?

This app in early alpha, but it already can be used.
Please note that the interface and settings of the app may change in future releases.

### Basic concept
* **activity** - action that simulate one attack technique realisation, activity may be represented as set of config in one yaml file
* **connector** - mechanism of transferring activity to target, can be represented as configuration in simulation yaml file or options in CLI app  (agentless local, SSH and WinRM connectors)
* **libriry of activities** - collection of activities, library may be represented as set activity yaml files in some folder
* **simulation** - sequence of activities, each of them can use own connector, simulation may be represented as yaml file describes used activities and connectors
* **alatir library** - collection of ruby classes, that can be used in some application to use activity and simulation
* **alatir CLI** - command line utility
* **alatir gem** - alatir library and alatir CLI packaged to one Ruby gem library
### Instalation
```bash
git clone https://github.com/atilla777/alatir.git
```
### Alatir CLI
By default activities library present in activities folder and simulation configuration is in simulation.yml file.
Before usage CLI app you should configure one or more simulation file, and if you want to create (reconfigure) activities yaml files.
#### Examples of usage
All commands shoul be run in alatir folder
##### Run several activities
```bash
bundle exec exe/alatir -a ./activities -n ps_activity,cmd_activity -c winrm -h https://192.168.1.1:5986/wsman -u test_user -p Passw@rd1
```
##### Run simulation
```bash
bundle exec exe/alatir simulate -s ../simulation.yml
```

### Alatir libryry
Main classes:
* Activity
* Connector
* Simulation
