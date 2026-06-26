# Setup Logs nach Fehler untersuchen

Get-ChildItem -Path C:\Windows\Panther -Recurse | 
Select-String 'First boot' | 
Select-Object -Last 1

Get-ChildItem -Path C:\Windows\Panther -Recurse | 
Select-String 'Error' | 
Select-Object -Last 1

# Ereignisanzeige durchsuchen
Get-EventLog -LogName System -EntryType Error | Format-Table -AutoSize -Wrap

get-help Get-EventLog -Online

Get-Command -Name *computer*

Get-ADComputer -Filter * | Select-Object DNSHostName,Name

Get-ADDomain
Get-ADForest | Select-Object -Property * | Format-Table -AutoSize -Wrap

Get-ADComputer -Filter * | 
Select-Object -Property Name,Enabled,SID

Get-ADOrganizationalUnit -Filter * | 
Select-Object -Property Name,DistinguishedName

Get-ADUser -Filter 'Name -like "*Bizeps*" -or Name -like "*Hans*"' -Property * |
Select-Object -Property Name,UserPrincipalName,Enabled,WhenCreated,PasswordLastSet