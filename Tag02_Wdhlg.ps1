# Here - String

@"
Name,Vorname
Mustermann,Klaus
"@


# Kommentierungsarten - für eine Zeile

Get-ChildItem # Hier kommt mein Kommentar

<#
Mehrzeilige
Kommentierung
#>

Get-Command -Verb get

(Get-Command -Noun *NetIP*).count


# Anzeige aller Aliasse
Get-Alias

# Alle installierten Module anzeigen
Get-Module

Get-InstalledModule

# Anzeige der Modul-Befehle
Get-Command -Module PSWriteHTML

# Anzeige der laufenden Prozesse
Get-Process

# Anzeige verfügbarer Eigenschaften eines CmdLets
Get-Process | Get-Member

# Anzeige ausgewählter Eigenschaften der laufenden Prozesse
Get-Process | Select-Object -Property Processname, CPU -first 10

# Anzeige der PS-Laufwerke
Get-PSDrive

# Überprüfen, ob Google Chrome installiert ist
Set-Location HKLM:
Set-Location Software
Set-Location Google

dir function:

dir alias:

# Suche nach installierbaren Programmen
winget search Microsoft.Powershell

# Installation neuer Programme
winget install --id Microsoft.Powershell.Preview --force

# Durchlaufen "Liste" oder einen String

$myzahlenliste = 1,2,3,4,5
$mystringliste = "Peter", "Paul", "Mary"

        #    0123456....
$mystring = "Peter, Paul, Mary"

$myzahlenliste.Length

$mystringliste.Length

$mystring.Length

$mystringliste | ForEach-Object {
    $_    # Pipeline-Variable ($PSItem)
}

$laenge = $mystring.length
$c = 0

while($c -lt $laenge)
{
    $mystring[$c]
    $c++ # oder $c+=1
}

# Aus String eine Liste(Array) machen und dann durchlaufen und ausgeben
$mystring = "Peter, Paul, Mary"
$mystring = $mystring.replace(" ", "")
$myliste = $mystring.split(",")

$myliste | ForEach-Object {
    $_   
}

# Alle Namen außer Paul ausgeben lassen
$myliste | ForEach-Object {
    if($_ -ne "Paul")
    {
        $_   
    }
}

$ip = "192.168.20."  # von 192.169.20.1 bis 192.169.20.100

$nr = 1

#[array] $array = @()
$array = ""

1..100 | ForEach-Object {
    $newip = "$ip$_"
    $array += "$newip"
}

Write-Host $array[2]

##### Arbeiten mit Verzeichnissystem

# Inhalt eines Verzeichnisses C:\test1000 ausgeben lassen

$pfad = "C:\test1000"

Get-ChildItem $pfad -recurse

# Erstellen einer neuen Datei für Ordner "neuerordner"

New-Item $pfad\neuerordner\neuedatei.txt -ItemType File

# Daten aus C:\test1000 in C:\test_backup kopieren

Remove-Item C:\test_backup -recurse

$newfolder = "C:\test_backup"

if(Test-Path $newfolder)
{
    Copy-Item 
}
else
{
    New-Item -Path C:\test_backup -ItemType Directory
}

Copy-Item -Path $pfad -Destination $newfolder -Recurse -Verbose

# Erstellen Sie ein Verzeichnis "C:\powershell" und kopieren Sie alle ps1-Dateien in dieses Verzeichnis

Copy-Item -Path C:\dokumente\materialien\ -Filter *.ps1 -Destination C:\powershell -recurse -WhatIf -Verbose

$folder = "C:\dokumente\materialien"
$ziel = "C:\powershell100"

New-Item -Path $ziel -ItemType Directory

Get-ChildItem -Path $folder -Filter *.ps1 -Recurse  | ForEach-Object {
   Copy-item -path $_.FullName -Destination $ziel
}

dir $ziel

Get-ChildItem | Get-Member


$daten = "Schaller, Peter", "Kohler, Paul", "Schiller, Mary"

# 1. Erstellen Sie eine CSV-Datei "mitarbeiter.csv" mit den Daten aus der Variable "$daten"
# 2. Durchlaufen Sie die Datei und erzeugen die Email-Adressen nach o.g. Muster (import-csv...)
# 3. Schreiben Sie Name,Vorname und Email in eine neue CSV-Datei "mitarbeiter_email.csv"

# Herausfinden, in welchem Verzeichnis ich bin
Get-Location
pwd

