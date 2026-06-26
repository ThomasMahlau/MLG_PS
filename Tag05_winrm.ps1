# Remoting aktivieren (nur Client-OS)

Enable-PSRemoting         # oder
winrm qc
winrm get winrm/config

# Applies only to non-domain environments and WinRM

# Show TrustedHosts
Get-Item WSMan:\localhost\Client\TrustedHosts

# Set TrustedHosts
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '192.168.0.100'
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*' # allow all computers