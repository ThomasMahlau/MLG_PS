# Werte in die Werte geben
1..10 | ForEach-Object {
    $_
}

"Peter", "Paul", "Mary" | ForEach-Object {
    $_
}

# Systemdaten auslesen
Get-Process | Get-Member
Get-Process | Select-Object -Property Processname, CPU -First 10

# 10 Prozesse mit höchster CPU-Auslastung
# Ausgabemöglichkeiten

Get-Process | Sort-Object CPU -Descending | select-object -Property Processname, CPU -First 10 | 
Out-GridView -PassThru | Stop-Process

Get-Process | Sort-Object CPU -Descending | select-object -Property Processname, CPU -First 10 |
Out-GridHtml

Get-Process | Sort-Object CPU -Descending | select-object -Property Processname, CPU -First 10 |
Out-HtmlView

Get-Process | Sort-Object CPU -Descending | select-object -Property Processname, CPU -First 10 |
Out-HtmlView

Get-Process | Sort-Object CPU -Descending | select-object -Property Processname, CPU -First 10 |
ConvertTo-Html | Out-File C:\test1000\10prozesse.html

notepad C:\test1000\10prozesse.html
Start-Process firefox C:\test1000\10prozesse.html

Get-Process | Where-Object {$_.ProcessName -Like '*fire*' -or $_.ProcessName -like '*fox*'}
Get-Process | Where-Object {$_.ProcessName -Like '*fire*'}
Get-Process | Where-Object ProcessName -Like '*fire*'

# Suchen von Inhalten in Dateien oder anderen Datenbeständen

'Hello', 'HELLO' | Select-String -Pattern 'hello'
'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive

Select-String -Path C:\Windows\Panther\setupact.log -Pattern 'First Boot'

Get-ChildItem -Path C:\Dokumente\MATERIALIEN\Coding_POWERSHELL\*.ps1 -Recurse |
    Select-String -Pattern 'Select-String' | Select-Object -first 5

Get-ChildItem -Path C:\Dokumente\MATERIALIEN\Coding_POWERSHELL\*.ps1 -recurse | Select-String -Pattern 'user101'

# Suche von Dateien

# Variante 1:
$pfad = "C:\Dokumente\MATERIALIEN\Coding_POWERSHELL\"
$suche = Read-Host -Prompt "Gesuchte Datei eingeben"
Get-ChildItem -Path $pfad -Filter "*$suche*" -File -Recurse  # WICHTIG: Anführungszeichen statt Hochkomma


# Ausgabe des Pfades und des Dateinamens in einer Tabelle
# Umwandeln in HTML-Code mit Verlinkung auf die jeweilige Datei
$pfad = "C:\Dokumente\MATERIALIEN\Coding_POWERSHELL\"
#$suche = Read-Host -Prompt "Gesuchte Datei eingeben"

Add-type -AssemblyName Microsoft.VisualBasic
$suche = [Microsoft.VisualBasic.Interaction]::InputBox("Dateinamen eingeben", "Teilzeichen reichen")

Get-ChildItem -Path $pfad -Filter "*$suche*" -File -Recurse |
Select-Object -Property Directory, Name | ForEach-Object {
    $pfad = $_.Directory
    $name = $_.Name
    $fullname = "$pfad\$name"
    $link = "<a href=$fullname>$name</a><br>"
    #Write-Host $link
    $datei+=$link
}

write-host $datei

$datei | Out-File C:\test1000\email.html -Force

Start-Process firefox C:\test1000\email.html

<#
Name
FullName (Verlinkung)
PSPath
Directory
DirectoryName
#>

Get-ChildItem| Get-Member

<a href=C:\Dokumente\MATERIALIEN\Coding_POWERSHELL\Einführungskurs\mitarbeiter_email.csv>mitarbeiter_email.csv</a>