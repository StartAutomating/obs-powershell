function Set-OBSVLCSource
{
    <#
    .SYNOPSIS
        Adds a VLC playlist source
    .DESCRIPTION
        Adds or sets VLC playlist sources to OBS.

        VLC must be installed for this to work.
    .EXAMPLE
        Set-OBSVLCSource -FilePath .\*.mp3 # Creates a playlist of all MP3s in the current directory
    .LINK
        Add-OBSInput
    .LINK
        Set-OBSInputSettings
    #>
    [inherit("Add-OBSInput", Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSVLCSource','Set-OBSPlaylistSource','Add-OBSPlaylistSource','Get-OBSVLCSource','Get-OBSPlaylistSource')]
    param(
    # The path to the media file.
    [Parameter(ValueFromPipelineByPropertyName)]    
    [Alias('FullName','LocalFile','local_file','Playlist')]
    [string[]]
    $FilePath,

    # What to select in the playlist.
    # If a number is provided, this will select an index.
    # If a string is provided, this will select the whole name or last part of a name, accepting wildcards.
    # If an `[IO.FileInfo]` is provided, this will be the exact file.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateTypes(TypeName={[int],[string],[IO.FileInfo]})]
    [Alias('SelectIndex','SelectName')]
    $Select,

    # If set, will shuffle the playlist        
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("shuffle")]
    [switch]
    $Shuffle,

    # If set, the playlist will loop.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("loop")]
    [Alias('Looping')]
    [switch]
    $Loop,

    # If set, will show subtitles, if available.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("subtitle_enable")]
    [Alias('ShowSubtitles','Subtitles')]
    [switch]
    $Subtitle,
        
    # The selected audio track number.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("track")]    
    [int]
    $AudioTrack,

    # The selected subtitle track number.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("subtitle")]    
    [int]
    $SubtitleTrack,
    
    # The name of the scene.
    # If no scene name is provided, the current program scene will be used.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Scene,

    # The name of the input.
    # If no name is provided, the last segment of the URI or file path will be the input name.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # If set, will check if the source exists in the scene before creating it and removing any existing sources found.
    # If not set, you will get an error if a source with the same name exists.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force,

    # If set, will fit the input to the screen.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $FitToScreen
    )

    begin {
        filter OutputAndFitToScreen {
            if ($FitToScreen -and $_.FitToScreen) {
                $_.FitToScreen()
            }
            $_
        }
        $InputKind = "vlc_source"
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
        
        $allPaths = @(foreach ($path in $FilePath) {
            foreach ($_ in $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($path)) {
                $_.Path
            }
        })
        $playlistObject = @(
            $currentIndex = 0 
            foreach ($path in $allPaths) {
                $currentIndex++
                $selected = $Select -and (
                    ($select -is [int] -and $currentIndex -eq $select) -or
                    ($select -is [IO.FileInfo] -and $path -eq $select.FullName) -or
                    ($select -is [string] -and 
                        ($path -like $select -or ($path | Split-Path -Leaf) -like $Select)
                    )
                )
                [PSCustomObject][Ordered]@{hidden=$false;selected=$selected;value=$path}
            }
        )
        $myParameterData['playlist'] = $playlistObject
 
        if (-not $Name) {
            $Name = $myParameters["Name"] = $FilePathItem.Name
        }

        $addSplat = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = $InputKind
            inputSettings = $myParameterData
            inputName = $Name
            NoResponse = $myParameters["NoResponse"]
        }

        if ($myParameters.Contains('SceneItemEnabled')) {
            $addSplat.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }

        # If -PassThru was passed
        if ($MyParameters["PassThru"]) {
            # pass it down to each command
            $addSplat.Passthru = $MyParameters["PassThru"]
            # If we were called with Add-
            if ($MyInvocation.InvocationName -like 'Add-*') {
                Add-OBSInput @addSplat # passthru Add-OBSInput
            } else {
                # Otherwise, remove SceneItemEnabled, InputKind, and SceneName
                $addSplat.Remove('SceneItemEnabled')
                $addSplat.Remove('inputKind')
                $addSplat.Remove('sceneName')
                # and passthru Set-OBSInputSettings.
                Set-OBSInputSettings @addSplat
            }
            return
        }

        # Add the input.
        $outputAddedResult = Add-OBSInput @addSplat *>&1

        # If we got back an error
        if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
            # and that error was saying the source already exists, 
            if ($outputAddedResult.TargetObject.d.requestStatus.code -eq 601) {
                # then check if we use the -Force.
                if ($Force)  { # If we do, remove the input                    
                    Remove-OBSInput -InputName $addSplat.inputName
                    # and re-add our result.
                    $outputAddedResult = Add-OBSInput @addSplat *>&1
                } else {
                    # Otherwise, get the input from the scene,
                    $sceneItem = Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                        Where-Object SourceName -eq $myParameters["Name"]
                    # update the input settings
                    $sceneItem.Input.Settings = $addSplat.inputSettings
                    $sceneItem # and return the scene item.
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
        if ($outputAddedResult -and 
            $outputAddedResult -isnot [Management.Automation.ErrorRecord]) {
            # get the input from the scene and optionally fit it to the screen.
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name |
                OutputAndFitToScreen
        }
    }
}