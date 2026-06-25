#### Foreach-Object ####
# nur in Pipeline verwendbar
# Aufgabe 12 nummerierte Monate ausgeben

1..12 | ForEach-Object {
    Write-Output "Monat$_"
}


#### Foreach ####
$jahr = 1..12

foreach($item in $jahr)
{
    Write-Output "Monat$item"
}


#### While ####
$mo = 1

while($mo -lt 13) {
   Write-Output "Monat$mo"
   $mo++
}


#### Fussgesteuerte do-Schleife mit while ####
# meist zum Steuern der "Lebensdauer" eines Programms
$mo = 1

do {
   Write-Output "Monat$mo"
   $mo++
} while($mo -lt 13)


## Anwendungsbeispiel: Einkaufsliste

# Menü
# 1 - Einkaufsliste anzeigen
# 2 - Neuen Artiekl erfasst
# 3 - Beenden

$menu = @"
1 - Einkaufsliste anzeigen
2 - Neuen Artiekl erfasst
3 - Beenden
"@


do {
    Write-Host $menu
    $eingabe = Read-Host -Prompt "Bitte auswählen"
    if($eingabe -lt 3) {
        Clear-Host
        Write-Output "Es wurde $eingabe gedrückt"
    } else {
        Clear-Host
        Write-Output "Und Tschüss"
    }
} while($eingabe -lt 3)


#### Fussgesteuerte do-Schleife mit until ####

$mo = 1

do {
   Write-Output "Monat$mo"
   $mo++
} until($mo -gt 12)


#### For-Schleife ####

for($mo=1; $mo -le 12; $mo++) {
   Write-Output "Monat$mo"
}

