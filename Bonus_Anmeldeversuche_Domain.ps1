# ERFOLGREICHE ANMELDEVERSUCHE ID 4624

Get-EventLog -LogName Security -InstanceId 4624 | 
Where-Object Message -match "Kontoname:		administrator" | Select-Object -First 3 |
Format-Table TimeGenerated,Message -AutoSize -Wrap

# FEHLGESCHLAGENE ANMELDEVERSUCHE ID 4771

Get-EventLog -LogName Security -InstanceId 4771 | 
Where-Object Message -match "Kontoname:		administrator" | 
Format-Table TimeGenerated,Message -AutoSize -Wrap