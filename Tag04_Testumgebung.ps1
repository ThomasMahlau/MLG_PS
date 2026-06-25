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
$Technician     =   'Bernd Bullseye','Michael Hightower','Markus PowerShell'
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

Get-ADUser

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

