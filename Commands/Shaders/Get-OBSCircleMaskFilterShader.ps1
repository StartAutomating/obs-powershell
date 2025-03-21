function Get-OBSCircleMaskFilterShader {

[Alias('Set-OBSCircleMaskFilterShader','Add-OBSCircleMaskFilterShader')]
param(
# Set the Radius of OBSCircleMaskFilterShader
[ComponentModel.DefaultBindingProperty('Radius')]
[Single]
$Radius,
# Set the Circle_Offset_X of OBSCircleMaskFilterShader
[Alias('Circle_Offset_X')]
[ComponentModel.DefaultBindingProperty('Circle_Offset_X')]
[Int32]
$CircleOffsetX,
# Set the Circle_Offset_Y of OBSCircleMaskFilterShader
[Alias('Circle_Offset_Y')]
[ComponentModel.DefaultBindingProperty('Circle_Offset_Y')]
[Int32]
$CircleOffsetY,
# Set the Source_Offset_X of OBSCircleMaskFilterShader
[Alias('Source_Offset_X')]
[ComponentModel.DefaultBindingProperty('Source_Offset_X')]
[Int32]
$SourceOffsetX,
# Set the Source_Offset_Y of OBSCircleMaskFilterShader
[Alias('Source_Offset_Y')]
[ComponentModel.DefaultBindingProperty('Source_Offset_Y')]
[Int32]
$SourceOffsetY,
# Set the Antialiasing of OBSCircleMaskFilterShader
[ComponentModel.DefaultBindingProperty('Antialiasing')]
[Management.Automation.SwitchParameter]
$Antialiasing,
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
$shaderName = 'circle-mask-filter'
$ShaderNoun = 'OBSCircleMaskFilterShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Circle Mask Filter version 1.01, for OBS Shaderfilter
// Copyright 2022 by SkeletonBow
//					Twitter: <https://twitter.com/skeletonbowtv>
//					Twitch: <https://twitch.tv/skeletonbowtv>
// License: GNU GPLv2
//
// Changelog:
// 1.01	- Don''t saturate() Radius parameter to allow oversizing to cover entire input texture.
// 1.0	- Initial release

uniform float Radius<
    string label = "Radius";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 50.0;
uniform int Circle_Offset_X<
    string label = "Circle Offset X";
    string widget_type = "slider";
    int minimum = -1000;
    int maximum = 1000;
    int step = 1;
> = 0;
uniform int Circle_Offset_Y<
    string label = "Circle Offset X";
    string widget_type = "slider";
    int minimum = -1000;
    int maximum = 1000;
    int step = 1;
> = 0;
uniform int Source_Offset_X<
    string label = "Source Offset X";
    string widget_type = "slider";
    int minimum = -1000;
    int maximum = 1000;
    int step = 1;
> = 0.0;
uniform int Source_Offset_Y<
    string label = "Source Offset Y";
    string widget_type = "slider";
    int minimum = -1000;
    int maximum = 1000;
    int step = 1;
> = 0.0;

uniform bool Antialiasing = true;
#define Smoothness 100.00
#define AAwidth 4

#define uv_pi uv_pixel_interval

float4 mainImage( VertData v_in ) : TARGET
{
	float2 uv = v_in.uv;
	float2 coffset = float2(Circle_Offset_X, Circle_Offset_Y)/uv_size;
	float2 soffset = float2( Source_Offset_X, Source_Offset_Y )/uv_size;

	float radius = Radius * 0.01;
	float smwidth = radius * Smoothness * 0.01; 
	
	float4 obstex = image.Sample( textureSampler, uv - soffset);
	float4 color = obstex;
	// Account for aspect ratio
	uv.x = (uv.x - 0.5) * uv_size.x / uv_size.y + 0.5;
	float2 cuv = 0.5 + coffset;
	float dist = distance(cuv,uv);
	// Anti-aliased or pixelated edge
	if( Antialiasing ) {
		color.a = smoothstep( radius, (radius+(uv_pi.x)) - (uv_pi.x * AAwidth), dist);
	} else {
		color.a = step( dist, radius );
	}

	return float4(color.rgb, color.a);
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

