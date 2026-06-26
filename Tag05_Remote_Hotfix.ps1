# Remoting mit -ComputerName

Get-Hotfix -ComputerName dc01 -Credential iad\administrator
Restart-Computer -ComputerName mb01,dc01 -Credential (Get-Credential) -Force

Get-Command -ParameterName ComputerName