<#
.SYNOPSIS
    Animates scene items
.DESCRIPTION
    Animates the motion of scene items within a frame.
.EXAMPLE
    $stars = Add-OBSBrowserSource -URI https://pssvg.start-automating.com/Examples/Stars.svg
    $stars.FitToScreen()
    $stars.Animate(@{
        scale = 0.1        
    },"00:00:01")
#>
param(
)

filter ToPosition {
    param(
    [switch]
    $Width,

    [switch]
    $Height
    )

    
    if ($_ -is [string] -and $_ -match '%$') {
        $_ = $_ -replace '%$' -as [double]
        if (-not $script:CachedOBSVideoSettings) {
            $script:CachedOBSVideoSettings = Get-OBSVideoSettings
        }
        $videoSettings = $script:CachedOBSVideoSettings
        if ($Width) {
            $_/100 * $videoSettings.baseWidth
        }
        if ($Height) {
            $_/100 * $videoSettings.baseHeight
        }
        
    }
    elseif ($_ -is [double] -or $_ -is [int]) {
        if ($_ -is [double] -and $_ -ge 0 -and $_ -lt 1) {
            if (-not $script:CachedOBSVideoSettings) {
                $script:CachedOBSVideoSettings = Get-OBSVideoSettings
            }
            $videoSettings = $script:CachedOBSVideoSettings
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

$nextTimeSpan = [timespan]0

$keyNames = 'boundsWidth','boundsHeight','positionX', 'positionY', 'scaleX','scaleY', 'cropBottom', 'cropLeft', 'cropRight', 'cropTop', 'rotation'
$keyAliases = [Ordered]@{'Rotate'='rotation'}
$duplicatedKeyAliases = [Ordered]@{
    'position' = 'positionX', 'positionY'
    'scale' = 'scaleX', 'scaleY'
    'crop' = 'cropBottom', 'cropLeft', 'cropRight', 'cropTop'
}
foreach ($position in 'X','Y') {
    $keyAliases[$position] = "position$position"
}
foreach ($cropType in 'Bottom','Left', 'Right', 'Top') {
    $keyAliases[$cropType] = "crop$cropType"
}
   
$allSteps = @()


$originalTransform = $this | Get-OBSSceneItemTransform
$lastFrom = 
    if ($originalTransform -is [Collections.IDictionary]) {
        [Ordered]@{} + $from
    } else {
        $newFrom = [Ordered]@{}
        foreach ($property in $originalTransform.psobject.properties) {
            $newFrom[$property.Name] = $property.Value
        }
        $newFrom
    }

$totalTimeSpan = [timespan]0

# We want to walk over every argument and turn them into a series of animations

$PassThru   = $false

$AllArgs = @($args)

$allSteps = @(
:NextArgument for ($argIndex = 0 ; $argIndex -lt $allArgs.Length; $argIndex++) {
    $arg = $allArgs[$argIndex]
    # If the arg is a timespan, we want to track this
    if ($arg -as [timespan]) {
        $nextTimeSpan = $arg -as [timespan]
    } elseif ($arg -is [double] -or $arg -is [int]) {
        $nextTimeSpan = [timespan]::fromSeconds($arg)
    }
    elseif ($arg -is [bool]) {
        if ($arg) {
            $PassThru = $true
        }
    }
    else {
        $currentTo = 
            if ($arg -isnot [Collections.IDictionary]) {
                $newTo = [Ordered]@{}
                foreach ($property in $arg.psobject.properties) {
                    $newTo[$property.Name] = $property.Value
                }
                $newTo
            } else {
                [Ordered]@{} + $arg
            }

        $badKey = 
            @(foreach ($k in @($currentTo.Keys)) {
                if ($k -notin $keyNames) {
                    if ($keyAliases[$k]) {
                        $currentTo[$keyAliases[$k]] = $currentTo[$k]
                        $currentTo.Remove($k)
                    } 
                    elseif ($duplicatedKeyAliases[$k]) {
                        foreach ($duplicateKey in $duplicatedKeyAliases[$k]) {
                            $currentTo[$duplicateKey] = $currentTo[$k]
                        }
                        
                        $currentTo.Remove($k)
                    }
                    else {
                        $k
                    }
                }
            })

        foreach ($checkKeyValue in @($currentTo.GetEnumerator())) {
            
            $newValue = 
                switch ($checkKeyValue.Key) {
                    positionX { $checkKeyValue.Value | ToPosition -Width }
                    positionY { $checkKeyValue.Value | ToPosition -Height }
                    cropLeft { $checkKeyValue.Value | ToPosition -Width }
                    cropRight { $checkKeyValue.Value | ToPosition -Width }
                    cropTop { $checkKeyValue.Value | ToPosition -Height }
                    cropBottom { $checkKeyValue.Value | ToPosition -Height }
                    scaleX { $checkKeyValue.Value | ToScale  }
                    scaleY { $checkKeyValue.Value | ToScale  }
                }

            if ($null -ne $newValue) {
                $currentTo[$checkKeyValue.Key] = $newValue
            }
            
        }
        
        if ($badKey) {
            throw "Cannot animate '$($badKey -join "','")' : Can only animate $($keyNames -join ',')"
        }

        if (-not $nextTimeSpan.TotalMilliseconds -and 
            ($argIndex -lt ($AllArgs.Length - 1)) -and 
            $AllArgs[$argIndex + 1] -as [timespan]
        ) {
            $nextTimeSpan = $AllArgs[$argIndex + 1] -as [timespan]
            $argIndex++
        }

        if ($lastFrom -and $nextTimeSpan) {
            $StepCount = [Math]::Ceiling($NextTimeSpan.TotalMilliseconds / ([timespan]::fromSeconds(1/30).TotalMilliseconds)) * 2            
            if (-not $StepCount) {
                $this | Set-OBSSceneItemTransform -SceneItemTransform $currentTo -PassThru
                $newLastFrom = [Ordered]@{} + $currentTo
                foreach ($kv in $lastFrom.GetEnumerator()) {
                    if ($currentTo.Contains($kv.Key)) { continue }
                    $newLastFrom[$kv.Key] = $kv.Value
                }
                $lastFrom = $newLastFrom # May need to join this with the remaining properties in from

                $totalTimeSpan += $nextTimeSpan
                $nextTimeSpan = [timespan]0
                continue NextArgument
            }

            $stepMilliseconds  = $nextTimeSpan.TotalMilliseconds / $StepCount

            
            # Compare the two sets of keys to determine the base data object
            $BaseObject = [Ordered]@{}
            foreach ($key in $currentTo.Keys) {
                if (-not $BaseObject[$key]) {
                    $BaseObject[$key] = 
                        if ($null -ne $lastFrom[$key]) {
                            $lastFrom[$key]
                        } else {
                            $currentTo[$key]
                        }
                }
            }                    

            # Determine the animation change per step.
            $eachStepValue = [Ordered]@{}
            foreach ($key in $baseObject.Keys) {
                $distance = try { $currentTo[$key] - $baseObject[$key] } catch { $null }
                if ($null -ne $distance) {
                    $eachStepValue[$key] = [float]$distance / $StepCount
                }
            }

            
            foreach ($stepNumber in 1..($stepCount)) {
                $stepObject = [Ordered]@{}
                foreach ($key in $BaseObject.Keys) {
                    $stepObject[$key] = $BaseObject[$key] + ($eachStepValue[$key] * $stepNumber)
                }
                $this | Set-OBSSceneItemTransform -SceneItemTransform $stepObject -PassThru
                Send-OBSSleep -SleepMillis $stepMilliseconds -PassThru
            }

        } else {
            $this | Set-OBSSceneItemTransform -SceneItemTransform $currentTo -PassThru
        }
        $newLastFrom = [Ordered]@{} + $currentTo
        foreach ($kv in $lastFrom.GetEnumerator()) {
            if ($currentTo.Contains($kv.Key)) { continue }
            $newLastFrom[$kv.Key] = $kv.Value
        }
        $lastFrom = $newLastFrom # May need to join this with the remaining properties in from

        $totalTimeSpan += $nextTimeSpan
        $nextTimeSpan = [timespan]0

        if (($argIndex -lt ($AllArgs.Length - 1)) -and 
            $AllArgs[$argIndex + 1] -as [timespan]
        ) {
            Send-OBSSleep -SleepMillis ($AllArgs[$argIndex + 1] -as [timespan]).TotalMilliseconds -PassThru
        }
    }

    $IsFirstArg = $false
}
)

if ($allSteps) {
    # If any boolean true was in the arguments, we're passing thru
    if ($PassThru) {
        $allSteps
    } else {
        # Send all of the steps to OBS.
        $allSteps | Send-OBS 
    }    
}
