function Get-OBSAsciiShader {

[Alias('Set-OBSAsciiShader','Add-OBSAsciiShader')]
param(
# Set the scale of OBSAsciiShader
[ComponentModel.DefaultBindingProperty('scale')]
[Int32]
$Scale,
# Set the base_color of OBSAsciiShader
[Alias('base_color')]
[ComponentModel.DefaultBindingProperty('base_color')]
[String]
$BaseColor,
# Set the monochrome of OBSAsciiShader
[ComponentModel.DefaultBindingProperty('monochrome')]
[Management.Automation.SwitchParameter]
$Monochrome,
# Set the character_set of OBSAsciiShader
[Alias('character_set')]
[ComponentModel.DefaultBindingProperty('character_set')]
[Int32]
$CharacterSet,
# Set the note of OBSAsciiShader
[ComponentModel.DefaultBindingProperty('note')]
[String]
$Note,
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
$shaderName = 'ascii'
$ShaderNoun = 'OBSAsciiShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// ASCII shader for use with obs-shaderfilter 7/2020 v1.0
// https://github.com/Oncorporation/obs-shaderfilter
// Based on the following shaders:
// https://www.shadertoy.com/view/3dtXD8 - Created by DSWebber in 2019-10-24
// https://www.shadertoy.com/view/lssGDj - Created by movAX13h in 2013-09-22

// Modifications of original shaders include:
//  - Porting from GLSL to HLSL
//  - Combining characters sets from both source shaders
//  - Adding support for parameters from OBS for monochrome rendering, scaling and dynamic character set
//
// Add Additional Characters with this tool: http://thrill-project.com/archiv/coding/bitmap/
// converts a bitmap into int then decodes it to look like text

uniform int scale<
    string label = "Scale";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 20;
    int step = 1;
> = 1; // Size of characters
uniform float4 base_color<
    string label = "Base color";
> = {0.0,1.0,0.0,1.0}; // Monochrome base color
uniform bool monochrome<
    string label = "Monochrome";
> = false;
uniform int character_set<
  string label = "Character set";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "Large set of non-letters";
  int    option_1_value = 1;
  string option_1_label = "Small set of capital letters";
> = 0;
uniform string note<
    string widget_type = "info";
> = "Base color is used as monochrome base color.";

float character(int n, float2 p)
{
    p = floor(p*float2(4.0, 4.0) + 2.5);
    if (clamp(p.x, 0.0, 4.0) == p.x)
    {
        if (clamp(p.y, 0.0, 4.0) == p.y)	
        {
	    int a = int(round(p.x) + 5.0 * round(p.y));
            if (((n >> a) & 1) == 1) return 1.0;
        }	
    }
    return 0.0;
}

float2 mod(float2 x, float2 y)
{
    return x - y * floor(x/y);
}

float4 mainImage( VertData v_in ) : TARGET
{
    float2 iResolution = uv_size*uv_scale;
    float2 pix = v_in.pos.xy;
    float4 c = image.Sample(textureSampler, floor(pix/float2(scale*8.0,scale*8.0))*float2(scale*8.0,scale*8.0)/iResolution.xy);

    float gray = 0.3 * c.r + 0.59 * c.g + 0.11 * c.b;
	
    int n;
    int charset = clamp(character_set, 0, 1);

    if (charset==0)
    {
        if (gray <= 0.2) n = 4096;     // .
        if (gray > 0.2)  n = 65600;    // :
        if (gray > 0.3)  n = 332772;   // *
        if (gray > 0.4)  n = 15255086; // o 
        if (gray > 0.5)  n = 23385164; // &
        if (gray > 0.6)  n = 15252014; // 8
        if (gray > 0.7)  n = 13199452; // @
        if (gray > 0.8)  n = 11512810; // #
    }
    else if (charset==1)
    {
        if (gray <= 0.1) n = 0;
        if (gray > 0.1)  n = 9616687; // R
        if (gray > 0.3)  n = 32012382; // S
        if (gray > 0.5)  n = 16303663; // D
        if (gray > 0.7)  n = 15255086; // O
        if (gray > 0.8)  n = 16301615; // B
    }

    float2 p = mod(pix/float2(scale*4.0,scale*4.0),float2(2.0,2.0)) - float2(1.0,1.0);
	
    if (monochrome)
    {
        c.rgb = base_color.rgb;
    }
    c = c*character(n, p);
    
    return c;
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

