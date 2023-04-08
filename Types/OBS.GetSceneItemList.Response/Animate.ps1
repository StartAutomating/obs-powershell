<#
.SYNOPSIS
    Animates scene items
.DESCRIPTION
    Animates the motion of scene items within a frame.
.EXAMPLE
#>
param(
# The set of values that you're animating from.
# Aka, the starting positions of the animation.
# Can be either a dictionary or an object.
# These take the values found in Set-OBSSceneItemTransform
$From,

# The set of values that you're animating to.
# Aka, the ending positions of the animation.
# Can be either a dictionary or an object.
# These take the values found in Set-OBSSceneItemTransform
$To,

# The timespan the animation will take.
[TimeSpan]
$TimeSpan = [timespan]::fromSeconds(1),

# The number of steps in the animation.
[int]
$StepCount
)

# If there's no step count
if (-not $StepCount) {
    $StepCount = [Math]::Ceiling($TimeSpan.TotalMilliseconds / ([timespan]::fromSeconds(1/30).TotalMilliseconds)) * 2
}

# Convert -From to a dictionary
$realFrom = 
    if ($from -is [Collections.IDictionary]) {
        [Ordered]@{} + $from
    } else {
        $newFrom = [Ordered]@{}
        foreach ($property in $from.psobject.properties) {
            $newFrom[$property.Name] = $property.Value
        }
        $newFrom
    }
    
# Convert -To to a dictionary
$realTo =
    if ($to -is [Collections.IDictionary]) {
        [Ordered]@{} + $to
    } else {
        $newTo = [Ordered]@{}
        foreach ($property in $to.psobject.properties) {
            $newTo[$property.Name] = $property.Value
        }
        $newTo
    }

$keyNames = 'positionX', 'positionY', 'scaleX','scaleY', 'cropBottom', 'cropLeft', 'cropRight', 'cropTop'

$badKey = 
    @(foreach ($k in @($realFrom.Keys) + @($realTo.Keys)) {
        if ($k -notin $keyNames) {
            $k      
        }
    })

if ($badKey) {
    throw "Cannot animate '$($badKey -join "','")' : Can only animate $($keyNames -join ',')"
}

# Compare the two sets of keys to determine the base data object
$BaseObject = [Ordered]@{}
foreach ($key in $realTo.Keys) {
    if (-not $BaseObject[$key]) {
        $BaseObject[$key] = 
            if ($realFrom[$key]) {
                $realFrom[$key]
            } else {
                $realTo[$key]
            }
    }
}

# Check for properties only defined in -From
foreach ($key in $realFrom.Keys) {
    if (-not $BaseObject[$key]) {
        $BaseObject[$key] = $realFrom[$key]
        $realTo[$key]     = $realFrom[$key]
    }
}

# Determine the animation change per step.
$eachStepValue = [Ordered]@{}
foreach ($key in $baseObject.Keys) {
    $distance = try { $realTo[$key] - $baseObject[$key] } catch { $null }
    if ($null -ne $distance) {
        $eachStepValue[$key] = [float]$distance / $StepCount
    }
}


# Get all of the steps
$allSteps = 
    foreach ($stepNumber in 0..($stepCount - 1)) {
        $stepObject = [Ordered]@{}
        foreach ($key in $BaseObject.Keys) {
            $stepObject[$key] = $BaseObject[$key] + ($eachStepValue[$key] * $stepNumber)
        }
        $this | Set-OBSSceneItemTransform -SceneItemTransform $stepObject -PassThru
    }

# Determine the time to wait per step.
$stepTime = [TimeSpan]::FromMilliseconds($TimeSpan.TotalMilliseconds / $StepCount)

# Send all of the steps to OBS.
$allSteps | Send-OBS -StepTime $stepTime