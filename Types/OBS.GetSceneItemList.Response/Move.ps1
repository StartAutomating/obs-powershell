<#
.SYNOPSIS
    Moves a scene item
.DESCRIPTION
    Moves a scene item throughout the screen.

    This converts it's arguments to .Animate arguments.  Any single values will be assumed to be positionX/positionY
.EXAMPLE
    # Load a source
    $stars = Add-OBSBrowserSource -URI https://pssvg.start-automating.com/Examples/Stars.svg
    # fit it to the screen
    $stars.FitToScreen()
    # Move it diagonally across the screen
    $stars.Move("-50%","150%", "00:00:05")
.LINK
    OBS.GetSceneItemList.Response.Animate
#>
param()
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

