function Get-OBSSpotlightShader {

[Alias('Set-OBSSpotlightShader','Add-OBSSpotlightShader')]
param(
# Set the Speed_Percent of OBSSpotlightShader
[Alias('Speed_Percent')]
[ComponentModel.DefaultBindingProperty('Speed_Percent')]
[Single]
$SpeedPercent,
# Set the Focus_Percent of OBSSpotlightShader
[Alias('Focus_Percent')]
[ComponentModel.DefaultBindingProperty('Focus_Percent')]
[Single]
$FocusPercent,
# Set the Glitch of OBSSpotlightShader
[ComponentModel.DefaultBindingProperty('Glitch')]
[Management.Automation.SwitchParameter]
$Glitch,
# Set the Spotlight_Color of OBSSpotlightShader
[Alias('Spotlight_Color')]
[ComponentModel.DefaultBindingProperty('Spotlight_Color')]
[String]
$SpotlightColor,
# Set the Horizontal_Offset of OBSSpotlightShader
[Alias('Horizontal_Offset')]
[ComponentModel.DefaultBindingProperty('Horizontal_Offset')]
[Single]
$HorizontalOffset,
# Set the Vertical_Offset of OBSSpotlightShader
[Alias('Vertical_Offset')]
[ComponentModel.DefaultBindingProperty('Vertical_Offset')]
[Single]
$VerticalOffset,
# Set the Notes of OBSSpotlightShader
[ComponentModel.DefaultBindingProperty('Notes')]
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
$shaderName = 'spotlight'
$ShaderNoun = 'OBSSpotlightShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Spotlight By Charles Fettinger (https://github.com/Oncorporation)  4/2019
uniform float Speed_Percent<
    string label = "Speed Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.0; 
uniform float Focus_Percent<
    string label = "Focus Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 15.0;
uniform bool Glitch;
uniform float4 Spotlight_Color;
uniform float Horizontal_Offset<
    string label = "Horizontal Offset";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;
uniform float Vertical_Offset<
    string label = "Vertical Offset";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = -0.5;
uniform string Notes<
    string widget_type = "info";
> = "use negative Focus Percent to create a shade effect, speed zero is a stationary spotlight";

float4 mainImage(VertData v_in) : TARGET
{
	float speed = Speed_Percent * 0.01;
	float focus = Focus_Percent;
	if (Glitch)
	{
		speed *= ((rand_f * 2) - 1) * 0.01;
		focus *= ((rand_f * 1.1) - 0.1);
	}

	float PI = 3.1415926535897932384626433832795;//acos(-1);
	float4 c0 = image.Sample( textureSampler, v_in.uv);
	float3 lightsrc = float3(sin(elapsed_time * speed * PI * 0.667) *.5 + .5 + Horizontal_Offset, cos(elapsed_time * speed * PI) *.5 + .5 + Vertical_Offset, 1);
	float3 light = normalize(lightsrc - float3( v_in.uv.x + (Horizontal_Offset * speed),  v_in.uv.y + (Vertical_Offset * speed), 0));
	c0 *= pow(dot(light, float3(0, 0, 1)), focus) * Spotlight_Color;

	return c0;
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

