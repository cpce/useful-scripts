# DESCRIPTION
# This script will remove any torrents that are listed as Completed for over 15 minutes in qBittorrent.

# CONFIG

# Torrents removed if Completed this many minutes ago or older
$PruneAfterMins = 15

# URL of your server including http(s) and port of the WebUI
$ServerURL = 'http://localhost:8080'

# SCRIPT
Clear-Host
$OlderThan = Get-Date (Get-Date).AddMinutes($PruneAfterMins * -1)

$Result = Invoke-RestMethod -Uri "$ServerURL/query/torrents?filter=completed"

foreach ($Torrent in $result) {
    # timestamps are in UTC
    $Fin = [timezone]::CurrentTimeZone.ToLocalTime((Get-Date 01.01.1970) + ([System.TimeSpan]::fromseconds($Torrent.completion_on)))
    $Prune = ($Fin -lt $OlderThan)
    Write-Output $Torrent.name
    Write-Output ('Hash = ' + $Torrent.hash)
    Write-Output ('Finished on ' + $Fin + ' [' + $Torrent.completion_on + ']')
    Write-Output "Prune = $Prune"
    Write-Output ""

    If ($Fin) {
        $Body = ('hashes=' + $Torrent.hash)
        Invoke-RestMethod -Method Post -Uri "$ServerURl/command/delete" -Body $Body
    }
   
}
