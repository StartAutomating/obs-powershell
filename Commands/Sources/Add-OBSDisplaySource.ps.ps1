function Add-OBSDisplaySource
{
    <#
    .SYNOPSIS
        Adds a display source
    .DESCRIPTION
        Adds a display source to OBS.  This captures the contents of the display.
    .EXAMPLE
        Add-OBSMonitorSource  # Adds a display source of the primary monitor
    .EXAMPLE
        Add-OBSMonitorSource -Display 2 # Adds a display source of the second monitor
    #>
    [inherit("Add-OBSInput", Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSMonitorSource')]
    param(
    # The monitor number.
    # This the number of the monitor you would like to capture.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("monitor")]
    [Alias('MonitorNumber','Display','DisplayNumber')]
    [int]
    $Monitor = 1,

    # If set, will capture the cursor.
    # This will be set by default.
    # If explicitly set to false, the cursor will not be captured.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("capture_cursor")]
    [switch]
    $CaptureCursor,

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
                
        $myParameterData = [Ordered]@{}
        foreach ($parameter in $MyInvocation.MyCommand.Parameters.Values) {

            $bindToPropertyName = $null            
            
            foreach ($attribute in $parameter.Attributes) {
                if ($attribute -is [ComponentModel.DefaultBindingPropertyAttribute]) {
                    $bindToPropertyName = $attribute.Name
                    break
                }
            }

            if (-not $bindToPropertyName) { continue }
            if ($myParameters.Contains($parameter.Name)) {
                $myParameterData[$bindToPropertyName] = $myParameters[$parameter.Name]
                if ($myParameters[$parameter.Name] -is [switch]) {
                    $myParameterData[$bindToPropertyName] = $parameter.Name -as [bool]
                }
            }
        }

        # Users like 1 indexed, computers like zero-indexed.
        $myParameterData["monitor"] = $Monitor - 1

        if (-not $myParameters["Name"]) {
            $myParameters["Name"] = "Display $($Monitor)"
        }

        $addObsInputParams = @{
            sceneName = $myParameters["Scene"]
            inputName = $myParameters["Name"]
            inputKind = "monitor_capture"
            inputSettings = $myParameterData
        }        

        # If -SceneItemEnabled was passed,
        if ($myParameters.Contains('SceneItemEnabled')) {
            # propagate it to Add-OBSInput.
            $addSplat.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }

        # Add the input.
        $outputAddedResult = Add-OBSInput @addObsInputParams *>&1

        # If we got back an error
        if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
            # and that error was saying the source already exists, 
            if ($outputAddedResult.TargetObject.d.requestStatus.code -eq 601) {
                # then check if we use the -Force.
                if ($Force)  { # If we do, remove the input                    
                    Remove-OBSInput -InputName $addObsInputParams.inputName
                    # and re-add our result.
                    $outputAddedResult = Add-OBSInput @addObsInputParams *>&1
                } else {
                    # Otherwise, get the input from the scene.
                    Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                        Where-Object SourceName -eq $myParameters["Name"]
                    $outputAddedResult = $null
                }
            }

            # If the output was still an error
            if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
                # use $psCmdlet.WriteError so that it shows the error correctly.
                $psCmdlet.WriteError($outputAddedResult)
            }            
        }
        # Otherwise, if we had a result
        elseif ($outputAddedResult) {
            # get the input from the scene.
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name
        }
    }
}