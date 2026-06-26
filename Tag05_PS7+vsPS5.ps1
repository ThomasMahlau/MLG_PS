# Starten von PS7 als Admin
powershell Start-Process pwsh -Verb RunAs

# STarten von PS5 als Admin
powershell Start-Process powershell -Verb RunAs

####### && Only executed, if the first command was successful

Get-ChildItem C:\notthere -ErrorAction SilentlyContinue && 'Not there'

start-process notepad
Get-Process notepad -ErrorAction SilentlyContinue | Out-Null && Stop-Process -Name notepad

Get-process | out-null

### || Only executed if the first command was unsuccessful

Get-ChildItem C:\NotExist -ErrorAction SilentlyContinue || 'Not there'

Get-Process notepad -ErrorAction SilentlyContinue || Start-Process notepad


######## Vergleich und Variablen

# Vergleich Variablen in PS5 und PS7

Get-Variable | Select-Object -ExpandProperty Name | Out-File $home\ps5var.txt # In PS5 ausfuehren!
Get-Variable | Select-Object -ExpandProperty Name | Out-File $home\ps7var.txt

Compare-Object -ReferenceObject (Get-Content $home\ps5var.txt) `
-DifferenceObject (Get-Content $home\ps7var.txt)

####### coalescing-Operator

# Null coalescing: Wenn etwas null ist dann ...

# Einfaches Beispiel
$null ?? 'Wert ist null.'
0 ?? 'Wert ist null.'

# Existiert die Datei? Nein, dann erstelle sie 
(Get-ChildItem $home\log.txt -ErrorAction SilentlyContinue) ?? 
(New-Item -ItemType File -Path $home\log.txt)
 
# Ist das Exchange Online Modul installiert? Wenn nein, dann ...
(Get-Module -Name 'ExchangeOnlineManagement' -ListAvailable) ??
(Install-Module -Name 'ExchangeOnlineManagement')
 
# Prozess gestartet ? Wenn nein, dann ...
(Get-Process -Name notepad -ErrorAction SilentlyContinue) ??
(Start-Process notepad)



######## Foreach-Object -Parallel in PowerShell 7

$comp = '8.8.8.8','orf.at','9.9.9.9'

# PowerShell 5
Measure-Command {
$comp | ForEach-Object {Test-Connection -ComputerName $_}
}  | Select-Object -Property Seconds

# PowerShell 7
Measure-Command {
    $comp | ForEach-Object -Parallel {Test-Connection -ComputerName $_}
    }  | Select-Object -Property Seconds

# oder ...
Measure-Command  {
foreach ($c in $comp) {
    Test-Connection -ComputerName $c
    }
} | Select-Object -Property Seconds

############################################################################

# Default Threads in Foreach-Object -Parallel: 5 !
$comp = '8.8.8.8','orf.at','9.9.9.9','192.168.0.100','sid-500.eu','sid-500.com','uhrforum.de'

# PowerShell 5
Measure-Command {
    $comp | ForEach-Object {Test-Connection -ComputerName $_ -ErrorAction SilentlyContinue}
    }  | Select-Object -Property Seconds

# PowerShell 7
Measure-Command {
    $comp | ForEach-Object -Parallel {Test-Connection -ComputerName $_ -ErrorAction SilentlyContinue} -ThrottleLimit 7
    }  | Select-Object -Property Seconds



########### Ternary Operator: ab PowerShell 7 als Alternative zu If Bedingungen
# <condition> ? <condition-is-true> : <condition-is-false>

# If-Else
If (Test-Path C:\Windows) {
    Write-Host "Verzeichnis vorhanden."
} else {
    Write-Host "Verzeichnis nicht vorhanden."
}

# Ternary Operator
(Test-Path C:\Windows) ? "Verzeichnis vorhanden" : "Verzeichnis nicht vorhanden" # Ternary (dreifach) Operator

0 ? 'true' : 'false'
1 ? 'true' : 'false'


# powershell gallery => Repository mit Lösungen aus der Community

