Write-FormatView -GroupByProperty SourceName -Property FilterName, Kind, Index, Enabled, Settings -VirtualProperty @{
    Settings = {
        ($_.Settings | Format-YAML).Trim()
    }
} -Wrap -TypeName OBS.GetSourceFilterList.Response, OBS.GetSourceFilter.Response -AlignProperty @{
    FilterName = "Left"
    Kind = "Right"
    Index      = "Center"
    Enabled    = "Center"
    Settings   = "Left"
}