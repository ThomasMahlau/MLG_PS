# Freigaben erstellen (Single)

Get-SmbShare
New-Item -ItemType Directory -Name Data01 -Path C:\
New-SmbShare -Name Data01 -Path C:\Data01 -FullAccess Jeder -Description 'Secret0'
Start-Process \\localhost\Data01
Grant-SmbShareAccess -Name Data01 -AccountName administrator -AccessRight Full -Confirm:$false -Verbose

# Freigaben erstellen (Multiple)

1..9 | ForEach-Object {New-Item -ItemType Directory -Path C:\Data01 -Name Ordner$_}

Get-ChildItem -Path C:\Data01 -Directory | 
ForEach-Object {New-SmbShare -Name $_.Name -Path $_.Fullname -FullAccess Jeder -Description Secret0}
Get-SmbShare

Remove-SmbShare -Name Data01 -Confirm:$false # Entfernen
Get-ChildItem -Path C:\Data01 -Directory | 
ForEach-Object {Remove-SmbShare -Name $_.Name -Confirm:$false}
Get-SmbShare
Remove-Item -Path C:\Data01 -Recurse -Confirm:$false