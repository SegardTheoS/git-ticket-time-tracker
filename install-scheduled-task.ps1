$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$TrackerScript = Join-Path $ScriptRoot "sx-tracker.ps1"

if (!(Test-Path $TrackerScript)) {
    Write-Host "Tracker script not found: $TrackerScript"
    exit 1
}

$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$TrackerScript`""

$Trigger = New-ScheduledTaskTrigger -AtLogOn

Register-ScheduledTask `
    -TaskName "SX Git Time Tracker" `
    -Action $Action `
    -Trigger $Trigger `
    -Description "Track Git branch time for SX" `
    -Force

Write-Host "Scheduled task installed."
Write-Host "Script used: $TrackerScript"