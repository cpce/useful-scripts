# Check multiple services in $Services array and if they are not running. Attempt to start them.
# This script needs to be run with elevated permissions in order for it to interact with services.
# Created by Alexander Henderson github.com/alexandzors
trap [Exception]
{
	write-error $("TRAPPED: " + $_.Exception.Message);
}

$Services = 'Service1', 'Service2', 'Service3' <#You can add more services to the array here. Just make sure they are seperated by ','#>

foreach ($Service in $Services)
{
    $svc = Get-Service -Name $_$Service
    if ($svc.Status -ne 'Running') {
        $svc.Start()
        while ($svc.Status -ne 'Running') {
            Write-Host 'Waiting for' $Service 'to start.'
            Start-Sleep -Seconds 5
            $svc.Refresh()
        }
    }
    Write-Host $Service 'is started.' 
}