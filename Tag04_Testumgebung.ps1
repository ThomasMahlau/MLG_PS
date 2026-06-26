Get-ExecutionPolicy

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force `
-Confirm:$false

# OUs anlegen
<#
HR
Technicians
CEO
Marketing
Groups
Workstations
#>

$OUs            =   'HR','Technicians','CEOs','Marketing','Groups','Workstations' 

# Schleifen-Arten
<#
while
do - while
do - until
foreach
ForEach-Object
for
#>

foreach($ou in $OUs)
{
    #Write-Output $ou
    New-ADOrganizationalUnit -Name $ou -Verbose
}

get-command -Noun *organization*

# Anzeigen der vorhandenen OUs
Get-ADOrganizationalUnit -Filter * | Get-Member

Get-ADOrganizationalUnit -Filter * | Select-Object -Property Name, ObjectClass

# Anlegen von neuen OUs
# New-ADOrganizationalUnit -Name <Name der OU>

################ Gruppen anlegen ###############
$Groups         =   'HR','Technicians','CEOs','Marketing'


# Kleine Helferlein
$env:USERDNSDOMAIN
$root = $env:USERDNSDOMAIN.split('.')[1]
$sub = $env:USERDNSDOMAIN.split('.')[0]

#$string = "Peter,Paul,Mary"


Foreach ($g in $Groups) {
    New-ADGroup -Name $g `
    -Path "OU=Groups,DC=$sub,DC=$root" `    -GroupScope Universal -GroupCategory Security -Verbose
}

Get-Command -Noun *ADgroup*

Get-ADGroup -Filter * | Select-Object -Property Name

# User anlegen & den OUs zuordnen
# User zu Gruppen hinzufügen entsprechend OU-Zuordnung

$HR             =   'Hans Womanizer','Markus Haul','Birgit Immerfroh','Franz Bizeps'
$Technicians    =   'Bernd Bullseye','Michael Hightower','Markus PowerShell'
$CEO            =   'Peter Travesty','Tatjana Schlank'
$Marketing      =   'Hannah Linux','Maria Azure','Susanne Amazon'
$City           =   'Vienna','Berlin','New York'

# Standardpasswort

$userpw =           '1234user!'

foreach($h in $HR)
{
    $split =    $h.split(' ')
    $sam =      ($split[0].Substring(0,1) + '.' + $split[1]).ToLower()
    $email =    ($email = $sam + '@' + $env:USERDNSDOMAIN).ToLower()
    New-ADUser `
    -Name $h `
    -GivenName $split[0] `
    -Surname $split[1] `
    -DisplayName $h `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText $userpw -Force) `
    -SamAccountName $sam `
    -UserPrincipalName $email `
    -Path "OU=HR,DC=$sub,DC=$root" `
    -EmailAddress $email `
    -Department 'HR' `
    -City (Get-Random -InputObject $City[0..2]) `
    -Verbose
}

###### Technicians

foreach($h in $Technicians)
{
    $split =    $h.split(' ')
    $sam =      ($split[0].Substring(0,1) + '.' + $split[1]).ToLower()
    $email =    ($email = $sam + '@' + $env:USERDNSDOMAIN).ToLower()
    New-ADUser `
    -Name $h `
    -GivenName $split[0] `
    -Surname $split[1] `
    -DisplayName $h `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText $userpw -Force) `
    -SamAccountName $sam `
    -UserPrincipalName $email `
    -Path "OU=Technicians,DC=$sub,DC=$root" `
    -EmailAddress $email `
    -Department 'Technicians' `
    -City (Get-Random -InputObject $City[0..2]) `
    -Verbose
}

###### CEO

foreach($h in $CEO)
{
    $split =    $h.split(' ')
    $sam =      ($split[0].Substring(0,1) + '.' + $split[1]).ToLower()
    $email =    ($email = $sam + '@' + $env:USERDNSDOMAIN).ToLower()
    New-ADUser `
    -Name $h `
    -GivenName $split[0] `
    -Surname $split[1] `
    -DisplayName $h `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText $userpw -Force) `
    -SamAccountName $sam `
    -UserPrincipalName $email `
    -Path "OU=CEOs,DC=$sub,DC=$root" `
    -EmailAddress $email `
    -Department 'CEO' `
    -City (Get-Random -InputObject $City[0..2]) `
    -Verbose
}

###### Marketing

foreach($h in $Marketing)
{
    $split =    $h.split(' ')
    $sam =      ($split[0].Substring(0,1) + '.' + $split[1]).ToLower()
    $email =    ($email = $sam + '@' + $env:USERDNSDOMAIN).ToLower()
    New-ADUser `
    -Name $h `
    -GivenName $split[0] `
    -Surname $split[1] `
    -DisplayName $h `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText $userpw -Force) `
    -SamAccountName $sam `
    -UserPrincipalName $email `
    -Path "OU=Marketing,DC=$sub,DC=$root" `
    -EmailAddress $email `
    -Department 'Marketing' `
    -City (Get-Random -InputObject $City[0..2]) `
    -Verbose
}

$newuser = @"
Name,OU
Jeff Bezos,HR
Klaus Personal,HR
Donald Trump, HR
Bill Gates,Technicians
Steve Jobs,Technicians
Larry Ellison,Technicians
"@

New-Item -path $home\aduser.csv -ItemType File -Value $newuser -Force
Get-Content -path $home\aduser.csv

Import-Csv -path $home\aduser.csv | ForEach-Object {
    $name = $_.Name
    $ou = $_.OU

    $split =    $name.split(' ')
    $sam =      ($split[0].Substring(0,1) + '.' + $split[1]).ToLower()
    $email =    ($email = $sam + '@' + $env:USERDNSDOMAIN).ToLower()
    #Write-Host "$vorname - $nachname- $ou - $sam - $email"
    
    New-ADUser `
    -Name $name `
    -GivenName $split[0] `
    -Surname $split[1] `
    -DisplayName $name `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText $userpw -Force) `
    -SamAccountName $sam `
    -UserPrincipalName $email `
    -Path "OU=$OU,DC=$sub,DC=$root" `
    -EmailAddress $email `
    -Department "$OU" `
    -City (Get-Random -InputObject $City[0..2]) `
    -Verbose
    
}


# Löschen von usern

Get-Command -Noun aduser*

Get-Aduser -Filter * -SearchBase "OU=HR,DC=$sub,DC=$root" | Select-Object -Property Name

Get-Aduser -Filter * -SearchBase "OU=HR,DC=$sub,DC=$root" | Remove-ADUser

Get-ADUser -Filter * | Select-Object -Property Name,GivenName,Surname,DisplayName,UserPrincipalName | Format-Table -AutoSize -Wrap

Get-Command -Noun *ADuser*

<#
Notwendige Daten für neue User
-Name                  => aus der Liste $HR ($h)
-GivenName (Vorname)   => aus $h - gesplittet am Indexwert 0
-Surname (Nachname)    => aus $h - gesplittet am Indexwert 1
-DisplayName           => $h
-Enabled               => $true
-AccountPassword       => aus $userpw (ConvertTo-SecureString -AsPlainText $userpw -Force)
-SamAccountName        => (Muster: h.womanizer) aus $h (splitten -> erstenBuchstaben aus Index0+'.'+Index1 -> kleinschreiben
                          $sam = ($split[0].Substring(0,1) + '.' + $split[1]).ToLower()
                                            H                 .    Womanizer   h.womanizer
-UserPrincipleName     => (Muster: h.womanizer@spielwiese.intern)
                          $email = ($email = $sam + '@' + $env:USERDNSDOMAIN).ToLower()
-Path                     "OU=HR,DC=$sub,DC=$root"
-EmailAdress           => $email
-Department            => 'HR'
-City                  => (Get-Random -InputObject $City[0..2])


#>

########## Zuordnung OU-User zu Gruppen

$CEOg = "OU=CEOs,DC=$sub,DC=$root"
$hrg = "OU=HR,DC=$sub,DC=$root"
$techg = "OU=Technicians,DC=$sub,DC=$root"
$marketingg = "OU=Marketing,DC=$sub,DC=$root"

Get-ADUser -Filter * -SearchBase $CEOg | ForEach-Object {
    Add-ADGroupMember -Identity CEOs -Members $_ -Verbose
}

Get-ADUser -Filter * -SearchBase $hrg | ForEach-Object {
    Add-ADGroupMember -Identity HR -Members $_ -Verbose
}

Get-ADUser -Filter * -SearchBase $techg | 
ForEach-Object `
{Add-ADGroupMember -Identity Technicians -Members $_ -Verbose}

