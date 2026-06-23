# SX Time Tracker

Simple PowerShell tool that automatically tracks time spent on Git branches and generates a daily report.

## Why?

Many companies require developers to report time spent on Jira tickets, epics or projects.

Instead of manually estimating time at the end of the day, this tool records the active Git branch every minute and generates a summary.

Example:

```text
MC-5674 : 2.75 h
MC-6917 : 3.50 h
Internal : 1.00 h
```

## Features

- Automatic tracking
- Git branch detection
- Daily CSV logs
- PowerShell only
- No external dependencies
- Windows Task Scheduler integration

## Installation

```powershell
git clone https://github.com/<user>/sx-time-tracker.git
```

## Usage

Start tracker:

```powershell
.\sx-watch.ps1
```

Or automatically runs the script when the computer starts : 

```powershell
$Action = New-ScheduledTaskAction `
  -Execute "powershell.exe" `
  -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File C:\tools\sx-tracker\sx-watch.ps1"

$Trigger = New-ScheduledTaskTrigger -AtLogOn

Register-ScheduledTask `
  -TaskName "SX Git Time Tracker" `
  -Action $Action `
  -Trigger $Trigger `
  -Description "Track Git branch time for SX"
```

Generate report:

```powershell
.\sx-report.ps1
```

## Branch naming examples

```text
feature/MC-5674/optimisation-bi
feature/MC-6595/export
fix/15.6/MC-6583
fix/15.3/SX-6928/smtp
```

The tracker automatically extracts:

```text
MC-5674
MC-6595
MC-6583
SX-6928
```
