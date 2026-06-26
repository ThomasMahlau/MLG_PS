# Logging in Skripts 

# Transcript
Start-Transcript -Path $home\transcriptlog.txt -Append
$comp = (Get-ADComputer -Filter *).Name
Test-Connection $comp -Count 1
Stop-Transcript

# Function
$LogFile = "$home\functionlog.log"
Function Write-Logfile {
   Param ([string]$LogString)
   Add-Content $LogFile -Value $LogString
}
Write-Logfile -LogString 'Fehler'
Write-Logfile -LogString ('{0} Fehler' -f (Get-Date))

# Add-Content
$comp = (Get-ADComputer -Filter *).Name
foreach ($item in $comp) {
    $test = Test-Connection $item -Count 1
    If ($test.Status -ne 'Success') {
        Add-Content -Path $home\addcontentlog.txt -Value "$(Get-Date) : $item is down."
    }
}

# Write-EventLog
$comp = (Get-ADComputer -Filter *).Name
foreach ($item in $comp) {
    $test = Test-Connection $item -Count 1
    If ($test.Status -ne 'Success') {
        Write-EventLog -LogName Application -Source "EventSystem" `
        -EventId 3001 -EntryType Error -Message "$item is down."
    }
}