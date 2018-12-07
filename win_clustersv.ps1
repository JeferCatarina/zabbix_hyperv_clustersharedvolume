# Discovery Cluster Shared Volume

# Counter
$C = 0

<# --- Without arguments --- #>
If ( -Not $args[0]) {Write-Output "Usage: win_clustersv.ps1 path|name"; exit}

<# --- ClusterSharedVolume Path --- #>
If ( $args[0] -eq "path") {

$LDDCSV = (Get-ClusterSharedVolume).Name
# Counter
$C = 0
$F = $LDDCSV.Count

# Start JSON
Write-Host "{"
Write-Host " `"data`":["

# For each server in $LDDCSV
Foreach ($LDDCSV in $LDDCSV)
   {
    # Counter to not print comma after last object
    $C++
    Write-Host "   {"
    $LDDCSVPATH = ((Get-ClusterSharedVolume | Where-Object {$_.Name -like "$LDDCSV"} | select -ExpandProperty SharedVolumeInfo | Select FriendlyVolumeName | ft -HideTableHeaders | Out-String).Trim()).replace("\", "\\")

    if ($LDDCSVPATH -ne "") { Write-Host "     ""{#CSVPATH}"": ""$LDDCSVPATH""" }

    if ($C -lt $F) { Write-Host "   }," }
    else { Write-Host "   }" }

    }
    Write-Host " ]"
    Write-Host "}"
}

<# --- ClusterSharedVolume Name --- #>
If ( $args[0] -eq "name") {

$LDDCSV = Get-WmiObject win32_PerfFormattedData_CsvFsPerfProvider_ClusterCSVFileSystem| Select Name
# Counter
$C = 0
$F = $LDDCSV.Count

# Start JSON
Write-Host "{"
Write-Host " `"data`":["

# For each server in $LDDCSV
Foreach ($LDDCSV in $LDDCSV)
   {
    $LDDCSVNAME = $LDDCSV.Name
    # Counter to not print comma after last object
    $C++
    Write-Host "   {"
    if ($LDDCSVNAME -ne "") { Write-Host "     ""{#CSVNAME}"": ""$LDDCSVNAME""" }

    if ($C -lt $F) { Write-Host "   }," }
    else { Write-Host "   }" }

    }
    Write-Host " ]"
    Write-Host "}"
}