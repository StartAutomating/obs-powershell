function Add-OBSMediaSource {
<#
    .SYNOPSIS
        Adds a media source
    .DESCRIPTION
        Adds a media source to OBS.
    .EXAMPLE
        Add-OBSMediaSource -FilePath My.mp4
    .LINK
        Add-OBSInput    
    
#>
    
    [Alias('Add-OBSFFMpegSource')]
[CmdletBinding()]
    param(
# The path to the media file.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]    
    [Alias('FullName','LocalFile','local_file')]
    [string]
    $FilePath,
# If set, the source will close when it is inactive.
    # By default, this will be set to true.
    # To explicitly set it to false, use -CloseWhenInactive:$false
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("close_when_inactive")]
    [switch]
    $CloseWhenInactive,
# If set, the source will automatically restart.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("looping")]
    [Alias('Looping')]
    [switch]
    $Loop,
# If set, will use hardware decoding, if available.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("hw_decode")]
    [Alias('HardwareDecoding','hw_decode')]
    [switch]
    $UseHardwareDecoding,
# If set, will clear the output on the end of the media.
    # If this is set to false, the media will freeze on the last frame.
    # This is set to true by default.
    # To explicitly set to false, use -ClearMediaEnd:$false
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("clear_on_media_end")]
    [Alias('ClearOnEnd','NoFreezeFrameOnEnd')]
    [switch]
    $ClearOnMediaEnd,
# Any FFMpeg demuxer options.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("ffmpeg_options")]
    [Alias('FFMpegOptions', 'FFMpeg_Options')]
    [string]
    $FFMpegOption,
# The name of the scene.
    # If no scene name is provided, the current program scene will be used.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Scene,
# The name of the input.
    # If no name is provided, the last segment of the URI or file path will be the input name.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Name
    )
dynamicParam {
    $baseCommand = 
        if (-not $script:AddOBSInput) {
            $script:AddOBSInput = 
                $executionContext.SessionState.InvokeCommand.GetCommand('Add-OBSInput','Function')
            $script:AddOBSInput
        } else {
            $script:AddOBSInput
        }
    $IncludeParameter = @()
    $ExcludeParameter = 'inputKind','sceneName','inputName'
    $DynamicParameters = [Management.Automation.RuntimeDefinedParameterDictionary]::new()            
    :nextInputParameter foreach ($paramName in ([Management.Automation.CommandMetaData]$baseCommand).Parameters.Keys) {
        if ($ExcludeParameter) {
            foreach ($exclude in $ExcludeParameter) {
                if ($paramName -like $exclude) { continue nextInputParameter}
            }
        }
        if ($IncludeParameter) {
            $shouldInclude = 
                foreach ($include in $IncludeParameter) {
                    if ($paramName -like $include) { $true;break}
                }
            if (-not $shouldInclude) { continue nextInputParameter }
        }
        
        $DynamicParameters.Add($paramName, [Management.Automation.RuntimeDefinedParameter]::new(
            $baseCommand.Parameters[$paramName].Name,
            $baseCommand.Parameters[$paramName].ParameterType,
            $baseCommand.Parameters[$paramName].Attributes
        ))
    }
    $DynamicParameters
}
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
        if (-not (Test-Path $FilePath)) {
            return
        }
        $FilePathItem = Get-Item -Path $FilePath
        $myParameterData['local_file'] = $FilePathItem.FullName -replace '/', '\'
 
        if (-not $Name) {
            $Name = $FilePathItem.Name
        }
        $outputAddedResult = Add-OBSInput -sceneName $myParameters["Scene"] -inputKind "ffmpeg_source" -inputSettings $myParameterData -inputName $Name
        if ($outputAddedResult) {
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name
        }
    
}
}
