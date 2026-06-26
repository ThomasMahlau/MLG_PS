<# Computer
cl1win10
cl2win2
cl3win11
dc2016
srv12016
srv22016
#>
Get-ADDomain
Get-ADForest
Get-ADComputer -Filter * | Select-Object -Property Name

# Computer umbenennen 
Rename-Computer -NewName DC01
#Restart-Computer

# RemoteDesktop aktivieren
Get-PSDrive
Set-ItemProperty `
-Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'`
-Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "RemoteDesktop" 

# AD-Domain-Services & ManagementTools
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Get-WindowsFeature

Get-NetIPConfiguration | Select-Object -Property *

#Get-NetIPInterface

Get-ADComputer -Filter * -Properties * | Select-Object -Property Name, IPv4Address
Test-Connection cl1win10 -count 1
ping cl1win10
Enter-PSSession -computername cl1win10 # keine Verbindung
Test-Connection cl2win7 -count 1
Enter-PSSession cl2win7 # keine Verbindung
Test-Connection cl3win11 -count 1 -quiet
Enter-PSSession cl3win11 # keine Verbindung
Test-Connection srv12016 -count 1
ping srv12016
Enter-PSSession srv12016 # Verbindung kann hergestellt werden
Test-Connection srv22016 -count 1
Enter-PSSession srv22016 # Verbindung kann hergestellt werden

# Remoting am Client aktivieren
# auf Clients standardmäßig nicht erlaubt - auf Server schon# 
winrm get winrm/config   #  HIER AUF SERVER kommen Infos
# !!! auf Clientrechner aktivieren !!!
winrm get winrm/config   # führt zur Fehlerfeldung, weil nicht aktiviert -

Get-command -noun *winrm*
Get-command -noun *remote*


# laufende Prozesse anzeigen
Get-Process
Enter-PSSession -ComputerName srv22016
Exit-PSSession

# Laufende Prozesse von allen Domain-Rechnern herausfinden und dokumentieren
Get-Adcomputer -Filter * -Properties * | ForEach-Object {
    #Get-Process
    $_.Name
    # Verbindung zum Rechner
    # Auslesen der Prozesse
    # Schreiben in eine Variable
}

# Services mit Status
Get-Service

get-service | Get-Member

# Nur laufende Services anzeigen lassen
Get-Service | Select-Object -Property Name,Status | Where-Object Status -eq Running
Get-Service | Select-Object -Property * | Where-Object {$_.Status -eq 'Running'}

# Welche Features sind installiert?
Get-Service -computerName srv22016 -Name Spooler # Kein Service gefunden
Get-Service -Name Spooler

# Alles Features anzeigen lassen
Get-WindowsFeature
Get-WindowsFeature *Backup*
Get-Command -noun WindowsFeature

# Remote-Computing - ohne Wechsel
# Parameter -ComputerName
Get-Command -ParameterName Computername

Install-WindowsFeature -ComputerName srv22016, srv12016 Windows-Server-Backup
Enter-PSSession -ComputerName srv22016
Exit-PSSession

### Invoke-Command
# Installation eines Features auf einem Remote-Computer ohne Session
Invoke-Command `-ComputerName srv12016 `-ScriptBlock {
    Install-WindowsFeature Windows-Server-Backup -IncludeManagementTools
}

# Deinstallation eines Features
# "Eierlegende Wollmichsau"

Get-ChildItem -computername srv22016 # funktioniert nicht - hat keinen parameter -computername

Invoke-Command `-Computername srv22016 `-ScriptBlock {
    Get-ChildItem $home
}

Invoke-Command `-ComputerName srv22016 `-ScriptBlock {
    Uninstall-WindowsFeature Windows-Server-Backup
}

Get-WindowsFeature | Get-Member

Invoke-Command `-ComputerName srv12016,srv22016 `-ScriptBlock {
    Get-WindowsFeature Windows-Server-Backup | Select-Object -Property Name,Installed,InstallState |
        Format-Table -AutoSize -Wrap
}
# Aktivieren von Features

# Features von mehreren Computern abrufen und in eine Datei ausgeben

Exit-PSSession