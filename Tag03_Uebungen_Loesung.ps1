$hauptmenue = @"
1 - Datei suchen
2 - Neue IP erfassen
3 - Lokale User
4 - Inhalte suchen
0 - Beenden
"@

$untermenue = @"
    31 Lokale User anzeigen
    32 Lokalen User anlegen
    33 Lokalen User löschen
    34 User aus Datei anlegen
"@

$auswahl = ""

New-Item -Path C:\test1000\ip_adressen.csv -ItemType File -Force
Add-Content -Path C:\test1000\ip_adressen.csv -Value "IP,User"

do {
    Clear-Host
    #if($auswahl -eq '3' -or $auswahl -eq '31' -or $auswahl -eq '32' -or $auswahl -eq '33')
    if($auswahl -like '3*')
    {
        write-host $untermenue
        $username = Read-Host -Prompt "Username eingeben"

        if($auswahl -eq '31')
        {
            if(Get-LocalUser -Name $username)
            {
                Get-LocalUser -Name $username | Select-Object -Property Name, Fullname, Description
            }
            else
            {
                Write-Host "User nicht vorhanden"
            }
        }
    }
    else
    {
        write-host $hauptmenue
        if($auswahl -eq '1')
        {
            Clear-Host
            write-output "---------------------"
            Write-Output "Datei suchen"
            write-output "---------------------"
            $datei = Read-Host -Prompt "Dateinamen eingeben"
            Get-ChildItem -Path C:\test1000\$datei*.* -Recurse
        }
        elseif($auswahl -eq '2')
        {
            write-output "---------------------"
            Write-Output "IP-Adresse erfassen"
            write-output "---------------------"
            $ip = Read-Host -Prompt "IP eingeben"
            $User = Read-Host -Prompt "User eingeben"
            Add-Content -Path C:\test1000\ip_adressen.csv -Value "$ip,$user"
        }
        elseif($auswahl -eq '3')
        {

        }
        elseif($auswahl -eq '4')
        {

        }

    }
    $auswahl = Read-Host -Prompt "Bitte wählen"

} while($auswahl -ne '0')



# 1. Datei suchen: Get-ChildItem
# 2. Read-Host / Add-Content
# 3. Read-Host => Variable / Write-Host Variable


###### Vergleichsoperatoren [S. 133] ######
# -lt          <
# -gt          >
# -le          <=
# -ge          >=
# -ne          != / <>
# -eq          ==
# -like        like 'x*' / 'x%'
# -notlike
# -is          Typvergleich (is [DateTime])
# -in          beinhaltet    
# -contains       =
# -notin
# -notcontains
