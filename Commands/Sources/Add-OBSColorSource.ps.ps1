function Add-OBSColorSource
{
    <#
    .SYNOPSIS
        Adds a color source
    .DESCRIPTION
        Adds a color source to OBS.  This displays a single 32-bit color (RGBA).
    .EXAMPLE
        Add-OBSColorSource
    #>
    [inherit("Add-OBSInput", Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSMonitorSource')]
    param(
    

    # The name of the scene.
    # If no scene name is provided, the current program scene will be used.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('SceneName')]
    [string]
    $Scene,

    # The name of the input.
    # If no name is provided, "Display $($Monitor + 1)" will be the input source name.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('InputName')]
    [string]
    $Name,
    
    [ValidatePattern('\#(?>[0-9a-f]{8}|[0-9a-f]{6}|[0-9a-f]{4}|[0-9a-f]{3})')]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Color,

    # If set, will check if the source exists in the scene before creating it and removing any existing sources found.
    # If not set, you will get an error if a source with the same name exists.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force
    )
    
    process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
        if (-not $myParameters["Scene"]) {
            $myParameters["Scene"] = Get-OBSCurrentProgramScene
        }

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
        
                
        if (-not $myParameters["Name"]) {
            $myParameters["Name"] = "#$hexColor"
        }
        
        $myParameterData = [Ordered]@{color=$realColor}

        $addObsInputParams = @{
            sceneName = $myParameters["Scene"]
            inputName = $myParameters["Name"]
            inputKind = "color_source_v3"
            inputSettings = $myParameterData
        }

        # If -Force is provided
        if ($Force) {
            # Clear any items from that scene
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $myParameters["Name"] |
                Remove-OBSInput -InputName { $_.SourceName }
        }


        # If -SceneItemEnabled was passed,
        if ($myParameters.Contains('SceneItemEnabled')) {
            # propagate it to Add-OBSInput.
            $addObsInputParams.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }

        $outputAddedResult = Add-OBSInput @addObsInputParams
        if ($outputAddedResult) {
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $myParameters["Name"]
        }
    }
}
