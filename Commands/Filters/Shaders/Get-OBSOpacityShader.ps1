function Get-OBSOpacityShader {

[Alias('Set-OBSOpacityShader','Add-OBSOpacityShader')]
param(
# Set the Opacity of OBSOpacityShader
[ComponentModel.DefaultBindingProperty('Opacity')]
[Single]
$Opacity,
# The name of the source.  This must be provided when adding an item for the first time
[Parameter(ValueFromPipelineByPropertyName)]
[Alias('SceneItemName')]
[String]
$SourceName,
# The name of the filter.  If this is not provided, this will default to the shader name.
[Parameter(ValueFromPipelineByPropertyName)]
[String]
$FilterName,
# The inline value of the shader.  This will normally be provided as a default parameter, based off of the name.
[Alias('ShaderContent')]
[String]
$ShaderText,
# If set, will pass thru the commands that would be sent to OBS (these can be sent at any time with Send-OBS)
[Management.Automation.SwitchParameter]
$PassThru,
# If set, will not wait for a response from OBS (this will be faster, but will not return anything)
[Management.Automation.SwitchParameter]
$NoResponse
)


process {
if (-not $psBoundParameters['ShaderText']) {
    $shaderName = $shaderName    
    $ShaderNoun = 'OBSOpacityShader'
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Opacity shader - for OBS Shaderfilter
// Copyright 2021 by SkeltonBowTV
// https://twitter.com/skeletonbowtv
// https://twitch.tv/skeletonbowtv

uniform float Opacity<
    string label = "Opacity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 200.0;
    float step = 0.01;
> = 100.00; // 0.00 - 100.00 percent

float4 mainImage( VertData v_in ) : TARGET
{
	float4 color = image.Sample( textureSampler, v_in.uv );
	return float4( color.rgb, color.a * Opacity * 0.01 );
}
'
}
$MyVerb, $myNoun = $MyInvocation.InvocationName -split '-',2
if (-not $myNoun) {
    $myNoun = $myVerb
    $myVerb = 'Get'    
}
switch -regex ($myVerb) {
    Get {
        $FilterNamePattern = "(?>$(
            if ($FilterName) {
                [Regex]::Escape($FilterName)
            }
            else {
                [Regex]::Escape($shaderName),[Regex]::Escape($ShaderNoun -replace '^OBS' -replace 'Shader$') -join '|'
            }
        ))"
        if ($SourceName) {
            Get-OBSInput | 
                Where-Object InputName -eq $SourceName |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern
        } else {
            $obs.Inputs |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern
        }        
    }
    '(?>Add|Set)' {
        $ShaderSettings = [Ordered]@{}
        :nextParameter foreach ($parameterMetadata in $MyInvocation.MyCommand.Parameters[@($psBoundParameters.Keys)]) {
            foreach ($parameterAttribute in $parameterMetadata.Attributes) {
                if ($parameterAttribute -isnot [ComponentModel.DefaultBindingPropertyAttribute]) { continue }
                $ShaderSettings[$parameterAttribute.Name] = $PSBoundParameters[$parameterMetadata.Name]
                continue nextParameter
            }            
        }

        if (-not $PSBoundParameters['FilterName']) {
            $filterName = $PSBoundParameters['FilterName'] = $shaderName
        }

        $ShaderFilterSplat = [Ordered]@{
            ShaderSetting = $ShaderSettings
            FilterName = $FilterName
            SourceName = $SourceName
        }

        foreach ($CarryOnParameter in "PassThru", "NoResponse","Force") {
            if ($PSBoundParameters.ContainsKey($CarryOnParameter)) {
                $ShaderFilterSplat[$CarryOnParameter] = $PSBoundParameters[$CarryOnParameter]
            }
        }

        if ($myVerb -eq 'Add') {
            $ShaderFilterSplat.ShaderText = $shaderText
            Add-OBSShaderFilter @ShaderFilterSplat
        } else {
            Set-OBSShaderFilter @ShaderFilterSplat
        }
    }
}

}


} 

