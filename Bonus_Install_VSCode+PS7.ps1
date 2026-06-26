# Installation of PowerShell 7.2.5

# Download Powershell 7.2.5
Start-BitsTransfer `
-Source https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/PowerShell-7.2.5-win-x64.msi `
-Destination (Join-Path -Path $home -ChildPath Downloads)

# Silent Installation
MsiExec.exe /i (Join-Path -Path $home -ChildPath Downloads\PowerShell-7.2.5-win-x64.msi) /qn

# VS Code Installation 1.69.2

Start-BitsTransfer `
-Source 'https://az764295.vo.msecnd.net/stable/3b889b090b5ad5793f524b5d1d39fda662b96a2a/VSCodeUserSetup-x64-1.69.2.exe' `
-Destination (Join-Path -Path $home -ChildPath Downloads)

# Installation manuell (empfohlen)

