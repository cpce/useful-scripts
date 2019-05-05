# This script automatically rolls back Hyper-V VMs to the most recent checkpoint if it is powered off. However you could probably change that.
# Recommend using this with Task Scheduler on a set schedule.
# This script could also use some error handling as be default it doesn't.
# Created by Alexander Henderson github.com/alexandzors

# NOTE THIS REVERTS ANY HYPER-V VM THAT IS TURNED OFF WHEN THIS SCRIPT RUNS!

$VMs = Get-VM | Where {$_.State -eq 'OFF'} | Select Name

ForEach($VM in $VMs)
{
    $Snapshot = $VM.Name | Get-VMSnapshot | Sort CreationTime | Select -Last 1
    Write-Host $Snapshot.Name
    Restore-VMSnapshot -Name $Snapshot.Name -VMName $VM.name -Confirm:$false
    Start-Sleep -Seconds 30
    Start-VM $VM.name
}