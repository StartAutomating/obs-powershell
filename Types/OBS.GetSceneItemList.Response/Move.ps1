filter ToPosition {
    param(
    [switch]
    $Width,

    [switch]
    $Height
    )

    
    if ($_ -is [string] -and $_ -match '%$') {
        $_ = $_ -replace '%$' -as [double]
        if (-not $videoSettings) {
            $videoSettings = Get-OBSVideoSettings
        }
        if ($Width) {
            $_/100 * $videoSettings.baseWidth
        }
        if ($Height) {
            $_/100 * $videoSettings.baseHeight
        }
        
    }
    elseif ($_ -is [double] -or $_ -is [int]) {
        if ($_ -is [double] -and $_ -ge 0 -and $_ -le 1) {
            if (-not $videoSettings) {
                $videoSettings = Get-OBSVideoSettings
            }
            if ($Width) {
                $_ * $videoSettings.baseWidth
            }
            if ($Height) {
                $_ * $videoSettings.baseHeight
            }
            
        } else {
            [int]$_
        }
    }
}

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
    } elseif ($arg.X,$arg.Y, $arg.positionX, $arg.positionY -ne $null) {
        $scaleInfo = @{}
        
        
        if ($null -ne $arg.X) {
            $scaleInfo.positionX = $arg.X | . ToPosition -Width
        }
        elseif ($null -ne $arg.positionX) {
            $scaleInfo.positionX = $arg.positionX | . ToPosition -Width
        }

        if ($null -ne $arg.Y) {
            $scaleInfo.positionY = $arg.Y | . ToPosition -Height
        }
        elseif ($null -ne $arg.positionY) {
            $scaleInfo.positionY = $arg.positionY | . ToPosition -Height
        }
        
        $scaleInfo
    }    
    elseif ($arg -as [timespan]) {
        $arg
    } elseif ($arg -is [bool]) {
        $arg
    }
})

$this.Animate.Invoke($animateArguments)

