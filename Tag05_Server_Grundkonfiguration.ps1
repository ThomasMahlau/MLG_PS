####### Server-Rollen und Features installieren und deinstallieren

# Abrufen
Get-WindowsFeature
Get-WindowsFeature | Where-Object InstallState -eq 'Removed'
Get-WindowsFeature *Backup*

# Installieren
Install-WindowsFeature Windows-Server-Backup -IncludeManagementTools

# Deinstallieren
Uninstall-WindowsFeature Windows-Server-Backup
Restart-Computer -Force

# Prozesse, Dienste, Registry, Ereignisanzeige

# Prozesse
Start-Process notepad -WindowStyle Minimized
Start-Process mspaint -WindowStyle Maximized
Get-Process notepad,mspaint | Stop-Process
Start-Process https://sid-500.com

# Dienste
Get-Service 
Get-Service | Where-Object Status -EQ 'Running'
Get-Service Spooler | Stop-Service -Verbose
Start-Service spooler -Verbose

# Registry
Get-PSDrive 
Set-Location 'HKLM:\SYSTEM\Keyboard Layout'
Test-Path HKLM:\SOFTWARE\Google
Set-ItemProperty `
-Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'`
-Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "RemoteDesktop"            # Remote-Desktop per Registry aktivieren

# Ereignisanzeige
Get-EventLog –LogName Security –InstanceId '4624' | Where-Object {$_.Message -Like "*patri*"} |
Select-Object -Property TimeGenerated,Message -First 5 |
Format-Table -AutoSize -Wrap 

Get-WinEvent

Write-EventLog -LogName "System" -Source "Eventlog" -EventId 13 -EntryType Error -Message "Ping to sid-500.com failed"