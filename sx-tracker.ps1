function Get-SxSubjectFromBranch {
    param([string]$branch)

    $parts = $branch -split "/"

    if ($parts.Count -ge 3 -and $parts[0] -eq "fix") {
        return $parts[2]
    }

    if ($parts.Count -ge 2) {
        return $parts[1]
    }

    return $branch
}

$repo = Join-Path $HOME "Documents\GitHub\modulr"
$logDir = Join-Path $env:LOCALAPPDATA "git-ticket-time-tracker"
$logFile = Join-Path $logDir "$(Get-Date -Format 'yyyy-MM-dd').csv"

New-Item -ItemType Directory -Force -Path $logDir | Out-Null

if (!(Test-Path $logFile)) {
    "datetime;repo;branch;ticket" | Out-File $logFile -Encoding utf8
}

while ($true) {
    Set-Location $repo

    $branch = git branch --show-current 2>$null

    $ticket = Get-SxSubjectFromBranch $branch

    "$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'));$branch;$ticket" |
        Out-File $logFile -Append -Encoding utf8

    Start-Sleep -Seconds 60
}