# Compuername aendern

hostname
$env:COMPUTERNAME
Rename-Computer -NewName 'CL01' -Restart 

# IP-Konfiguration abrufen

Get-NetIPConfiguration
Get-NetAdapter

# DHCP enablen (wenn statische IP vergeben)

Set-NetIPInterface -InterfaceIndex 3 -Dhcp Enabled
Get-NetRoute
Remove-NetRoute -DestinationPrefix 0.0.0.0/0 -Confirm:$false
Set-DnsClientServerAddress -InterfaceIndex 3 -ResetServerAddresses 

# Statische IP-Adresse festlegen (wenn DHCP aktiviert)

Get-NetAdapter
New-NetIPAddress -InterfaceIndex 3 -IPAddress 192.168.99.230 `
-PrefixLength 24 -DefaultGateway 192.168.99.1 -AddressFamily IPv4
Set-DnsClientServerAddress -InterfaceIndex 3 -ServerAddresses 8.8.8.8

# Windows Updates

Get-HotFix

# Setup Logs nach Fehler untersuchen

Get-ChildItem -Path C:\Windows\Panther -Recurse | 
Select-String 'First boot' | 
Select-Object -Last 1

Get-ChildItem -Path C:\Windows\Panther -Recurse | 
Select-String 'Error' | 
Select-Object -Last 1

# Ereignisanzeige durchsuchen

Get-EventLog -LogName System -EntryType Error | Format-Table -AutoSize -Wrap

### Client zur Domaene hinzufuegen

# Test

Test-Connection pagr.inet

# Domain-Join

Add-Computer -DomainName pagr.inet -Credential pagr\administrator -Restart

# Test ob der sichere Kanal hergestellt wurde

Test-ComputerSecureChannel -Verbose
$env:LOGONSERVER

# Infos vom System abrufen

Get-ComputerInfo | Out-File $home\computerinfo.txt
Get-ComputerInfo
Get-CimInstance win32_operatingsystem
Get-CimInstance win32_computersystem
Get-CimInstance win32_volume
Get-CimInstance -Class Win32_PhysicalMemory  | 
Select-Object Manufacturer,BankLabel,ConfiguredClockSpeed,`
SerialNumber,@{n="RAM"; e={[Math]::Round($_.Capacity/ 1GB)}} | 
Format-Table
Get-WmiObject win32_useraccount


