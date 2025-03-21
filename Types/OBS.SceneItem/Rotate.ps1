param()
$allArguments = @($args)

$animateArguments  = @(
    foreach ($argument in $allArguments) {
        if ($argument -is [double] -or $argument -is [int]) {
            @{
                rotation = $argument
            }
        } elseif ($argument -as [timespan]) {
            $argument
        } elseif ($argument -is [bool]) {
            $argument
        }
    }
)

$this.Animate.Invoke($animateArguments)