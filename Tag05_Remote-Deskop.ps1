Invoke-Command -ComputerName srv-mb01 {

Set-ItemProperty `
-Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'`
-Name "fDenyTSConnections" -Value 0; `
Enable-NetFirewallRule -DisplayGroup "RemoteDesktop" # Achtung: auf englischem OS heisst die DisplayGroup "Remote Desktop"

}

#Pruefen
Get-ItemProperty `
-Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'`
-Name "fDenyTSConnections"
Get-NetFirewallRule -DisplayGroup "RemoteDesktop" | Select-Object Name,Enabled,Direction,Action