function Set-OBSWindowSource
{
    <#
    .SYNOPSIS
        Adds or sets a window capture source
    .DESCRIPTION
        Adds or sets a windows capture source in OBS.  This captures the contents of a window.
    .EXAMPLE
        Get-Process -id $PID | Set-OBSWindowCaptureSource -Name CurrentWindow            
    #>
    [inherit("Add-OBSInput", Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSWindowSource','Set-OBSWindowCaptureSource','Add-OBSWindowCaptureSource','Get-OBSWindowSource','Get-OBSWindowCaptureSource')]
    param(
    # The monitor number.
    # This the number of the monitor you would like to capture.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ItemValue','ItemName','WindowName','MainWindowTitle')]
    [string]
    $WindowTitle,

    # The number of the capture method.  By default, automatic (0).
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("method")]
    [int]
    $CaptureMethod,

    # The capture priority.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('ExactMatch','SameType','SameExecutable')]
    [string]
    $CapturePriority,

    # If set, will capture the cursor.
    # This will be set by default.
    # If explicitly set to false, the cursor will not be captured.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("cursor")]    
    [switch]
    $CaptureCursor,

    # If set, will capture the client area.
    # This will be set by default.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("client_area")]    
    [switch]
    $ClientArea,

    # If set, will force SDR.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("force_sdr")]    
    [switch]
    $ForceSDR,

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

    begin {
        $InputKind = "window_capture"
    }
    
    process {
        # Copy the bound parameters
        $myParameters = [Ordered]@{} + $PSBoundParameters
        # and determine the name of the invocation
        $MyInvocationName  = "$($MyInvocation.InvocationName)"
        # Split it into verb and noun
        $myVerb, $myNoun   = $MyInvocationName -split '-'
        # and get a copy of ourself that we can call with anonymous recursion.
        $myScriptBlock     = $MyInvocation.MyCommand.ScriptBlock
        # Determine if the verb was get,
        $IsGet             = $myVerb -eq "Get"
        # if no verb was used,
        $NoVerb            = $MyInvocationName -match '^[^\.\&][^-]+$'
        # and if there were any other parameters then name
        $NonNameParameters = @($PSBoundParameters.Keys) -ne 'Name'

        # If it is a get or there was no verb
        if ($IsGet -or $NoVerb) {
            $inputsOfKind = # Get all inputs of this kind
                Get-OBSInput -InputKind $InputKind |
                    Where-Object {
                        if ($Name) { # If -Name was provided, 
                            $_.InputName -like $Name # filter by name (as a wildcard).
                        } else {
                            $_ #  otherwise, return every input.
                        }
                    }
            
            # If there were parameters other than name, 
            # and we were not explicitly called Get-*
            if ($NonNameParameters -and -not $IsGet) {
                # remove the name parameter
                if ($myParameters.Name) { $myParameters.Remove('Name') }
                # and pipe results back to ourself.
                $inputsOfKind | & $myScriptBlock @myParameters
            } else {
                # Otherwise, we're just getting the list of inputs                
                $inputsOfKind
            }
            # (either way, if we were called Get- or with no verb, we're done now).
            return
        }
        
        if (-not $myParameters["Scene"]) {
            $myParameters["Scene"] = Get-OBSCurrentProgramScene | 
                Select-Object -ExpandProperty currentProgramSceneName
        }

        
        if (-not $myParameters["WindowTitle"]) {
            while ($_ -is [Diagnostics.Process] -and -not $_.MainWindowTitle) {
                $_ = $_.Parent
            }
            if ($_.MainWindowTitle) {
                $WindowTitle = $myParameters["WindowTitle"] = "$($_.MainWindowTitle)"
            }
        }

        # Window capture is a bit of a tricky one.
        # In order to get the WindowTitle to match that OBS needs, we need to look thru the input properties list.
        # and for that, an input needs to exist.
        if (-not $myParameters["Name"]) {
            if ($myParameters["WindowTitle"]) {
                $Name = $myParameters["Name"] = "WindowCapture-" + $myParameters["WindowTitle"]
            }
            else {
                $Name = "WindowCapture"
            }
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
                    $myParameterData[$bindToPropertyName] = $myParameters[$parameter.Name] -as [bool]
                }
            }
        }

        if ($null -ne $CaptureMethod) {
            $myParameterData["method"] = $CaptureMethod
        }
        if ($CapturePriority -eq 'ExactMatch') {
            $myParameterData["priority"] = 1
        }
        elseif ($CapturePriority -eq 'SameType') {
            $myParameterData["priority"] = 0
        }
        elseif ($CapturePriority -eq 'SameExecutable') {
            $myParameterData["priority"] = 2
        }

        $addSplat = @{
            sceneName = $myParameters["Scene"]
            inputName = $myParameters["Name"]
            inputKind = "window_capture"
            inputSettings = $myParameterData
            NoResponse = $myParameters["NoResponse"]
        }        

        # If -SceneItemEnabled was passed,
        if ($myParameters.Contains('SceneItemEnabled')) {
            # propagate it to Add-OBSInput.
            $addSplat.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }

        # Add the input.
        $outputAddedResult = Add-OBSInput @addSplat *>&1        
        $possibleWindows = Get-OBSInputPropertiesListPropertyItems -InputName $addSplat.inputName -PropertyName window
        foreach ($windowInfo in $possibleWindows) {
            if (-not $WindowTitle) { continue }
            if (
                ($windowInfo.itemName -eq $WindowTitle) -or
                ($windowInfo.ItemValue -eq $WindowTitle) -or
                ($windowInfo.ItemName -replace '\[[^\[\]]+\]\:\s' -eq $WindowTitle) -or
                ($windowInfo.ItemValue -like "*$WindowTitle*") -or
                ($windowInfo.ItemName -like "*$WindowTitle*")
            ) {
                $myParameterData["window"] = $windowInfo.itemValue
                break
            }
        }

        # If -PassThru was passed
        if ($MyParameters["PassThru"]) {
            # pass it down to each command            
            # Otherwise, remove SceneItemEnabled, InputKind, and SceneName
            $addSplat.PassThru = $true
            $addSplat.Remove('SceneItemEnabled')
            $addSplat.Remove('inputKind')
            $addSplat.Remove('sceneName')
            # and passthru Set-OBSInputSettings.
            Set-OBSInputSettings @addSplat
            
            return
        }

        if ($Force)  { # If we do, remove the input                    
            Remove-OBSInput -InputName $addSplat.inputName
            # and re-add our result.
            $outputAddedResult = Add-OBSInput @addSplat *>&1
            # If the output was still an error
            if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
                # use $psCmdlet.WriteError so that it shows the error correctly.
                $psCmdlet.WriteError($outputAddedResult)
            }
            # Otherwise, if we had a result
            elseif ($outputAddedResult) {
                # get the input from the scene.
                Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                    Where-Object SourceName -eq $name
            }
        } else {
            # Otherwise, get the input from the scene,
            $sceneItem = Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $myParameters["Name"]
            # update the input settings
            $sceneItem.Input.Settings = $addSplat.inputSettings
            $sceneItem # and return the scene item.
        }
    }
}