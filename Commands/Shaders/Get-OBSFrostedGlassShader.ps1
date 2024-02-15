function Get-OBSFrostedGlassShader {

[Alias('Set-OBSFrostedGlassShader','Add-OBSFrostedGlassShader')]
param(
# Set the Alpha_Percent of OBSFrostedGlassShader
[Alias('Alpha_Percent')]
[ComponentModel.DefaultBindingProperty('Alpha_Percent')]
[Single]
$AlphaPercent,
# Set the Amount of OBSFrostedGlassShader
[ComponentModel.DefaultBindingProperty('Amount')]
[Single]
$Amount,
# Set the Scale of OBSFrostedGlassShader
[ComponentModel.DefaultBindingProperty('Scale')]
[Single]
$Scale,
# Set the Animate of OBSFrostedGlassShader
[ComponentModel.DefaultBindingProperty('Animate')]
[Management.Automation.SwitchParameter]
$Animate,
# Set the Horizontal_Border of OBSFrostedGlassShader
[Alias('Horizontal_Border')]
[ComponentModel.DefaultBindingProperty('Horizontal_Border')]
[Management.Automation.SwitchParameter]
$HorizontalBorder,
# Set the Border_Offset of OBSFrostedGlassShader
[Alias('Border_Offset')]
[ComponentModel.DefaultBindingProperty('Border_Offset')]
[Single]
$BorderOffset,
# Set the Border_Color of OBSFrostedGlassShader
[Alias('Border_Color')]
[ComponentModel.DefaultBindingProperty('Border_Color')]
[String]
$BorderColor,
# Set the notes of OBSFrostedGlassShader
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
$shaderName = 'frosted_glass'
$ShaderNoun = 'OBSFrostedGlassShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Frosted Glass shader by Charles Fettinger for obs-shaderfilter plugin 4/2019
//https://github.com/Oncorporation/obs-shaderfilter

uniform float Alpha_Percent<
    string label = "Alpha Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 100.0;
uniform float Amount<
    string label = "Amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.03;
uniform float Scale<
    string label = "Scale";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 5.1;
uniform bool Animate;
uniform bool Horizontal_Border;
uniform float Border_Offset<
    string label = "Border Offset";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.0;
    float step = 0.01;
> = 1.1;
uniform float4 Border_Color = {.8,.5,1.0,1.0};
uniform string notes<
    string widget_type = "info";
> = "Change shader with Scale and Amount, move Border with Border Offset. Alpha is Opacity of overlay.";

float rand(float2 co)
{
	float scale = Scale;
	if (Animate)
		scale *= rand_f;
	float2 v1 = float2(92.0,80.0);
	float2 v2 = float2(41.0,62.0);
	return frac(sin(dot(co.xy ,v1)) + cos(dot(co.xy ,v2)) * scale);
}

float4 mainImage(VertData v_in) : TARGET
{
	float4 rgba = image.Sample(textureSampler, v_in.uv);
	float3 tc = rgba.rgb * Border_Color.rgb;
	
	float uv_compare = v_in.uv.x;
	if (Horizontal_Border)
		uv_compare = v_in.uv.y;

	if (uv_compare < (Border_Offset - 0.005))
	{
		float2 randv = float2(rand(v_in.uv.yx),rand(v_in.uv.yx));
		tc = image.Sample(textureSampler, v_in.uv + (randv*Amount)).rgb;		
	}
	else if (uv_compare >= (Border_Offset + 0.005))
	{
		tc = image.Sample(textureSampler, v_in.uv).rgb;
	}
	return lerp(rgba,float4(tc,1.0),(Alpha_Percent * 0.01));
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

