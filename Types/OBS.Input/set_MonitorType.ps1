param(
[string]
$MonitorType
)
$validValues = "Monitor", "MonitorAndOutput", "None","Off","OBS_MONITORING_TYPE_MONITOR_ONLY","OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT","OBS_MONITORING_TYPE_MONITOR_ONLY"

if ($MonitorType -notin $validValues) {
    throw "Invalid Value: '$MonitorType' is not in '$($validValues -join "','")'"
}

$realMonitorType = if ($MonitorType -like 'obs*') {
    $MonitorType.ToUpper()
} elseif ($MonitorType -eq 'Monitor') {
    "OBS_MONITORING_TYPE_MONITOR_ONLY"
} elseif ($MonitorType -eq 'MonitorAndOutput') {
    "OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT"
} else {
    "OBS_MONITORING_TYPE_NONE"
}

$this | Set-OBSInputAudioMonitorType -MonitorType $realMonitorType