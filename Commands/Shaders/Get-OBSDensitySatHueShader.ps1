function Get-OBSDensitySatHueShader {

[Alias('Set-OBSDensitySatHueShader','Add-OBSDensitySatHueShader')]
param(
# Set the notes of OBSDensitySatHueShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the density_r of OBSDensitySatHueShader
[Alias('density_r')]
[ComponentModel.DefaultBindingProperty('density_r')]
[Single]
$DensityR,
# Set the saturation_r of OBSDensitySatHueShader
[Alias('saturation_r')]
[ComponentModel.DefaultBindingProperty('saturation_r')]
[Single]
$SaturationR,
# Set the hueShift_r of OBSDensitySatHueShader
[Alias('hueShift_r')]
[ComponentModel.DefaultBindingProperty('hueShift_r')]
[Single]
$HueShiftR,
# Set the density_y of OBSDensitySatHueShader
[Alias('density_y')]
[ComponentModel.DefaultBindingProperty('density_y')]
[Single]
$DensityY,
# Set the saturation_y of OBSDensitySatHueShader
[Alias('saturation_y')]
[ComponentModel.DefaultBindingProperty('saturation_y')]
[Single]
$SaturationY,
# Set the hueShift_y of OBSDensitySatHueShader
[Alias('hueShift_y')]
[ComponentModel.DefaultBindingProperty('hueShift_y')]
[Single]
$HueShiftY,
# Set the density_g of OBSDensitySatHueShader
[Alias('density_g')]
[ComponentModel.DefaultBindingProperty('density_g')]
[Single]
$DensityG,
# Set the saturation_g of OBSDensitySatHueShader
[Alias('saturation_g')]
[ComponentModel.DefaultBindingProperty('saturation_g')]
[Single]
$SaturationG,
# Set the hueShift_g of OBSDensitySatHueShader
[Alias('hueShift_g')]
[ComponentModel.DefaultBindingProperty('hueShift_g')]
[Single]
$HueShiftG,
# Set the density_c of OBSDensitySatHueShader
[Alias('density_c')]
[ComponentModel.DefaultBindingProperty('density_c')]
[Single]
$DensityC,
# Set the saturation_c of OBSDensitySatHueShader
[Alias('saturation_c')]
[ComponentModel.DefaultBindingProperty('saturation_c')]
[Single]
$SaturationC,
# Set the hueShift_c of OBSDensitySatHueShader
[Alias('hueShift_c')]
[ComponentModel.DefaultBindingProperty('hueShift_c')]
[Single]
$HueShiftC,
# Set the density_b of OBSDensitySatHueShader
[Alias('density_b')]
[ComponentModel.DefaultBindingProperty('density_b')]
[Single]
$DensityB,
# Set the saturation_b of OBSDensitySatHueShader
[Alias('saturation_b')]
[ComponentModel.DefaultBindingProperty('saturation_b')]
[Single]
$SaturationB,
# Set the hueShift_b of OBSDensitySatHueShader
[Alias('hueShift_b')]
[ComponentModel.DefaultBindingProperty('hueShift_b')]
[Single]
$HueShiftB,
# Set the density_m of OBSDensitySatHueShader
[Alias('density_m')]
[ComponentModel.DefaultBindingProperty('density_m')]
[Single]
$DensityM,
# Set the saturation_m of OBSDensitySatHueShader
[Alias('saturation_m')]
[ComponentModel.DefaultBindingProperty('saturation_m')]
[Single]
$SaturationM,
# Set the hueShift_m of OBSDensitySatHueShader
[Alias('hueShift_m')]
[ComponentModel.DefaultBindingProperty('hueShift_m')]
[Single]
$HueShiftM,
# Set the global_density of OBSDensitySatHueShader
[Alias('global_density')]
[ComponentModel.DefaultBindingProperty('global_density')]
[Single]
$GlobalDensity,
# Set the global_saturation of OBSDensitySatHueShader
[Alias('global_saturation')]
[ComponentModel.DefaultBindingProperty('global_saturation')]
[Single]
$GlobalSaturation,
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
$shaderName = 'density_sat_hue'
$ShaderNoun = 'OBSDensitySatHueShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Density-Saturation-Hue Shader for OBS Shaderfilter
// Modified by CameraTim for use with obs-shaderfilter 12/2024 v.12

uniform string notes<
    string widget_type = "info";
> = "Density adjustment shader: Density reduces luminance, while saturation is subtractively increased to avoid greyish colors.";

uniform float density_r <
    string label = "Red Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_r <
    string label = "Red Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueShift_r <
    string label = "Red Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_y <
    string label = "Yellow Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_y <
    string label = "Yellow Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueShift_y <
    string label = "Yellow Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_g <
    string label = "Green Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_g <
    string label = "Green Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueShift_g <
    string label = "Green Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_c <
    string label = "Cyan Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_c <
    string label = "Cyan Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueShift_c <
    string label = "Cyan Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_b <
    string label = "Blue Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_b <
    string label = "Blue Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueShift_b <
    string label = "Blue Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float density_m <
    string label = "Magenta Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float saturation_m <
    string label = "Magenta Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float hueShift_m <
    string label = "Magenta Hue Shift";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float global_density < 
    string label = "Global Density";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

uniform float global_saturation < 
    string label = "Global Sat";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;

// Tetrahedral interpolation based on the ordering of the input color channels
float3 applyAdjustments(float3 p) {
    // Pre-calculate the flipped density values for each channel:
    float d_r = -(density_r + global_density);
    float d_y = -(density_y + global_density);
    float d_g = -(density_g + global_density);
    float d_c = -(density_c + global_density);
    float d_b = -(density_b + global_density);
    float d_m = -(density_m + global_density);
    
    // Compute the color vectors for each hue region using the flipped densities:
    float3 red = float3(
        1.0 + d_r,
        d_r - (saturation_r + global_saturation),
        d_r + hueShift_r - (saturation_r + global_saturation)
    );
    
    float3 yellow = float3(
        1.0 + hueShift_y + d_y,
        1.0 + d_y,
        d_y - (saturation_y + global_saturation)
    );
    
    float3 green = float3(
        d_g - (saturation_g + global_saturation),
        1.0 + d_g,
        d_g + hueShift_g - (saturation_g + global_saturation)
    );
    
    float3 cyan = float3(
        d_c - (saturation_c + global_saturation),
        1.0 + hueShift_c + d_c,
        1.0 + d_c
    );
    
    float3 blue = float3(
        d_b + hueShift_b - (saturation_b + global_saturation),
        d_b - (saturation_b + global_saturation),
        1.0 + d_b
    );
    
    float3 magenta = float3(
        1.0 + d_m,
        d_m - (saturation_m + global_saturation),
        1.0 + hueShift_m + d_m
    );
    
    // Define the black and white endpoints:
    float3 blk = float3(0.0, 0.0, 0.0);
    float3 wht = float3(1.0, 1.0, 1.0);
    
    float3 rgb;
    if (p.r > p.g) {
        if (p.g > p.b) {
            // p.r >= p.g >= p.b
            rgb = p.r * (red - blk) + blk + p.g * (yellow - red) + p.b * (wht - yellow);
        } else if (p.r > p.b) {
            // p.r >= p.b > p.g
            rgb = p.r * (red - blk) + blk + p.g * (wht - magenta) + p.b * (magenta - red);
        } else {
            // p.b >= p.r > p.g
            rgb = p.r * (magenta - blue) + p.g * (wht - magenta) + p.b * (blue - blk) + blk;
        }
    } else {
        if (p.b > p.g) {
            // p.b >= p.g >= p.r
            rgb = p.r * (wht - cyan) + p.g * (cyan - blue) + p.b * (blue - blk) + blk;
        } else if (p.b > p.r) {
            // p.g >= p.r and p.b > p.r
            rgb = p.r * (wht - cyan) + p.g * (green - blk) + blk + p.b * (cyan - green);
        } else {
            // p.g >= p.b >= p.r
            rgb = p.r * (yellow - green) + p.g * (green - blk) + blk + p.b * (wht - yellow);
        }
    }
    return clamp(rgb, 0.0, 1.0);
}

float4 mainImage(VertData v_in) : TARGET {
    float4 inputColor = image.Sample(textureSampler, v_in.uv);
    float3 adjustedColor = applyAdjustments(inputColor.rgb);
    return float4(adjustedColor, inputColor.a);
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