Set-Location C:\test1000

#New-Item -path mitarbeiter.csv -ItemType File -Value "Name, Vorname" -Force
New-Item -path mitarbeiter.csv -ItemType File -Force

$daten = $daten.replace(" ", "")

# Variante 1 für Aufg. 1:

"Name,Vorname" | Out-File -append mitarbeiter.csv

foreach($item in $daten)
{
    $item | Out-File -append mitarbeiter.csv
}

Get-Content mitarbeiter.csv

# Variante 2 für Aufg. 1:
$daten = @"
Name, Vorname
Schaller, Peter
Kohler, Paul
Schiller, Mary
"@
$daten = $daten.replace(" ", "")

New-Item $path\mitarbeiter.csv -ItemType File -value $daten -Force

# Variant 3 für Aufg. 1:

$daten = $daten.replace(" ", "")

Add-Content -Path mitarbeiter.csv "Name,Vorname"

$daten | ForEach-Object {
    Add-Content -path mitarbeiter.csv $_
}

# Aufgabe 2:
New-Item $path\mitarbeiter_email.csv -ItemType File -Force -Value "Name, Vorname, Email"
# p.schaller@meinefirma.de

Import-Csv mitarbeiter.csv | ForEach-Object {
    $name = $_.Name
    $vorname = $_.Vorname
    $vorname_kurz = $_.Vorname[0]
    $email = "$vorname_kurz.$name@meinefirma.de"
    $email = $email.ToLower
    Add-Content mitarbeiter_email.csv -Value "$name,$vorname,$email"
}

# Variante 2 - Aufgabe 2-3:
$daten = "Schaller, Peter", "Krueger, Paul", "Schiller, Mary"
$daten = $daten.replace(' ','')

new-item mitarbeiter.csv -ItemType file -Value $daten -Force

import-csv -path mitarbeiter.csv

New-Item mitarbeiter_email.csv -ItemType file -force -Value "Name, Vorname, Email"

$daten | ForEach-Object {
    $splitted = $_.split(",")
    $name = $splitted[0]
    $vorname = $splitted[1]
    $vornamekurz = $splitted[1][0]
    $email = "$vornamekurz.$name@meinefirma.de"
    #$email = "$splitted[1][0].$name@meinefirma.de"
    $email = $email.ToLower()
    Write-Host $email
    Add-Content mitarbeiter_email.csv -Value "$name,$vorname,$email"
}

# Variante 3 zu Aufg. 2

$mitarbeiter = Import-Csv ".\mitarbeiter.csv"

$mitarbeiterMitEmail = $mitarbeiter | ForEach-Object {

    $email = "{0}.{1}@firma.de" -f $_.Vorname.Substring(0,1).ToLower(), $_.Name.ToLower()

    # Hash-Tabelle - assoziatives Array (= Python: Dictonary) => Key - Value - Paare

    [PSCustomObject]@{
        Name = $_.Name
        Vorname  = $_.Vorname
        Email    = $email
    }
}

$mitarbeiterMitEmail |
Export-Csv -Path ".\Mitarbeiter_email.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Dateien wurden erfolgreich erstellt."


# Zusatzaufgabe:
# 1. Erstellen Sie eine Datei "verzeichnis.csv" mit folgendem Inhalt:
<#
Verzeichnis
Protokolle
Arbeitsvertraege
Abmahnungen
Kuendigungen

2. Legen Sie einen Ordner "C:\verzeichnisse"
3. In diesem Ordner sollen alle Ordner aus der verzeichnis.csv angelegt werden
4. In jedem der Ordner soll eine Datei "readme.txt" enthalten sein mit dem Inhalt "Erstellt von: Ihr Name"
#>


$newfolder = @"
Verzeichnisse
Protokolle
Arbeitsvertraege
Abmahnungen
Kuendigungen

"@

New-Item -Path C:\verzeichnisse -ItemType Directory -Force
New-Item -Path C:\verzeichnisse\verzeichnis.csv -ItemType File -Value $newfolder -Force

Get-Content C:\verzeichnisse\verzeichnis.csv

import-csv C:\verzeichnisse\verzeichnis.csv | ForEach-Object {
    $verz = $_.Verzeichnisse
    New-Item -Path "C:\verzeichnisse\$verz\readme.txt" -ItemType File -Value "Erstellt von: TM" -Force
}

get-childitem c:\verzeichnisse -Recurse

