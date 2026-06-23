# Arbeit mit Dateisystem

Get-ChildItem -Path C:\

New-Item -path c:\test1000 -Itemtype Directory

New-Item -path c:\test1000\datei1.txt -ItemType File

Get-ChildItem -Path C:\test1000

Get-Content -Path c:\test1000\datei1.txt

New-Item -path c:\test1000\datei2.txt -ItemType File -Value "Dies ist ein kleiner Text"

Get-Content -Path c:\test1000\datei2.txt

$mytext = @"
Hier kommt ein Text
mit mehreren Zeilen
nur zur Demo
"@

Write-Host $mytext

New-Item -path c:\test1000\datei3.txt -ItemType File -Value $mytext

Get-Content -Path c:\test1000\datei3.txt

Get-Command -verb delete*

Get-Command -verb remove*

Remove-Item -Path c:\test1000\datei1.txt

set-location C:\test1000

$neuordner = Read-Host -Prompt "Neues Verzeichnis angeben"
New-Item $neuordner -ItemType Directory

1..10 | ForEach-Object {
    if ($_ -lt 10) {
        $nr = "0$_"
    }
    else {
        $nr = $_
    }

    $ordnername = "Ordner$nr"
    #Write-Output $ordnername
    New-Item $ordnername -ItemType Directory
}

1..10 | ForEach-Object {
    if ($_ -lt 10) {
        $nr = "0$_"
    }
    else {
        $nr = $_
    }

    $ordnername = "Ordner$nr"
    #Write-Output $ordnername
    Remove-Item $ordnername
}

get-childitem

# Vergleichsoperatoren
# ==            -eq (equal)  
# >=            -gt (greater than)
# <=            -lt (less than)
# !=            -ne (not equal)
# <>

"zdf.de", "google.de", "orf.at", "unsinn" | ForEach-Object {
    if(Test-Connection $_ -count 1 -quiet)
    {
        "$_ ist online"
    }
    else
    {
        "$_ ist offline"
    }
}


$computer = @"
Computer, URL
ZDF, zdf.de
GOOGLE, google.de
ORF, orf.at

"@

New-Item computer.csv -ItemType File -Value $computer -Force

Get-Content computer.csv

Import-Csv -Path computer.csv

Add-Content computer.csv -Value "JOYN, joyn.de"

Get-Content computer.csv

Import-Csv -Path computer.csv | ForEach-Object {
    $comp = $_.Computer
    $url = $_.URL
    "$comp => $url"
}

Import-Csv -Path computer.csv | ForEach-Object {
    $url = $_.URL
    if(Test-Connection $url -count 1 -quiet)
    {
        "$url ist online"
    }
    else
    {
        "$url ist offline"
    }
}

# $_ = Pipeline-Variable
# $PSitem = identisch mit $_

$string = "Peter, Paul, Mary"
$string = $string.replace(' ', '')
$string = $string.split(",")
#Write-Output $string

$string | ForEach-Object {
    $_
}

# Slicing
$anzahl = $string.Length # = Anzahl der Elemente in der Variable
Write-Host $anzahl

$c = 0
while($c -lt $anzahl)
{
    $string[$c]
    $c+=1
}


$daten = "Schaller, Peter", "Kohler, Paul", "Schiller, Mary"
$daten = $daten.replace(' ', '')


# Aufgabe:
# Emailadresse generieren, die folgendes Muster hat: p.schaller@meinefirma.de

$daten | ForEach-Object {
    $splitted = $_.split(",")
    $name = $splitted[0]
    $vorname = $splitted[1][0]
    #"$name - $vorname"
    $email = "$vorname.$name@meinefirma.de"
    $email = $email.ToLower()   # .ToUpper()
    Write-Host $email
}

# 1. Erstellen Sie eine CSV-Datei "mitarbeiter.csv" mit den Daten aus der Variablen "$daten"
# 2. Durchlaufen Sie die Datei und erzeugen die Email-Adressen nach o.g. Muster (import-csv...)
# 3. Schreiben Sie Name,Vorname und Email in eine neue CSV-Datei "mitarbeiter_email.csv"

# Zusatzaufgabe:
# 1. Erstellen Sie eine Datei "verzeichnis.csv" mit folgendem Inhalt:
<#
Verzeichnis
Protokolle
Arbeitsvertraege
Arbeitsvertraege
Abmahnungen
Kuendigungen

2. Legen Sie einen Ordner "C:\verzeichnisse"
3. In diesem Ordner sollen alle Ordner aus der verzeichnis.csv angelegt werden
4. In jedem der Ordner soll eine Datei "readme.txt" enthalten sein mit dem Inhalt "Erstellt von: Ihr Name"
#>