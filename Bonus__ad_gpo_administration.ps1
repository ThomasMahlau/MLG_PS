# GPO Cmdlets abrufen

Get-Command -Module GroupPolicy

# GPO erstellen

New-GPO -Name "ScreenSaverTimeOut" -Comment "Sets the time to 900 seconds"

Set-GPRegistryValue `
-Name "ScreenSaverTimeOut" `
-Key "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" `
-ValueName ScreenSaveTimeOut -Type String -Value 900

New-GPLink -Name "ScreenSaverTimeOut" -Target "ou=people,dc=pagr,dc=inet"

# GPO anzeigen

Get-GPO -Name "ScreenSaverTimeOut" | 
Get-GPOReport -ReportType HTML -Path $Home\report.html
Invoke-Item $Home\report.html

# GPO Vererbung / Erzwungen

Get-GPInheritance -Target "ou=people,dc=pagr,dc=inet"

Set-GPInheritance -Target "ou=people,dc=pagr,dc=inet" -IsBlocked 1 # Vererbung blockieren 

Set-GPLink -Name "Default Domain Policy" `
-Target "dc=pagr,dc=inet" -Enforced Yes # Erzwingen

# Security Filtering

Set-GPPermission -Name "ScreenSaverTimeOut" `
-TargetName "Authenticated Users" `
-TargetType User -PermissionLevel None

