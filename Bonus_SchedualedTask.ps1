# Test-Skript erstellen
New-Item -Path $home -ItemType File -Name script.ps1 -Force -Value 'msg * "Huhu, ich bin der Test Task!"'

# User und TaskName festlegen
$user       = 'pagr\administrator'
$taskname   = 'Task1'

# Werte festlegen
$Action = New-ScheduledTaskAction -Execute `
"pwsh.exe" -Argument "–Noprofile -WindowStyle Hidden -ExecutionPolicy Bypass -File $home\script.ps1"
$Trigger =      New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 15)
$Set =          New-ScheduledTaskSettingsSet
$Principal =    New-ScheduledTaskPrincipal -UserId $user
$Task =         New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Set -Principal $Principal

# Den Task registrieren
Register-ScheduledTask -TaskName $taskname -InputObject $Task -Force
# Testen
Start-ScheduledTask -TaskName $taskname