Get-ADUser -Filter * -SearchBase $marketingg | 
ForEach-Object `
{Add-ADGroupMember -Identity Marketing -Members $_ -Verbose}

Start-Process dsa.msc   # Starten der AD-Benutzer...-Verwaltung

# Alle Computer Cmdlets anzeigen

Get-Command -Noun ADComputer

Get-ADComputer -Filter *

Get-ADComputer -Filter * | Select-Object -Property Name, Enabled, SID

Get-ADComputer -Filter 'operatingsystem -like "*server*"' -Properties Name, Enabled, SID

Get-ADComputer -Filter 'operatingsystem -like "*server*"' | Select-Object -Property Name, Enabled, SID

# Computer erstellen, aendern und loeschen

New-ADComputer -Name TestComputer -OperatingSystem 'Windows 11 Pro' `
-Path 'OU=Workstations,DC=SPIELWIESE,DC=INTERN' -Verbose

Set-ADComputer -Identity TestComputer -Enabled $false -Verbose

Remove-ADComputer -Identity TestComputer -Confirm:$false -Verbose

# Dummycomputer erstellen

1..10 | ForEach-Object {
    New-ADComputer -Name Computer$_ -Verbose
}

1..10 | ForEach-Object {
    Remove-ADComputer -Identity Computer$_ -confirm:$false -Verbose
}

