
$allArguments = @($args)
$animateArguments = @(
foreach ($arg in $allArguments) {    
    if (
        ($arg -is [string] -and $arg -match '\%$') -or 
        ($arg -is [double] -and $arg -ge 0 -and $arg -le 1)
    ) {        
        $positionTransform = @{
            positionX = $arg | . ToPosition -Width
            positionY = $arg | . ToPosition -Height
        }
        $positionTransform
    } elseif ($arg.X,$arg.Y -ne $null) {
        $scaleInfo = @{}
                
        if ($null -ne $arg.X) {
            $scaleInfo.positionX = $arg.X
        }        

        if ($null -ne $arg.Y) {
            $scaleInfo.positionY = $arg.Y
        }        
        
        $scaleInfo
    }    
    elseif ($arg -as [timespan]) {
        $arg
    } elseif ($arg -is [bool]) {
        $arg
    }
    else {
        $arg
    }
})

$this.Animate.Invoke($animateArguments)

