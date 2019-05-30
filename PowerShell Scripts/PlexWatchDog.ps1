# This script should be used with Task Scheduler to run every 15 minutes. This script checks the web ui of Plex and if it does not load it force restarts the Plex Media Server process.
# If you want to have it log to the event viewer in Windows you will need to uncomment line # 11 and # 15 after running the following command in an elevated powershell window:
# New-EventLog -LogName PlexWatchDog -Source Plex

# Created by github.com/alexandzors

$HTTP_Request = [System.Net.WebRequest]::Create('http://localhost:32400/web/index.html')
$HTTP_Request.Timeout = 15000
$HTTP_Response = try {$HTTP_Request.GetResponse()} catch {"Webpage Timeout"}
$HTTP_Status = try {[int]$HTTP_Response.StatusCode} catch {"Webpage Timeout"}

If ($HTTP_Status -eq 200) { 
    Write-Host "Plex is currently responding.. Sleeping for 15 minutes.."
#    Write-EventLog -LogName PlexWatchDog -Source Plex -EventID 100 -EntryType Information -Message 'Plex is currently responding.. Sleeping for 15 minutes..' 
}
Else {
    write-host "Plex is currently not responding! Restarting plex service...";
 #   Write-EventLog -LogName PlexWatchDog -Source Plex -EventID 101 -EntryType Warning -Message 'Plex is currently not responding! Restarting Plex service...' 
    Stop-Process -processname "Plex*"; Start-Process 'C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Server.exe' -WorkingDirectory "C:\Program Files (x86)\Plex\Plex Media Server\" ; Start-Sleep -Seconds 5
}
