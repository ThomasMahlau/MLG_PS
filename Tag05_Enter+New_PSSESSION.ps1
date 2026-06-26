Test-Connection -ComputerName srv22016
ping srv22016

# Enter-PSSession
Enter-PSSession -ComputerName srv22016
hostname
Exit-PSSession

# New-PSSession
New-PSSession -ComputerName srv22016
Enter-PSSession -Id 9 # Achtung auf ID
Exit-PSSession
Get-PSSession
Get-PSSession | Remove-PSSession
New-PSSession -ComputerName dc01,mb01

# Mit Credentials
Enter-PSSession -ComputerName srv22016 -Credential SPIELWIESE\administrator
Enter-PSSession -ComputerName srv22016 -Credential (Get-Credential)

New-PSSession -ComputerName srv22016,cl3win11 -Credential SPIELWIESE\administrator
New-PSSession -ComputerName srv22016,cl1win10 -Credential (Get-Credential)

Enter-PSSession -Id 12
Exit-PSSession
Get-PSSession | Remove-PSSession

# Automatisierung
$session = New-PSSession -ComputerName dc01,mb01 -Credential pagr\administrator
Invoke-Command -Session $session -ScriptBlock {Install-WindowsFeature -Name Windows-Server-Backup}