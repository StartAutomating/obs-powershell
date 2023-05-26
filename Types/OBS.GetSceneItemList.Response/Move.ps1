
$allArguments = @($args)
$animateArguments = @(
foreach ($arg in $allArguments) {    
    if (
        $arg -is [double] -or 
        $arg -is [int] -or
        ($arg -is [string] -and $arg -match '\%$')                
    ) {        
        $positionTransform = @{
            positionX = $arg
            positionY = $arg
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

