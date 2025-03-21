function Get-OBSHeatWaveSimpleShader {

[Alias('Set-OBSHeatWaveSimpleShader','Add-OBSHeatWaveSimpleShader')]
param(
# Set the Rate of OBSHeatWaveSimpleShader
[ComponentModel.DefaultBindingProperty('Rate')]
[Single]
$Rate,
# Set the Strength of OBSHeatWaveSimpleShader
[ComponentModel.DefaultBindingProperty('Strength')]
[Single]
$Strength,
# Set the Distortion of OBSHeatWaveSimpleShader
[ComponentModel.DefaultBindingProperty('Distortion')]
[Single]
$Distortion,
# Set the Opacity of OBSHeatWaveSimpleShader
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
# If set, will force the recreation of a shader that already exists
[Management.Automation.SwitchParameter]
$Force,
# If set, will pass thru the commands that would be sent to OBS (these can be sent at any time with Send-OBS)
[Management.Automation.SwitchParameter]
$PassThru,
# If set, will not wait for a response from OBS (this will be faster, but will not return anything)
[Management.Automation.SwitchParameter]
$NoResponse,
# If set, use the shader elapsed time, instead of the OBS system elapsed time
[ComponentModel.DefaultBindingProperty('use_shader_elapsed_time')]
[Management.Automation.SwitchParameter]
$UseShaderTime
)


process {
$shaderName = 'heat-wave-simple'
$ShaderNoun = 'OBSHeatWaveSimpleShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Heat Wave Simple, Version 0.03, for OBS Shaderfilter
// Copyright ©️ 2022 by SkeletonBow
// License: GNU General Public License, version 2
//
// Contact info:
//		Twitter: <https://twitter.com/skeletonbowtv>
//		Twitch: <https://twitch.tv/skeletonbowtv>
//
// Description:
//		Generate a crude pseudo heat wave displacement on an image source.
//
// Based on:  https://www.shadertoy.com/view/td3GRn by Dombass <https://www.shadertoy.com/user/Dombass>
//
// Changelog:
// 0.03 - Added Opacity control
// 0.02 - Added crude Rate, Strength, and Distortion controls
// 0.01	- Initial release

uniform float Rate<
    string label = "Rate";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 5.0;
uniform float Strength<
    string label = "Strength";
    string widget_type = "slider";
    float minimum = -25.0;
    float maximum = 25.0;
    float step = 0.01;
> = 1.0;
uniform float Distortion<
    string label = "Distortion";
    string widget_type = "slider";
    float minimum = 3.0;
    float maximum = 20.0;
    float step = 0.01;
> = 10.0;
uniform float Opacity<
    string label = "Opacity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.00;

float4 mainImage( VertData v_in ) : TARGET
{
	float2 uv = v_in.uv;
	float distort = clamp(Distortion, 3.0, 20.0);

    // Time varying pixel color
    float jacked_time = Rate*elapsed_time;
    float2 scale = float2(0.5, 0.5);
	float str = clamp(Strength, -25.0, 25.0) * 0.01;
   	
    uv += str * sin(scale*jacked_time + length( uv ) * distort);
	float4 c = image.Sample( textureSampler, uv);
	c.a *= saturate(Opacity*0.01);
    return c;
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
                [Regex]::Escape($ShaderNoun -replace '^OBS' -replace 'Shader$'),[Regex]::Escape($shaderName) -join '|'
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
    'Remove' {
        if ($SourceName) {
            Get-OBSInput | 
                Where-Object InputName -eq $SourceName |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern |
                Remove-OBSSourceFilter
        }
    }
    '(?>Add|Set)' {
        $ShaderSettings = [Ordered]@{}
        :nextParameter foreach ($parameterMetadata in $MyInvocation.MyCommand.Parameters[@($psBoundParameters.Keys)]) {
            foreach ($parameterAttribute in $parameterMetadata.Attributes) {
                if ($parameterAttribute -isnot [ComponentModel.DefaultBindingPropertyAttribute]) { continue }
                $ShaderSettings[$parameterAttribute.Name] = $PSBoundParameters[$parameterMetadata.Name]
                if ($ShaderSettings[$parameterAttribute.Name] -is [switch]) {
                    $ShaderSettings[$parameterAttribute.Name] = $ShaderSettings[$parameterAttribute.Name] -as [bool]
                }
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

        if (-not $script:CachedShaderFilesFromCommand) {
            $script:CachedShaderFilesFromCommand = @{}
        }

        if ($Home -and -not $script:CachedShaderFilesFromCommand[$shaderName]) {
            $MyObsPowerShellPath = Join-Path $home ".obs-powershell"
            $ThisShaderPath = Join-Path $MyObsPowerShellPath "$shaderName.shader"
            $shaderText | Set-Content -LiteralPath $ThisShaderPath
            $script:CachedShaderFilesFromCommand[$shaderName] = Get-Item -LiteralPath $ThisShaderPath
        }
        if ($script:CachedShaderFilesFromCommand[$shaderName]) {
            $ShaderFilterSplat.ShaderFile = $script:CachedShaderFilesFromCommand[$shaderName].FullName
        } else {
            $ShaderFilterSplat.ShaderText = $shaderText
        }        

        if ($myVerb -eq 'Add') {                        
            Add-OBSShaderFilter @ShaderFilterSplat
        } else {
            Set-OBSShaderFilter @ShaderFilterSplat
        }
    }
}

}


} 

