$logDir = "$env:USERPROFILE\sx-tracker"
$logFile = "$logDir\$(Get-Date -Format 'yyyy-MM-dd').csv"

$data = Import-Csv $logFile -Delimiter ";"

$data |
    Group-Object ticket |
    Sort-Object Name |
    ForEach-Object {
        $minutes = $_.Count
        $hours = [math]::Round($minutes / 60, 2)
        "{0} : {1} h" -f $_.Name, $hours.ToString("0.00").Replace(".", ",")
    }