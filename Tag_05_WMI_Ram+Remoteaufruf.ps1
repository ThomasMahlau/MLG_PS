Get-CimInstance -Class Win32_PhysicalMemory  | 
Select-Object Manufacturer,BankLabel,ConfiguredClockSpeed,SerialNumber,`
@{n="RAM"; e={[Math]::Round($_.Capacity/ 1GB)}} | 
Format-Table

# Informationen zu Remote-Computern (Server) abrufen
$server=(Get-ADComputer -Filter 'operatingsystem -like "*server*"').Name
Get-CimInstance win32_operatingsystem -ComputerName $server | 
Select-Object -Property PSComputerName,Caption,InstallDate,LastBootUpTime |
Out-File $home\Test.txt