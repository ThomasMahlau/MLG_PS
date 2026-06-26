# Windows Updates konfigurieren

# Hoftixes abrufen
Get-HotFix

# Modul installieren
Install-Module -Name PSWindowsUpdate -Force
Get-Command -Module PSWindowsUpdate

# Updates anzeigen
Get-WUHistory

# Download Updates
Download-WindowsUpdate