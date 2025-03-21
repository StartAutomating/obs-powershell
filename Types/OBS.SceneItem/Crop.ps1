$cropTable = [Ordered]@{
    cropBottom = 0
    cropLeft   = 0
    cropRight  = 0
    cropTop    = 0
}

$MatchingKey = [Regex]::new("(?>$(
    @($cropTable.Keys -join '|'
    '|'
    $cropTable.Keys -replace '^crop' -join '|') -join ''
))", 'IgnoreCase')


$currentKey = ''
foreach ($arg in $args) {
    if ($arg -is [Collections.IDictionary]) {
        foreach ($keyValue in $arg.GetEnumerator()) {
            if ($keyValue.Key -match $MatchingKey) {
                $cropTable[$matches.0 -replace '^crop' -replace '^', 'crop'] = $keyValue.Value
            }        
        }
    }
    if ($arg -is [string] -and $arg -match $MatchingKey) {
        $currentKey = $matches.0 -replace '^crop' -replace '^', 'crop'
    }
    if ($arg -is [int] -and $currentKey) {
        $cropTable[$currentKey] = $arg
        $currentKey = ''
    }
}

$this | Set-OBSSceneItemTransform -SceneItemTransform $cropTable
