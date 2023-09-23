<#
.SYNOPSIS
    Sets the color.
.DESCRIPTION
    Changes the color of a color source.
#>
param(
[ValidatePattern('\#(?>[0-9a-f]{8}|[0-9a-f]{6}|[0-9a-f]{4}|[0-9a-f]{3})')]
[string]
$Color
)

$hexChar = [Regex]::new('[0-9a-f]')
$hexColors = @($hexChar.Matches($Color))

switch ($hexColors.Length) {
    8 {
        #full rgba
        $alpha = [byte]::Parse($hexColors[0..1] -join '', 'HexNumber')
        $red   = [byte]::Parse($hexColors[2..3] -join '', 'HexNumber')
        $green = [byte]::Parse($hexColors[4..5] -join '', 'HexNumber')
        $blue  = [byte]::Parse($hexColors[6..7] -join '', 'HexNumber')
    }
    6 {
        #rgb only, assume ff for alpha
        $alpha = 0xff
        $red   = [byte]::Parse($hexColors[0..1] -join '', 'HexNumber')
        $green = [byte]::Parse($hexColors[2..3] -join '', 'HexNumber')
        $blue  = [byte]::Parse($hexColors[4..5] -join '', 'HexNumber')
    }
    4 {
        #short rgba                
        $alpha = [byte]::Parse(($hexColors[0],$hexColors[0] -join ''), 'HexNumber')
        $red   = [byte]::Parse(($hexColors[1],$hexColors[1] -join ''), 'HexNumber')
        $green = [byte]::Parse(($hexColors[2],$hexColors[2] -join ''), 'HexNumber')
        $blue  = [byte]::Parse(($hexColors[3],$hexColors[3] -join ''), 'HexNumber')
    }
    3 {
        #short rgb, assume f for alpha
        $alpha = 0xff
        $red   = [byte]::Parse(($hexColors[0],$hexColors[0] -join ''), 'HexNumber')
        $green = [byte]::Parse(($hexColors[1],$hexColors[1] -join ''), 'HexNumber')
        $blue  = [byte]::Parse(($hexColors[2],$hexColors[2] -join ''), 'HexNumber')
    }
    0 {
        # No color provided, default to transparent black
        $alpha = 0
        $red   = 0
        $green = 0 
        $blue  = 0
    }
}

$hexColor = ("{0:x2}{1:x2}{2:x2}{3:x2}" -f $alpha, $blue, $green, $red)

$realColor = [uint32]::Parse($hexColor,'HexNumber')

$this | Set-OBSInputSettings -InputSettings ([Ordered]@{color=$realColor})



