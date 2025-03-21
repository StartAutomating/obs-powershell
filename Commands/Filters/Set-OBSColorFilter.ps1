function Set-OBSColorFilter {
    <#
    
    .SYNOPSIS    
        Sets a color filter    
    .DESCRIPTION    
        Adds or Changes a Color Correction Filter on an OBS Input.    
        This allows you to:    
        * Change Opacity on any source    
        * Correct gamma    
        * Spin the hue    
        * Saturate or Desaturate an image    
        * Change the contrast    
        * Brighten the image    
        * Multiply pixels by a color    
        * Add a color to all pixels    
    .EXAMPLE    
        Show-OBS -Uri .\Assets\obs-powershell-animated-icon.svg |    
            Set-OBSColorFilter -Opacity .5    
    
    #>
            
    [Alias('Add-OBSColorFilter','Add-OBSColorCorrectionFilter','Set-OBSColorCorrectionFilter')]
    param(
    # The opacity, as a number between 0 and 1.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(0,1)]    
    [ComponentModel.DefaultBindingProperty("opacity")]
    [double]
    $Opacity,

    # The brightness, as a number between -1 and 1.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(-1,1)]    
    [ComponentModel.DefaultBindingProperty("brightness")]
    [double]
    $Brightness,

    # The constrast, as a number between -4 and 4.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(-4,4)]    
    [ComponentModel.DefaultBindingProperty("contrast")]
    [double]
    $Contrast,

    # The gamma correction, as a number between -3 and 3.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(-3,3)]
    [ComponentModel.DefaultBindingProperty("gamma")]
    [double]
    $Gamma,

    # The saturation, as a number between -1 and 5.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(-1,5)]
    [ComponentModel.DefaultBindingProperty("saturation")]
    [double]
    $Saturation,

    # The change in hue, as represented in degrees around a color cicrle    
    [Parameter(ValueFromPipelineByPropertyName)]    
    [ComponentModel.DefaultBindingProperty("hue_shift")]
    [Alias('Spin')]
    [double]
    $Hue,

    # Multiply this color by all pixels within the source.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("color_multiply")]
    [string]
    $MultiplyColor,

    # Add all this color to all pixels within the source.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("color_add")]
    [string]
    $AddColor,

    # If set, will remove a filter if one already exists.    
    # If this is not provided and the filter already exists, the settings of the filter will be changed.    
    [switch]
    $Force
    )
    dynamicParam {
    $baseCommand = 
        if (-not $script:AddOBSSourceFilter) {
            $script:AddOBSSourceFilter = 
                $executionContext.SessionState.InvokeCommand.GetCommand('Add-OBSSourceFilter','Function')
            $script:AddOBSSourceFilter
        } else {
            $script:AddOBSSourceFilter
        }
    $IncludeParameter = @()
    $ExcludeParameter = 'FilterKind','FilterSettings'


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
        begin {
        filter ToOBSColor {
        
                    if ($_ -is [uint32]) { $_ }
                    elseif ($_ -is [string]) {                
                        if ($_ -match '^\#[a-f0-9]{3,4}$') {                    
                            $_ = $_ -replace '[a-f0-9]','$0$0'                    
                        }                
        
                        if ($_ -match '^#[a-f0-9]{8}$') {                    
                            $_ -replace '#','0x' -as [UInt32]
                        }
                        elseif ($_ -match '^#[a-f0-9]{6}$') {                    
                            $_ -replace '#','0xff' -as [UInt32]
                        }
                    }            
                
        }
    
    }
        process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
        if (-not $myParameters["FilterName"]) {
            $FilterName = $myParameters["FilterName"] = "ColorCorrection"
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
        
        if ($myParameterData.color_add) {
            $myParameterData.color_add = $myParameterData.color_add | ToOBSColor
        }

        if ($myParameterData.color_multiply) {
            $myParameterData.color_multiply = $myParameterData.color_multiply | ToOBSColor
        }

        
        $addSplat = @{            
            filterName = $myParameters["FilterName"]
            SourceName = $myParameters["SourceName"]
            filterKind = "color_filter_v2"
            filterSettings = $myParameterData
            NoResponse = $myParameters["NoResponse"]
        }
        
        if ($MyParameters["PassThru"]) {
            $addSplat.Passthru = $MyParameters["PassThru"]
            if ($MyInvocation.InvocationName -like 'Add-*') {
                Add-OBSSourceFilter @addSplat
            } else {
                $addSplat.Remove('FilterKind')
                Set-OBSSourceFilterSettings @addSplat
            }
            return            
        }        

        # Add the input.
        $outputAddedResult = Add-OBSSourceFilter @addSplat *>&1

        if ($PassThru) {
            return $outputAddedResult
        }

        # If we got back an error
        if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
            # and that error was saying the source already exists, 
            if ($outputAddedResult.TargetObject.d.requestStatus.code -eq 601) {
                # then check if we use the -Force.
                if ($Force)  { # If we do, remove the input                    
                    Remove-OBSSourceFilter -FilterName $addSplat.FilterName -SourceName $addSplat.SourceName
                    # and re-add our result.
                    $outputAddedResult = Add-OBSSourceFilter @addSplat *>&1
                } else {
                    # Otherwise, get the existing filter.
                    $existingFilter = Get-OBSSourceFilter -SourceName $addSplat.SourceName -FilterName $addSplat.FilterName
                    # then apply the settings
                    $existingFilter.Set($addSplat.filterSettings)
                    # and output them
                    $existingFilter
                    # (don't forget to null the result, so we don't show this error)
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
            # Otherwise, get the input from the filters.
            Get-OBSSourceFilter -SourceName $addSplat.SourceName -FilterName $addSplat.FilterName
        }
    
    }
}

