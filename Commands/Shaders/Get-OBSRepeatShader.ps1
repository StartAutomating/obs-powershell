function Get-OBSRepeatShader {

[Alias('Set-OBSRepeatShader','Add-OBSRepeatShader')]
param(
# Set the ViewProj of OBSRepeatShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the color_matrix of OBSRepeatShader
[Alias('color_matrix')]
[ComponentModel.DefaultBindingProperty('color_matrix')]
[Single[][]]
$ColorMatrix,
# Set the color_range_min of OBSRepeatShader
[Alias('color_range_min')]
[ComponentModel.DefaultBindingProperty('color_range_min')]
[Single[]]
$ColorRangeMin,
# Set the color_range_max of OBSRepeatShader
[Alias('color_range_max')]
[ComponentModel.DefaultBindingProperty('color_range_max')]
[Single[]]
$ColorRangeMax,
# Set the image of OBSRepeatShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSRepeatShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSRepeatShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSRepeatShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSRepeatShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the uv_size of OBSRepeatShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the rand_f of OBSRepeatShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the alpha of OBSRepeatShader
[ComponentModel.DefaultBindingProperty('alpha')]
[Single]
$Alpha,
# Set the copies of OBSRepeatShader
[ComponentModel.DefaultBindingProperty('copies')]
[Single]
$Copies,
# Set the notes of OBSRepeatShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
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
$shaderName = 'repeat'
$ShaderNoun = 'OBSRepeatShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Repeat Effect By Charles Fettinger (https://github.com/Oncorporation)  2/2019

uniform float4x4 ViewProj;
uniform float4x4 color_matrix;
uniform float3 color_range_min = {0.0, 0.0, 0.0};
uniform float3 color_range_max = {1.0, 1.0, 1.0};
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float2 uv_size;
uniform float rand_f;

uniform float alpha<
    string label = "Alpha";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 3.0;
    float step = 0.001;
> = 1.0;
uniform float copies<
    string label = "Copies";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 4.0;
uniform string notes<
    string widget_type = "info";
> = ''copies, use a number that has a square root. Alpha adjusts the alpha level of the copies (recommend 0.5-2.0 recommend)'';

sampler_state def_sampler {
	Filter   = Linear;
	AddressU = Repeat;
	AddressV = Repeat;
};

struct VertInOut {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

VertInOut VSDefault(VertInOut vert_in)
{
	VertInOut vert_out;
	vert_out.pos = mul(float4(vert_in.pos.xyz, 1 ), ViewProj);
	vert_out.uv  = vert_in.uv * sqrt(copies);
	return vert_out;
}

float4 PSDrawBare(VertInOut vert_in) : TARGET
{
	float4 rgba = image.Sample(def_sampler, vert_in.uv);
	rgba.a *= alpha;
	return rgba;
}

technique Draw
{
	pass
	{
		vertex_shader = VSDefault(vert_in);
		pixel_shader  = PSDrawBare(vert_in);
	}
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

