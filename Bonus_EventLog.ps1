### Achtung: Nur PowerShell 5.1 !

# Eintraege abrufen
Get-EventLog # Logname!
Get-EventLog -LogName Application -Newest 5 | Format-Table -AutoSize -Wrap
Get-EventLog -LogName Application -EntryType Error -Newest 3
Get-EventLog -LogName System -InstanceId 35 -Newest 10 | Format-Table -AutoSize -Wrap

# Einen neuen Eintrag erstellen
Write-EventLog `
-LogName "System" `
-Source "Eventlog" `
-EventId 14 `
-EntryType Information `
-Message "Backup successful." 

# Am DC in der Ereignisanzeige nach fehlerhaften Logins des Administrators suchen
Get-EventLog -LogName Security -InstanceId '4625' | 
Where-Object {$_.Message -Like "*administrator*"} |
Select-Object -Property TimeGenerated,Message -First 1 |
Format-Table -AutoSize -Wrap
