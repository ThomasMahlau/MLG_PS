# Download PS 7
Start-BitsTransfer `
-Source https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/PowerShell-7.2.5-win-x64.msi `
-Destination (Join-Path -Path $home -ChildPath Downloads)

# Silent Installation
MsiExec.exe /i (Join-Path -Path $home -ChildPath Downloads\PowerShell-7.2.5-win-x64.msi) /qn

# oder

winget search PowerShell --accept-source-agreements
winget install Microsoft.PowerShell --accept-source-agreements --accept-package-agreements # PS 7

# Manuelle Installation empfohlen