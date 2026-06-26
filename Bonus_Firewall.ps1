### PowerShell Befehle der FW anzeigen

Get-Command -Module NetSecurity | Format-List Name

### Firewall aktivieren / deaktivieren

Set-NetFirewallProfile -All -Enabled false
Set-NetFirewallProfile -All -Enabled true

### Aktives Profil anzeigen

netsh advfirewall show currentprofile
Get-NetAdapter | 
Where-Object status -EQ 'up' | 
Get-NetConnectionProfile

### Regeln aktivieren / deaktivieren

Set-NetFirewallRule -DisplayGroup 'Microsoft Edge' -Enabled False
Set-NetFirewallRule -DisplayGroup 'Microsoft Edge' -Enabled True


### Eine Regel erstellen und überprüfen

New-NetFirewallRule -Name "Block HTTP" `
-DisplayName "Block HTTP" `
-Enabled 1 `
-Direction Inbound `
-Action Block `
-LocalPort 80 `
-Protocol TCP

Get-NetFirewallRule -Name *Block* | 
Select-Object Name,Enabled,Direction,Action,PrimaryStatus

Remove-NetFirewallRule -Name "Block HTTP"

### Firewall Einstellungen remote abrufen

Invoke-Command -ComputerName dc01 -Credential pagr\administrator `
{Get-NetFirewallProfile -All | 
    Select-Object Name,Enabled}