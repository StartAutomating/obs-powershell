function Get-OBSDeadPixelFixerShader {

[Alias('Set-OBSDeadPixelFixerShader','Add-OBSDeadPixelFixerShader')]
param(
# Set the Dead_Pixel_X of OBSDeadPixelFixerShader
[Alias('Dead_Pixel_X')]
[ComponentModel.DefaultBindingProperty('Dead_Pixel_X')]
[Int32]
$DeadPixelX,
# Set the Dead_Pixel_Y of OBSDeadPixelFixerShader
[Alias('Dead_Pixel_Y')]
[ComponentModel.DefaultBindingProperty('Dead_Pixel_Y')]
[Int32]
$DeadPixelY,
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
$shaderName = 'dead-pixel-fixer'
$ShaderNoun = 'OBSDeadPixelFixerShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Dead Pixel Fixer, Version 0.01, for OBS Shaderfilter
// Copyright ©️ 2022 by SkeletonBow
// License: GNU General Public License, version 2
// Contact info:
//		Twitter: <https://twitter.com/skeletonbowtv>
//		Twitch: <https://twitch.tv/skeletonbowtv>
//
// Description:  Intended for use with an input source that has a dead pixel on its sensor such as a webcam.
// The pixel located at the user configured offset will have its color overridden by taking the average of the
// color of the 8 pixels immediately surrounding it, effectively hiding the dead pixel.
//
// Changelog:
// 0.01	- Initial release

uniform int Dead_Pixel_X<
    string label = "Dead Pixel X";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 2000;
    int step = 1;
> = 0;
uniform int Dead_Pixel_Y<
    string label = "Dead Pixel Y";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 2000;
    int step = 1;
> = 0;

float3 blur_dead_pixel(in float2 pos)
{
	float3 color;
	color = image.Sample(textureSampler,  (pos + float2(-1.0, -0.5))/uv_size).rgb;
	color += image.Sample(textureSampler, (pos + float2(0.5, -1.0))/uv_size).rgb;
	color += image.Sample(textureSampler, (pos + float2(1.0, 0.5))/uv_size).rgb;
	color += image.Sample(textureSampler, (pos + float2(-0.5, 1.0))/uv_size).rgb;
	return color * 0.25;
}

float4 mainImage( VertData v_in ) : TARGET
{
	float2 uv = v_in.uv;
	float2 pos = v_in.pos.xy;
	float2 dp_pos = clamp( float2(Dead_Pixel_X, Dead_Pixel_Y), float2(0.0,0.0), uv_size - 1);
	float4 obstex = image.Sample(textureSampler, uv);
	float3 color;

	if(floor(pos.x) == floor(dp_pos.x) && floor(pos.y) == floor(dp_pos.y) ) {
		color = blur_dead_pixel(pos);
	} else {
		color.rgb = obstex.rgb;
	}
	return float4( color, obstex.a);
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

