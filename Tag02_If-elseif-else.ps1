#### if-else
# Aufgabe: Gebe einen Computer ein, um die Verbindung zu testen
# Ergebnis: Verbindung klappt oder Verbindung klappt nicht

$computer = Read-Host -prompt "Computername eingeben"
if(Test-Connection -ComputerName $computer -Count 1)
{
    Write-Host "Ist erreichbar"
}
else
{
    Write-Host "NICHT erreichbar"
}

#### if-elseif-else
# Aufgabe: Eingabe einer Zahl
# Wenn Zahl = 10 => RICHTIG
# Wenn Zahl = 100 => RICHTIG
# Sonst => FALSCH

$zahl = Read-Host -Prompt "Zahl eingeben"

if($zahl -eq 10)
{
    Write-Output "$zahl ist richtig"
}
elseif($zahl -eq 100)
{
   Write-Output "$zahl ist richtig"
}
else
{
    Write-Output "$zahl ist LEIDER FALSCH"
}


$zahl = Read-Host -Prompt "Zahl eingeben"
if($zahl -eq 10 -or $zahl -eq 100)
{
    Write-Output "$zahl ist richtig"
}
else
{
    Write-Output "$zahl ist LEIDER FALSCH"
}

# $zahl soll 10 oder 100 UND eine gerade Zahl sein

$zahl = Read-Host -Prompt "Zahl eingeben"  # Rückgabewert von Read-Host ist immer ein String!!!
$zahl = [int]$zahl
if(($zahl -gt 10 -and $zahl -lt 101) -and $zahl % 2 -eq 0)
{
    Write-Output "$zahl ist richtig"
}
else
{
    Write-Output "$zahl ist LEIDER FALSCH"
}


#### Zwei oder mehr Bedingungen
<#
Aufgabe: Rabattsystem
$eintritt = 10
Wenn das Alter einer Person kleiner 18 oder größer 67, dann ist der Eintritt frei
Wenn das Alter 18-25, dann 5% Rabatt
Sonst voller Preis

alter.csv

Alter
18
33
25
45
68

Ergebnis: "Eintrittspreis mit x% Rabatt zum Preis von y Euro"
#>


$alterliste = @"
Alter
18
33
25
45
68

"@

New-Item -Path alter.csv -ItemType File -Value $alterliste

Get-Content -Path alter.csv

$eintritt = 10

import-csv -Path alter.csv | ForEach-Object {
    $age = $_.Alter
    #$age.gettype()
    $age = [int]$age
    #$age.gettype()
    if($age -lt 18 -or $age -gt 67)
    {
        $neweintritt = 0
        Write-Host "Alter: $age - Eintrittspreis mit 100% Rabatt zum Preis von $neweintritt Euro"
    }
    elseif ($age -ge 18 -and $age -le 25) {
        $rabatt = 5
        $neweintritt = $eintritt - ($eintritt * $rabatt / 100)
        Write-Host "Alter: $age - Eintrittspreis mit $rabatt % Rabatt zum Preis von $neweintritt Euro"
    }
    else
    {
        $neweintritt = $eintritt
        Write-Host "Alter: $age - Eintrittspreis mit 0% Rabatt zum Preis von $neweintritt Euro"
    }
}