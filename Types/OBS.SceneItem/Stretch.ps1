<#
.SYNOPSIS
    Stretches a scene item
.DESCRIPTION
    Stretches a scene item by changing it's bounds.   
#>
param()

$PassingThru = $false
$allArguments = @($args)
$animateArguments = @(
foreach ($arg in $allArguments) {    
    if ($arg -is [double] -or $arg -is [int] -or 
        ($arg -is [string] -and $arg -match '\%$')
    ) {
        $scale = $arg
        @{scaleX=$scale;scaleY=$scale}
    }    
    elseif ($arg -as [timespan]) {
        $arg
    } elseif ($arg -is [bool]) {
        if ($arg) {
            $PassingThru = $true
        }
        $arg
    } else {
        $scaleInfo = @{}
        
        if ($null -ne $arg.Width) {
            $scaleInfo.boundsWidth = $arg.Width
        }
        elseif ($null -ne $arg.X) {
            $scaleInfo.boundsWidth = $arg.X
        }        

        if ($null -ne $arg.Height) {
            $scaleInfo.boundsHeight = $arg.Height
        }
        elseif ($null -ne $arg.Y) {
            $scaleInfo.boundsHeight = $arg.Y
        }
        
        if ($scaleInfo.Count) {
            $scaleInfo
        } else {
            $arg
        }            
    }
})

$this | Set-OBSSceneItemTransform -SceneItemTransform @{boundsType='OBS_BOUNDS_STRETCH'} -NoResponse -PassThru:$PassingThru
$this.Animate.Invoke($animateArguments)