# Gruppe erstellen (PCGRUPPE)

New-ADGroup -Name PCGRUPPE -GroupScope Universal -GroupCategory Security -Verbose

Get-ADComputer -Filter 'Name -like "Computer*"' |
    Add-ADPrincipalGroupMembership -MemberOf PCGRUPPE -Verbose

Set-ADUser -Identity:"CN=Donald Trump,OU=HR,DC=spielwiese,DC=intern" -Server:"DC2016.spielwiese.intern" -title:"Leiter"

Get-Aduser -Filter * -SearchBase "OU=HR,DC=$sub,DC=$root" | Select-Object -property *

# Inaktive Benutzer suchen und deaktivieren

$date = (Get-Date).AddDays(0)

Get-ADUser -Filter {LastLogonDate -lt $date} -Properties LastLogonDate |
    Disable-ADAccount -Confirm:$true

# Benutzer in eine andere OU verschieben 
Get-ADObject -Filter 'ObjectClass -eq "user"' -SearchBase 'OU=HR,DC=SPIELWIESE,DC=INTERN' |
    Move-ADObject -TargetPath 'OU=CEOs,DC=SPIELWIESE,DC=INTERN' -Verbose

# Benutzer-Passwort zurücksetzen
$newpwd = Read-Host -Prompt "Neues Passwort eingeben" -AsSecureString

Set-ADAccountPassword h.womanizer `-reset `-NewPassword $newpwd `-verboseGet-ADUser | Get-Member# Ausgaben von zusätzlichen Properties:Get-ADUser -Filter * | Select-Object -Property Name, Title, city # Title bleibt leer

Get-ADUser -Filter * -Properties * | Select-Object -Property Name, Title, city # Title bleibt leer

Get-AdUser -Filter * -Properties * | 
    Select-Object -Property Name, Title, Street, City, TelephoneNumber |
    Format-Table -AutoSize -Wrap# Alle MA aus Vienna nach Berlin - FILTER nach City ergänzenGet-ADUser -Filter * -Properties *Get-ADUser -Filter * -SearchBase "OU=CEOs, DC=SPIELWIESE,DC=INTERN" |     Where-Object city -EQ 'Vienna' | Select-Object -Property Name,city# Keine Ausgabe, weil City nicht in Where-Object übergeben wurdeGet-ADUser -Filter * -Properties * -SearchBase "OU=CEOs, DC=SPIELWIESE,DC=INTERN" |     Where-Object city -EQ 'Vienna' | Select-Object -Property Name,city, DistinguishedName# Funktioniert nach Hinzufügen von -Properties * - gibt nur MA aus CEOs mit City = Vienna###### ALLE MA aus Vienna nach Berlin verlegen# Variante 1:Get-ADUser -Filter * -Properties * |     Where-Object city -EQ 'Vienna' | Select-Object -Property Name,city, DistinguishedName# Variante 2:Get-ADUser -Filter {city -eq 'Vienna'} -Properties * |     Select-Object -Property Name, city, DistinguishedName |    Set-ADUser -City 'Berlin'# Funktioniert über alle Abteilungen (OU)# Ändern der Stadt mit:# Set-ADUser -City 'Berlin'