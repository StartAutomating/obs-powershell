param()

$allArguments = @($args)
$animateArguments = @(
foreach ($arg in $allArguments) {    
    if ($arg -is [double] -or $arg -is [int] -or 
        ($arg -is [string] -and $arg -match '\%$')
    ) {
        $scale = $arg
        @{scaleX=$scale;scaleY=$scale}
    } elseif ($null -ne $arg.X -or $null -ne $arg.Y) {
        $scaleInfo = @{}
        
        if ($null -ne $arg.X) {
            $scaleInfo.scaleX = $arg.X
        }
        elseif ($null -ne $arg.scaleX) {
            $scaleInfo.scaleX = $arg.scaleX
        }

        if ($null -ne $arg.Y) {
            $scaleInfo.scaleY = $arg.Y
        }
        elseif ($null -ne $arg.scaleY) {
            $scaleInfo.scaleY = $arg.scaleY
        }
        
        $scaleInfo
    }    
    elseif ($arg -as [timespan]) {
        $arg
    } elseif ($arg -is [bool]) {
        $arg
    } else {
        $arg
    }
})

$this.Animate.Invoke($animateArguments)
