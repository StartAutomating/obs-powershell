function Get-OBSSpecularShineShader {

[Alias('Set-OBSSpecularShineShader','Add-OBSSpecularShineShader')]
param(
# Set the Hint of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('Hint')]
[String]
$Hint,
# Set the roughness of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('roughness')]
[Single]
$Roughness,
# Set the lightStrength of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('lightStrength')]
[Single]
$LightStrength,
# Set the LightPositionX of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('LightPositionX')]
[Single]
$LightPositionX,
# Set the LightPositionY of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('LightPositionY')]
[Single]
$LightPositionY,
# Set the flattenNormal of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('flattenNormal')]
[Single]
$FlattenNormal,
# Set the stretchNormalX of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('stretchNormalX')]
[Single]
$StretchNormalX,
# Set the stretchNormalY of OBSSpecularShineShader
[ComponentModel.DefaultBindingProperty('stretchNormalY')]
[Single]
$StretchNormalY,
# Set the Light_Color of OBSSpecularShineShader
[Alias('Light_Color')]
[ComponentModel.DefaultBindingProperty('Light_Color')]
[Single[]]
$LightColor,
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
$shaderName = 'specular-shine'
$ShaderNoun = 'OBSSpecularShineShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Specular Shine shader by Andicraft / Andrea Jörgensen - https://github.com/Andicraft

uniform string Hint<
    string widget_type = "info";
> = "Try using a black color source with the additive blend mode!";

uniform float roughness<
    string label = "Roughness";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.25;

uniform float lightStrength<
    string label = "lightStrength";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.0;
    float step = 0.001;
> = 0.5;

uniform float LightPositionX<
    string label = "Light Position X";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float LightPositionY<
    string label = "Light Position Y";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float flattenNormal<
    string label = "Flatten Normal";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.1;

uniform float stretchNormalX<
    string label = "Stretch Normal X";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 4.0;
    float step = 0.01;
> = 1;

uniform float stretchNormalY<
    string label = "Stretch Normal Y";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 4.0;
    float step = 0.01;
> = 1;

uniform float3 Light_Color = {1,1,1};

float Square(float a) { return a * a; }

float CookTorrance(float3 lightDir, float3 normal, float roughness) {
	float3 h = normalize(lightDir + float3(0,0,1));
	float nh2 = Square(saturate(dot(normal, h)));
	float lh2 = Square(saturate(dot(lightDir, h)));
	float r2 = Square(roughness);
	float d2 = Square(nh2 * (r2 - 1.0) + 1.00001);
	float normalization = roughness * 4.0 + 2.0;
	return r2 / (d2 * max(0.1, lh2) * normalization);
}

#define PI 3.14159265

float4 mainImage(VertData v_in) : TARGET
{

	float4 c0 = image.Sample(textureSampler, v_in.uv);

	float3 lightDir = normalize(float3(-LightPositionX*5, -LightPositionY*5, 1));

	float2 normalUV = v_in.uv - 0.5;
	normalUV.x /= stretchNormalX;
	normalUV.y /= stretchNormalY;
	normalUV += 0.5;

	float3 normal = normalize(float3(normalUV.x * 2 - 1,normalUV.y * 2 - 1,-1));
	normal.z *= -1;

	normal = lerp(normal, float3(0,0,-1), flattenNormal);

	float3 light = CookTorrance(lightDir, normal, roughness)*float3(1,1,1)*lightStrength*Light_Color;

	return float4(c0 + light,c0.a);
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

