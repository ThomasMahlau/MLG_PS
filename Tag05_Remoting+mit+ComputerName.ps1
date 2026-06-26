# Remoting mit -ComputerName

Get-Hotfix -ComputerName cl3win11

Restart-Computer -ComputerName srv22016

Get-WindowsFeature -ComputerName srv22016 -Name 'XPS-Viewer'

Install-WindowsFeature -ComputerName srv22016,srv12016 -Name 'XPS-Viewer'

Get-Command -ParameterName ComputerName # nicht alle Cmdlets unterstuetzen den Parameter!

(Get-Command -ParameterName ComputerName).count

Get-NetIPAddress -ComputerName srv22016 # Error

Invoke-Command `-Computername srv22016 `-ScriptBlock {
    Get-NetIPAddress
}