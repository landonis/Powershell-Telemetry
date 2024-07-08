<# Using tasklist results vs Get-Process #>

$origin = tasklist /V /FO csv | ConvertFrom-CSV

$output = New-Object PSCustomObject[] ($origin.Length)

for ($i=0; $i -lt $origin.Length; $i++)
{
    $output[$i] = [PSCustomObject]@{
        taskName = [String] $origin[$i].'Image Name'
        user = [String] $origin[$i].'User Name'
        pid = [Int] $origin[$i].PID
        sessionType = [String] $origin[$i].'Session Name'
        session = [Int] $origin[$i].'Session#'
        memoryUsage = [Int] ($origin[$i].'Mem Usage' -replace '[a-z]')
    }
}

