function Get-OBSTetraShader {

[Alias('Set-OBSTetraShader','Add-OBSTetraShader')]
param(
# Set the redR of OBSTetraShader
[ComponentModel.DefaultBindingProperty('redR')]
[Single]
$RedR,
# Set the redG of OBSTetraShader
[ComponentModel.DefaultBindingProperty('redG')]
[Single]
$RedG,
# Set the redB of OBSTetraShader
[ComponentModel.DefaultBindingProperty('redB')]
[Single]
$RedB,
# Set the yelR of OBSTetraShader
[ComponentModel.DefaultBindingProperty('yelR')]
[Single]
$YelR,
# Set the yelG of OBSTetraShader
[ComponentModel.DefaultBindingProperty('yelG')]
[Single]
$YelG,
# Set the yelB of OBSTetraShader
[ComponentModel.DefaultBindingProperty('yelB')]
[Single]
$YelB,
# Set the grnR of OBSTetraShader
[ComponentModel.DefaultBindingProperty('grnR')]
[Single]
$GrnR,
# Set the grnG of OBSTetraShader
[ComponentModel.DefaultBindingProperty('grnG')]
[Single]
$GrnG,
# Set the grnB of OBSTetraShader
[ComponentModel.DefaultBindingProperty('grnB')]
[Single]
$GrnB,
# Set the cynR of OBSTetraShader
[ComponentModel.DefaultBindingProperty('cynR')]
[Single]
$CynR,
# Set the cynG of OBSTetraShader
[ComponentModel.DefaultBindingProperty('cynG')]
[Single]
$CynG,
# Set the cynB of OBSTetraShader
[ComponentModel.DefaultBindingProperty('cynB')]
[Single]
$CynB,
# Set the bluR of OBSTetraShader
[ComponentModel.DefaultBindingProperty('bluR')]
[Single]
$BluR,
# Set the bluG of OBSTetraShader
[ComponentModel.DefaultBindingProperty('bluG')]
[Single]
$BluG,
# Set the bluB of OBSTetraShader
[ComponentModel.DefaultBindingProperty('bluB')]
[Single]
$BluB,
# Set the magR of OBSTetraShader
[ComponentModel.DefaultBindingProperty('magR')]
[Single]
$MagR,
# Set the magG of OBSTetraShader
[ComponentModel.DefaultBindingProperty('magG')]
[Single]
$MagG,
# Set the magB of OBSTetraShader
[ComponentModel.DefaultBindingProperty('magB')]
[Single]
$MagB,
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
$shaderName = 'tetra'
$ShaderNoun = 'OBSTetraShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Tetrahedral Interpolation Shader for OBS

uniform float redR< 
    string label = "Red in Red"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float redG< 
    string label = "Green in Red"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float redB< 
    string label = "Blue in Red"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float yelR< 
    string label = "Red in Yellow"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float yelG< 
    string label = "Green in Yellow"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float yelB< 
    string label = "Blue in Yellow"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float grnR< 
    string label = "Red in Green"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float grnG< 
    string label = "Green in Green"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float grnB< 
    string label = "Blue in Green"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float cynR< 
    string label = "Red in Cyan"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float cynG< 
    string label = "Green in Cyan"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float cynB< 
    string label = "Blue in Cyan"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float bluR< 
    string label = "Red in Blue"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float bluG< 
    string label = "Green in Blue"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float bluB< 
    string label = "Blue in Blue"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float magR< 
    string label = "Red in Magenta"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;

uniform float magG< 
    string label = "Green in Magenta"; 
    string widget_type = "slider";
    float minimum = -1.0; 
    float maximum = 1.0; 
    float step = 0.01;
> = 0.0;

uniform float magB< 
    string label = "Blue in Magenta"; 
    string widget_type = "slider";
    float minimum = 0.0; 
    float maximum = 2.0; 
    float step = 0.01;
> = 1.0;


float3 tetra(float3 RGBimage, float3 red, float3 yel, float3 grn, float3 cyn, float3 blu, float3 mag) {
    float r = RGBimage.x;
    float g = RGBimage.y;		
    float b = RGBimage.z;		

    float3 wht = float3(1.0, 1.0, 1.0);

    if (r > g) {
        if (g > b) {
            // r > g > b
            return r * red + g * (yel - red) + b * (wht - yel);
        } else if (r > b) {
            // r > b > g
            return r * red + g * (wht - mag) + b * (mag - red);
        } else {
            // b > r > g
            return r * (mag - blu) + g * (wht - mag) + b * blu;
        }
    } else {
        if (b > g) {
            // b > g > r
            return r * (wht - cyn) + g * (cyn - blu) + b * blu;
        } else if (b > r) {
            // g > b > r
            return r * (wht - cyn) + g * grn + b * (cyn - grn);
        } else {
            // g > r > b
            return r * (yel - grn) + g * grn + b * (wht - yel);
        }
    }
}

float4 mainImage(VertData v_in) : TARGET
{
    float4 inputColor = image.Sample(textureSampler, v_in.uv);
    float alpha = inputColor.a;

    float3 red = float3(redR, redG, redB);
    float3 yel = float3(yelR, yelG, yelB);
    float3 grn = float3(grnR, grnG, grnB);
    float3 cyn = float3(cynR, cynG, cynB);
    float3 blu = float3(bluR, bluG, bluB);
    float3 mag = float3(magR, magG, magB);

    float3 outputColor = tetra(inputColor.rgb, red, yel, grn, cyn, blu, mag);
    return float4(outputColor, alpha);
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

