function Get-OBSHslHsvSaturationShader {

[Alias('Set-OBSHslHsvSaturationShader','Add-OBSHslHsvSaturationShader')]
param(
# Set the hslSaturationFactor of OBSHslHsvSaturationShader
[ComponentModel.DefaultBindingProperty('hslSaturationFactor')]
[Single]
$HslSaturationFactor,
# Set the hsvSaturationFactor of OBSHslHsvSaturationShader
[ComponentModel.DefaultBindingProperty('hsvSaturationFactor')]
[Single]
$HsvSaturationFactor,
# Set the adjustmentOrder of OBSHslHsvSaturationShader
[ComponentModel.DefaultBindingProperty('adjustmentOrder')]
[Single]
$AdjustmentOrder,
# Set the notes of OBSHslHsvSaturationShader
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
$shaderName = 'hsl_hsv_saturation'
$ShaderNoun = 'OBSHslHsvSaturationShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '

// Adjusted Saturation Shader for obs-shaderfilter using HLSL conventions

uniform float hslSaturationFactor<
    string label = "HSL Saturation";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 5.0;
    float step = 0.01;
> = 1.0;

uniform float hsvSaturationFactor<
    string label = "HSV Saturation";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 5.0;
    float step = 0.01;
> = 1.0;

uniform float adjustmentOrder<
    string label = "Order";
    float minimum = 1;
    float maximum = 3;
    float step = 1;
> = 1;

uniform string notes<
    string widget_type = "info";
> = "Order:\n1 = Blended average result of HSL/HSV\n2 = HSL first\n3 = HSV first";


// HSV conversion

float3 rgb2hsv(float3 c) {
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
    float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float3 hsv2rgb(float3 c) {
    float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * lerp(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// HSL conversion

float3 rgb2hsl(float3 c) {
    float maxVal = max(c.r, max(c.g, c.b));
    float minVal = min(c.r, min(c.g, c.b));
    float delta = maxVal - minVal;
    float h = 0.0;
    float s = 0.0;
    float l = (maxVal + minVal) / 2.0;

    if(delta != 0) {
        if(l < 0.5) s = delta / (maxVal + minVal);
        else s = delta / (2.0 - maxVal - minVal);

        if(c.r == maxVal) h = (c.g - c.b) / delta + (c.g < c.b ? 6.0 : 0.0);
        else if(c.g == maxVal) h = (c.b - c.r) / delta + 2.0;
        else h = (c.r - c.g) / delta + 4.0;

        h /= 6.0;
    }

    return float3(h, s, l);
}

float hue2rgb(float p, float q, float t) {
    if(t < 0.0) t += 1.0;
    if(t > 1.0) t -= 1.0;
    if(t < 1.0/6.0) return p + (q - p) * 6.0 * t;
    if(t < 1.0/2.0) return q;
    if(t < 2.0/3.0) return p + (q - p) * (2.0/3.0 - t) * 6.0;
    return p;
}

float3 hsl2rgb(float3 c) {
    float r, g, b;

    if(c.y == 0.0) {
        r = g = b = c.z;
    } else {
        float q = c.z < 0.5 ? c.z * (1.0 + c.y) : c.z + c.y - c.z * c.y;
        float p = 2.0 * c.z - q;
        r = hue2rgb(p, q, c.x + 1.0/3.0);
        g = hue2rgb(p, q, c.x);
        b = hue2rgb(p, q, c.x - 1.0/3.0);
    }

    return float3(r, g, b);
}

float3 adjustColorWithOrder(float3 originalColor) {
    if (adjustmentOrder == 1.0) {
        // Parallel adjustment (both HSL and HSV operate on the original image and then blend)
        float3 hslAdjusted = rgb2hsl(originalColor);
        hslAdjusted.y *= hslSaturationFactor;
        float3 hslAdjustedColor = hsl2rgb(hslAdjusted);
        
        float3 hsvAdjusted = rgb2hsv(originalColor);
        hsvAdjusted.y *= hsvSaturationFactor;
        float3 hsvAdjustedColor = hsv2rgb(hsvAdjusted);
        
        float3 finalColor = (hslAdjustedColor + hsvAdjustedColor) * 0.5;
        return finalColor;
    } 
    else if (adjustmentOrder == 2.0) {
        // HSL first, then HSV
        float3 hslAdjusted = rgb2hsl(originalColor);
        hslAdjusted.y *= hslSaturationFactor;
        float3 afterHSL = hsl2rgb(hslAdjusted);
        float3 hsvAdjusted = rgb2hsv(afterHSL);
        hsvAdjusted.y *= hsvSaturationFactor;
        return hsv2rgb(hsvAdjusted);
    } 
    else if (adjustmentOrder == 3.0) {
        // HSV first, then HSL
        float3 hsvAdjusted = rgb2hsv(originalColor);
        hsvAdjusted.y *= hsvSaturationFactor;
        float3 afterHSV = hsv2rgb(hsvAdjusted);
        float3 hslAdjusted = rgb2hsl(afterHSV);
        hslAdjusted.y *= hslSaturationFactor;
        return hsl2rgb(hslAdjusted);
    }
    return originalColor;  // Default to original color in case of unexpected values
}

// Final composite

float4 mainImage(VertData v_in) : TARGET
{
    float3 originalColor = image.Sample(textureSampler, v_in.uv).rgb;
    float3 adjustedColor = adjustColorWithOrder(originalColor);
    return float4(adjustedColor, 1.0);  // preserving the original alpha
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

