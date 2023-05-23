param()

filter ToScale {
    if ($_ -is [string] -and $_ -match '%$') {
        $_ = $_ -replace '%$' -as [double]
        $_/100
    }
    elseif ($_ -is [double] -or $_ -is [int]) {
        if ($_ -is [double] -and $_ -ge 0 -and $_ -le 1) {
            $_
        } else {
            [double]$_/100
        }
    }
}

$allArguments = @($args)
$animateArguments = @(
foreach ($arg in $allArguments) {    
    if ($arg -is [double] -or $arg -is [int] -or 
        ($arg -is [string] -and $arg -match '\%$')
    ) {
        $scale = $arg | numToScale
        @{scaleX=$scale;scaleY=$scale}        
    } elseif ($arg.X -or $arg.Y) {
        $scaleInfo = @{}
        if ($null -ne $arg.X) {
            $scaleInfo.scaleX = $arg.X | numToScale
        }
        if ($null -ne $arg.Y) {
            $scaleInfo.scaleY = $arg.Y | numToScale
        }
        $scaleInfo
    } elseif ($arg -as [timespan]) {
        $arg
    } elseif ($arg -is [bool]) {
        $arg
    }
})

$this.Animate.Invoke($animateArguments)
