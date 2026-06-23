echo "Hallo Welt" # echo Alias => Steht für einen PS-Befehl

Write-Host "Hallo Welt"

<#
Befehle lösen Aufgaben, die aus ... bestehen:
- Commandlets (CmdLets)
- Anwendungsprogramme
- .NET-Methoden
#>

explorer C:\

ping zdf.de

regedit

[Console]::Beep(800,1200)

###### Datentypen

WhoAmI

'WhoAmI'

"WhoAmI"

dir # Alias => Get-ChildItem

Get-ChildItem

'unsinn'

"Dies ist 'besonders wichtig'"
'Dies ist "besonders wichtig"'

'Dies ist ''besonders wichtig''.'

"Dies ist ""besonders wichtig""."

"Dies ist `"besonders wichtig`"."

"Ein Text über `r`nmehrere Zeilen"

# Here-Strings

@"
Ein Text über
mehrere Zeilen
"@

@"
Name, Vorname, Email
Mustermann, Andreas, a.mustermann@meinefirme.de
Schuster, Alfons, a.schuster@meinefirme.de
"@

# Zahlen

3 * 3

5.3 * 3

# Variablen

$a = 3
$b = 4
$c = $a * $b
Write-Host $c

$a = "String"
Write-Host $a

# Aktuelle PS-Version ermitteln

$PSVersionTable

# Erste Informationen sammeln
<#
- Cmdlet
- Alias
- Programm
- .NET-Klasse

Get-ChildItem

#>

hostname    # Alias oder Programm ==> hostname.exe


# PS-Befehle

Get-Command # Verb-Noun-Bestandteile

(Get-Command).count

Get-Verb

Get-Command -Verb Install

(Get-Command -Noun VM).count


(Get-Command -Noun *VM*).count

Get-Command -CommandType Alias

Get-Alias

### Informationen zum System sammeln

(Get-ChildItem).count

(Get-ChildItem C:\test -Recurse).count

Get-InstalledModule # Camel-Casing

Install-Module PSWriteHTML -Force -Verbose

# -Force => Setze den Befehl durch
# -Verbose => Ausführliche Kommentierung der Ausführung 

Get-Command -Module PSWriteHTML

# Aktuelle Prozesse

Get-Process

Get-Process *system* # Get-Process -Name *system*

Get-Process -Name *system*

Get-Process s*, *s

Start-Process explorer C:\windows

Start-Process notepad

Get-Process postgres

Stop-Process -Name explorer, postgres -Force

# Ausgaben (Pipeline)

Get-Process | Select-Object | Out-GridView -PassThru | Stop-Process

Get-Process explorer

get-service *spooler*

# Allgemeine Parameter

# -Force => zum Durchsetzen des Befehle
# -Verbose => ausführlichen Kommentierung der Befehlsausführung
# -WhatIf => "Was wäre wenn"
Restart-Computer -WhatIf

# -Confirm => Erzwingt eine Bestätigung
Restart-Computer -Confirm

Get-ComputerInfo

Get-ComputerInfo -Property CsDomain, LogonServer, TimeZone, OsName, WindowsProductId

Get-Location

Set-Location HKLM:

Get-ChildItem

Set-Location Google

Get-ComputerInfo | Get-Member -MemberType Method

Get-ChildItem | Get-Member

Get-Location

Get-PSDrive

Set-Location C:

Get-NetIPAddress

Get-NetIPConfiguration

# Hilfe holen (Erste Hinweise)

Get-Help Get-ChildItem
# entspricht
Get-ChildItem -?

Update-Help # standardmäßig Aktualisierung der Module

Get-Help Get-ChildItem -Online

Start-Transcript

cd \

ipconfig

ping zdf.de, ard.de, google.de

Test-Connection zdf.de, ard.de, google.de -count 1

Clear-Host

Stop-Transcript

Start-Process notepad C:\Users\thoma\Documents\PowerShell_transcript.WIN11PRO.4NnXo85o.20260622115550.txt