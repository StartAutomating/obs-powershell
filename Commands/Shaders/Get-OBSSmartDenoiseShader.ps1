function Get-OBSSmartDenoiseShader {

[Alias('Set-OBSSmartDenoiseShader','Add-OBSSmartDenoiseShader')]
param(
# Set the uSigma of OBSSmartDenoiseShader
[ComponentModel.DefaultBindingProperty('uSigma')]
[Single]
$USigma,
# Set the uKSigma of OBSSmartDenoiseShader
[ComponentModel.DefaultBindingProperty('uKSigma')]
[Single]
$UKSigma,
# Set the uThreshold of OBSSmartDenoiseShader
[ComponentModel.DefaultBindingProperty('uThreshold')]
[Single]
$UThreshold,
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
$shaderName = 'smart_denoise'
$ShaderNoun = 'OBSSmartDenoiseShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Smart DeNoise By Michele Morrone (https://github.com/BrutPitt/glslSmartDeNoise)
// Converted to OBS version of HLSL by Euiko on February 10, 2025

#define INV_SQRT_OF_2PI 0.39894228040143267793994605993439  // 1.0/SQRT_OF_2PI
#define INV_PI          0.31830988618379067153776752674503

uniform float uSigma<
    string label = "Sigma";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 3;  // max based on the webgl sample, which is 3 
    float step = 0.01;
> = 5.0;  // default value based on shadertoy
uniform float uKSigma<
    string label = "K-Sigma";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 24; // max based on the webgl sample, which is 24 
    float step = 0.01;
> = 7.0;  // the default value is based on the webgl sample
uniform float uThreshold<
    string label = "Edge Threshold";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 2;  // max based on the webgl sample, which is 2
    float step = 0.01;
> = 0.190;  // the default value is based on the webgl sample

//  smartDeNoise - parameters
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  float2 uv         - actual fragment coord
//  float2 size       - window size
//  float sigma  >  0 - sigma Standard Deviation
//  float kSigma >= 0 - sigma coefficient 
//      kSigma * sigma  -->  radius of the circular kernel
//  float threshold   - edge sharpening threshold 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// NOTE: image''s texture2d data will be supplied by the OBS shaderfilter by default
float4 smartDeNoise(float2 uv, float2 size, float sigma, float kSigma, float threshold)
{
    float radius = round(kSigma * sigma);
    float radQ = radius * radius;

    float invSigmaQx2 = 0.5 / (sigma * sigma);   // 1.0 / (sigma^2 * 2.0)
    float invSigmaQx2PI = INV_PI * invSigmaQx2;  // 1/(2 * PI * sigma^2)

    float invThresholdSqx2 = 0.5 / (threshold * threshold);   // 1.0 / (sigma^2 * 2.0)
    float invThresholdSqrt2PI = INV_SQRT_OF_2PI / threshold;  // 1.0 / (sqrt(2*PI) * sigma^2)

    float4 centrPx = image.Sample(textureSampler, uv);

    float zBuff = 0.0;
    float4 aBuff = float4(0.0, 0.0, 0.0, 0.0);

    float2 d;
    for (d.x = -radius; d.x <= radius; d.x += 1.0)
    {
        float pt = sqrt(radQ - (d.x * d.x));  // pt = yRadius: have circular trend
        d.y = -pt;
        for (; d.y <= pt; d.y += 1.0)
        {
            float blurFactor = exp((-dot(d, d)) * invSigmaQx2) * invSigmaQx2PI;
            float4 walkPx = image.Sample(textureSampler, uv + (d / size));
            float4 dC = walkPx - centrPx;
            float deltaFactor = (exp((-dot(dC.xyz, dC.xyz)) * invThresholdSqx2) * invThresholdSqrt2PI) * blurFactor;
            zBuff += deltaFactor;
            aBuff += (walkPx * deltaFactor);
        }
    }
    return aBuff / float4(zBuff, zBuff, zBuff, zBuff);
}

float4 mainImage(VertData v_in) : TARGET
{
    return smartDeNoise(v_in.uv, uv_size, uSigma, uKSigma, uThreshold);
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

