function Set-OBSShaderFilter {
    <#
    
    .SYNOPSIS    
        Sets a Shader filter.    
    .DESCRIPTION    
        Adds or Changes a Shader Filter on an OBS Input.    
        This requires that the [OBS Shader Filter](https://github.com/exeldro/obs-shaderfilter) is installed.    
    .EXAMPLE    
        Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
            Set-OBSShaderFilter -FilterName "FisheyeShader" -ShaderFile fisheye-xy -ShaderSetting @{    
                center_x_percent=30    
                center_y_percent=70    
            }    
    .EXAMPLE    
        Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
            Set-OBSShaderFilter -FilterName "SeasickShader" -ShaderFile seasick -ShaderSetting @{    
                amplitude = 0.05    
                speed = 0.5    
                frequency = 12    
                opacity = 1    
            }    
    .EXAMPLE    
        Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
            Set-OBSShaderFilter -FilterName "TwistShader" -ShaderFile twist -ShaderSetting @{    
                center_x_percent=50    
                center_y_percent=50    
                power = 0.05    
                rotation = 80    
            }    
    
    #>
            
    [Alias('Add-OBSShaderFilter')]
    param(
    # The text of the shader    
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]$ShaderText,

    # The file path to the shader, or the short file name of the shader.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ShaderName')]
    [string]
    $ShaderFile,

    # Any other settings for the shader.    
    # To see what the name of a shader setting is, change it in the user interface and then get the input's filters.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ShaderSettings')]
    [PSObject]
    $ShaderSetting,

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
        process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
        if (-not $myParameters["FilterName"]) {
            $filterName = $myParameters["FilterName"] = "Shader"
        }

        $shaderSettings = [Ordered]@{}
        if ($ShaderText) {
            $shaderSettings.shader_text = $ShaderText
        }
        elseif ($ShaderFile) {
            if ($ShaderFile -match '[\\/]') {
                $shaderSettings.shader_file_name = "$($ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($ShaderFile))" -replace "\\", "/"
            } else {
                if (-not $script:CachedOBSShaderFilters) {
                    $script:CachedOBSShaderFilters = 
                        Get-OBS | # Get the OBS object
                            Select-Object -ExpandProperty Process | # which has a process
                            Split-Path | Split-Path | Split-Path  | # from it's parent path, we go up three levels.
                            Join-Path -ChildPath data | Join-Path -ChildPath obs-plugins | # then down into plugin data.
                            Get-ChildItem -Filter obs-shaderfilter |
                            Get-ChildItem -Filter examples |
                            Get-ChildItem -File # get all of the files in this directory

                }

                $foundShaderFile = $script:CachedOBSShaderFilters |
                    Where-Object Name -Like "$shaderFile*" |
                    Select-Object -First 1

                if ($foundShaderFile) {
                    $shaderSettings.shader_file_name = $foundShaderFile.FullName -replace "\\", "/"
                }
            }
        }

        if ($shaderSetting) {
            if ($shaderSetting -is [Collections.IDictionary]) {
                foreach ($kv in $shaderSetting.GetEnumerator()) {
                    $shaderSettings[$kv.Key] = $kv.Value
                }
            } elseif ($shaderSetting -is [psobject]) {
                foreach ($prop in $shaderSetting.psobject.properties) {
                    $shaderSettings[$prop.Name] = $prop.Value
                }
            }
        }

        if ($shaderSettings.shader_file_name) {
            $shaderSettings.from_file = $true
        }
                            
        
        $addSplat = @{            
            filterName = $myParameters["FilterName"]
            SourceName = $myParameters["SourceName"]
            filterKind = "shader_filter"
            filterSettings = $shaderSettings
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

        # Add the filter.
        $outputAddedResult = Add-OBSSourceFilter @addSplat *>&1

        # If we got back an error
        if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
            # and that error was saying the source already exists, 
            if ($outputAddedResult.TargetObject.d.requestStatus.code -eq 601) {
                # then check if we use the -Force.
                if ($Force)  { # If we do, remove the input                    
                    Remove-OBSSourceFilter -FilterName $addSplat.FilterName -SourceName $addSplat.SourceName
                    # and re-add our result.
                    $outputAddedResult = Add-OBSInput @addSplat *>&1
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


