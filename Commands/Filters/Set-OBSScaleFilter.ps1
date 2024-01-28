function Set-OBSScaleFilter {
    <#
    
    .SYNOPSIS    
        Sets a Scale filter.    
    .DESCRIPTION    
        Adds or Changes a Scale Filter on an OBS Input.    
        This allows you to resize the image source.            
    .EXAMPLE    
        Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
            Set-OBSScaleFilter -Resolution "16:9"    
    
    #>
            
    [Alias('Add-OBSScaleFilter')]    
    param(
    # The Resolution.  Can either width x height (e.g. 1920x1080) or an aspect ratio (16:9).    
    [Parameter(ValueFromPipelineByPropertyName)]    
    [ComponentModel.DefaultBindingProperty("resolution")]
    [Alias('Scale')]
    [string]
    $Resolution,

    # The sampling method.  It will default to "lanczos".    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("sampling")]    
    [string]
    $Sampling = 'lanczos',

    # If set, will keep the aspect ratio when scaling.    
    # This is only valid if the sampling method is set to "lanczos".    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("undistort")]
    [Alias('Undistort')]
    [switch]
    $KeepAspectRatio,

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
            $filterName = $myParameters["FilterName"] = "Scale"
        }
        
        $addSplat = @{            
            filterName = $myParameters["FilterName"]
            SourceName = $myParameters["SourceName"]
            filterKind = "scale_filter"
            filterSettings = [Ordered]@{resolution=$Resolution;sampling=$Sampling;undistort=$KeepAspectRatio -as [bool]}
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


