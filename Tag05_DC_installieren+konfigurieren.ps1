Get-NetAdapter
Get-NetIPConfiguration

# DefaultGateway festlegen
New-NetIPAddress -InterfaceIndex 9 -DefaultGateway 192.168.99.1 -PrefixLength 24 `
 -AddressFamily IPv4

# IP-Adresse festlegen
New-NetIPAddress -InterfaceIndex 9 -IPAddress 192.168.99.10 -PrefixLength 24 `
 -AddressFamily IPv4

# DNS-Serveradresse festlegen
Set-DnsClientServerAddress -InterfaceIndex 9 -ServerAddresses 8.8.8.8,9.9.9.9

# Remote-Desktop aktivieren
Set-ItemProperty `
-Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'`
-Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "RemoteDesktop"  

# AD-Domain-Services
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Forest installieren
Install-ADDSForest `
-DomainName iad.inet `
-SafeModeAdministratorPassword (Convertto-SecureString -AsPlainText "Passwort1234#" -Force)

# Domain-Join
Add-Computer -DomainName SPIELWIESE.INTERN -Credential SPIELWIESE\administrator -Restart

# Testen, ob sicherer Kanal zwischen lokalem Computer und domain hergestellt werden kann

Test-ComputerSecureChannel -Verbose
$env:LOGONSERVER

#Test-ComputerSecureChannel -Repair # Reset auf SecureChannel

# Zurückstufen des Domain-Controllers
Uninstall-ADDSDomainController

# Tests
Get-NetIPConfiguration
Get-ADDomainController -Filter *
Get-ADForest
Get-ADDomain

Test-Connection SPIELWIESE.INTERN -count 1 -Quiet

Test-Connection 192.168.55.1 -count 1 -Quiet

Test-Connection 8.8.8.8 -count 1 -Quiet

Get-NetAdapter

Get-NetIPAddress

Get-NetIPConfiguration

# DNS
Get-DnsServerZone -Name 'SPIELWIESE.INTERN' | Get-DnsServerResourceRecord

# Remoting
Enable-PSRemoting
hostname
$env:Computername
systeminfo
Get-ComputerInfo

Enter-PSSession -ComputerName CL-01

Exit-PSSession

Get-NetIPConfiguration