function Set-OBSSharpnessFilter
{
    <#
    .SYNOPSIS
        Sets a Sharpness filter.
    .DESCRIPTION
        Adds or Changes a Sharpness Filter on an OBS Input.

        This changes the sharpness of an image.
    .EXAMPLE
        Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |
            Set-OBSSharpnessFilter -Sharpness .75
    #>
    [inherit(Command={
        Import-Module ..\..\obs-powershell.psd1 -Global
        "Add-OBSSourceFilter"
    }, Dynamic, Abstract, ExcludeParameter='FilterKind','FilterName','FilterSettings')]
    [Alias('Add-OBSSharpnessFilter')]    
    param(
    # The Sharpness.
    [Parameter(ValueFromPipelineByPropertyName)]    
    [ComponentModel.DefaultBindingProperty("sharpness")]
    [ValidateRange(0,1)]
    [double]
    $Sharpness,
    
    # The name of the filter.  It will default to "ColorCorrection".
    [Parameter(ValueFromPipelineByPropertyName)]    
    [string]
    $FilterName,

    # If set, will remove a filter if one already exists.
    # If this is not provided and the filter already exists, the settings of the filter will be changed.
    [switch]
    $Force
    )
    
    process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
        if (-not $myParameters["FilterName"]) {
            $filterName = $myParameters["FilterName"] = "Sharpness"
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
        
        $addSplat = @{            
            filterName = $myParameters["FilterName"]
            SourceName = $myParameters["SourceName"]
            filterKind = "Sharpness_filter"
            filterSettings = $myParameterData
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

