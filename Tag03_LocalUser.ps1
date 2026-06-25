# LocalUser

# Welche Befehle haben mit LocalUsern zu tun?
Get-Command *LocalUser*
Get-Command -Noun LocalUser*

# LocalUser ausgeben lassen
Get-LocalUser | Get-Member
# Name, Fullname,Lastlogon, PasswordRequired,Enabled

Get-LocalUser | Select-Object -Property Name, Fullname,Lastlogon, PasswordRequired,Enabled # => Listendarstellung, weil >4 Properties
Get-LocalUser | Format-Table -Property Name, Fullname,Lastlogon, PasswordRequired,Enabled, Description -AutoSize -Wrap
Get-LocalUser | Format-List -Property Name, Fullname,Lastlogon, PasswordRequired,Enabled, Description
Get-LocalUser | Select-Object -Property Name, Fullname,Lastlogon, PasswordRequired,Enabled, Description | Format-Table -AutoSize -Wrap

# Zeilenumbruch in Befehlen mit Backtick (Akzent Grave)
Get-Childitem -Path `
C:\test\*.txt | Format-Table -AutoSize -Wrap

# Neuen User anlegen
<#
Name
FullName
Password
Description
#>

$pwd = Read-Host -Prompt "Passwort eingeben" -AsSecureString
#Write-Host $pwd

$params = @{
    Name        = 'Neuer.User100'
    FullName    = 'Neuer User 100'
    Password    = $pwd
    Description = 'Neuer.User100 - Abt. Neu'
}

New-LocalUser @params

<#
1. Erstellen Sie eine Datei mit folgenden Inhalten (ma_localuser.csv):
Name, Vorname, Abteilung
Mustermann, Alfred, IT
Meier, Carl, IT
Schmidt, Simone, HR
Schiller, Annette, HR

2. Skript, dass alle User aus ma_localuser in einem Aufruf anlegt
#>

$daten = @"
Name,Vorname,Abteilung, PWD
Mustermann, Alfred, IT, user100
Meier, Carl, IT, user101
Schmidt, Simone, HR, user102
Schiller, Annette, HR, user103

"@

$daten = $daten.replace(" ","")

New-Item -Path C:\test1000\ma_localuser.csv -ItemType File -Value $daten -Force
Get-Content -Path C:\test1000\ma_localuser.csv
$datei = "C:\test1000\ma_localuser.csv"

# Variante 1: Mit Standardpasswort
$pwd = Read-Host -Prompt "Standardpasswort" -AsSecureString

Import-Csv -Path $datei | ForEach-Object {
    	$vorname = $_.Vorname
        $name = $_.Name
        $params = @{
            Name = "$name.$vorname"
            Fullname = "$vorname $name"
            Password = $pwd
            Description = $_.Abteilung
        }
    New-LocalUser @params
    #Write-Host @params
}

# Variante 2: Mit individuellem Passwort
$daten = @"
Name,Vorname,Abteilung, PWD
Mustermann, Alfred, IT, user100
Meier, Carl, IT, user101
Schmidt, Simone, HR, user102
Schiller, Annette, HR, user103

"@
New-Item -Path C:\test1000\ma_localuser.csv -ItemType File -Value $daten -Force
Get-Content -Path C:\test1000\ma_localuser.csv
$datei = "C:\test1000\ma_localuser.csv"

Import-Csv -Path $datei | ForEach-Object {
    	$vorname = $_.Vorname
        $name = $_.Name
        $params = @{
            Name = "$name.$vorname"
            Fullname = "$vorname $name"
            Password = ConvertTo-SecureString "$_.PWD" -AsPlainText -Force
            Description = $_.Abteilung
        }
    New-LocalUser @params 
    #Write-Host @params
}


# Löschen von User
Import-Csv -Path $datei | ForEach-Object {
    	$vorname = $_.Vorname
        $name = $_.Name
        $loeschname = "$name.$vorname"
    Remove-LocalUser -Name $loeschname
}

Get-LocalUser

Get-Command -Noun localgroup*

# Arbeiten mit Gruppen

Get-LocalGroup

New-LocalGroup -Name NeueGruppe -Description "MLG-Gruppe"

# Umbenennen einer Gruppe

Rename-LocalGroup -Name NeueGruppe -NewName "MLG"

# Löschen einer Gruppe

Remove-LocalGroup -Name MLG

# User zur Gruppe hinzufügen

$daten = @"
Name,Vorname,Abteilung, PWD
Mustermann, Alfred, IT, user100
Meier, Carl, IT, user101
Schmidt, Simone, HR, user102
Schiller, Annette, HR, user103

"@

$daten = $daten.Replace(" ","")

New-Item -Path C:\test1000\ma_localuser.csv -ItemType File -Value $daten -Force

$datei = "C:\test1000\ma_localuser.csv"

import-csv $datei | Where-Object {$_.Abteilung -eq "HR" -or $_.Abteilung -eq "IT"} | ForEach-Object {
    $gruppe = $_.Abteilung
    $name = $_.Name
    $vorname = $_.Vorname
    $user = "$name.$vorname"
    #Add-LocalGroupMember -Group $gruppe -Member $user
    Remove-LocalGroupMember -Group $gruppe -Member $user
}

# Neue User nur anlegen, wenn noch nicht vorhanden

# Variante 1:

$datei = "C:\test1000\ma_localuser.csv"
Get-Content $datei

Import-Csv -Path $datei | ForEach-Object {
    $vorname = $_.Vorname
    $name = $_.Name
    $user = "$name.$vorname"
    $params = @{
        Name = "$name.$vorname"
        Fullname = "$vorname $name"
        Password = ConvertTo-SecureString "$_.PWD" -AsPlainText -Force
        Description = $_.Abteilung
    }
    if(Get-LocalUser -Name $user)
    {
        Write-Output "User $user ist schon angelegt"
        $abfrage = Read-Host -Prompt "Soll User gelöscht werden (L) oder gelöscht & neu angelegt werden (N)"
        if($abfrage -eq "L")
        {
            #Remove-LocalGroupMember -group $group -Member $user ???
            Remove-LocalUser -Name $user
            Write-Output "User $user wurde erfolgreich gelöscht"
        }
        elseif($abfrage -eq "N")
        {
            Remove-LocalUser -Name $user
            New-LocalUser @params
            Write-Output "User $user wurde NEU angelegt" 
        }
    }
    else
    {
        New-LocalUser @params
        Write-Output "User $user wurde angelegt" 
    }
    #Write-Host @params
}

# Variante 2:
Import-Csv -Path $datei | ForEach-Object {
    $vorname = $_.Vorname
    $name = $_.Name
    $user = "$name.$vorname"
    $params = @{
        Name = "$name.$vorname"
        Fullname = "$vorname $name"
        Password = ConvertTo-SecureString "$_.PWD" -AsPlainText -Force
        Description = $_.Abteilung
    }

    try {
        # Prüfen ob User existiert
            if (-not (Get-LocalUser -Name $user -ErrorAction SilentlyContinue)) 
            {
                    <#
                    New-LocalUser `
                        -Name $user `
                        -FullName "$($vorname) $($name)" `
                        -Description $_.Abteilung`
                        -Password $_.PWD `
                        -ErrorAction Stop
                    #>
                    New-LocalUser @params

                    Write-Host "User erstellt: $user" -ForegroundColor Green
            }
    }
    catch 
    {
        Write-Host "Fehler bei $user : $_" -ForegroundColor Red
    }
}


