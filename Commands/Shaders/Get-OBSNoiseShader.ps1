function Get-OBSNoiseShader {

[Alias('Set-OBSNoiseShader','Add-OBSNoiseShader')]
param(
# Set the speed of OBSNoiseShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the scale of OBSNoiseShader
[ComponentModel.DefaultBindingProperty('scale')]
[Single]
$Scale,
# Set the noiseLevel of OBSNoiseShader
[ComponentModel.DefaultBindingProperty('noiseLevel')]
[Single]
$NoiseLevel,
# Set the monochromatic of OBSNoiseShader
[ComponentModel.DefaultBindingProperty('monochromatic')]
[Management.Automation.SwitchParameter]
$Monochromatic,
# Set the use_rand of OBSNoiseShader
[Alias('use_rand')]
[ComponentModel.DefaultBindingProperty('use_rand')]
[Management.Automation.SwitchParameter]
$UseRand,
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
$shaderName = 'noise'
$ShaderNoun = 'OBSNoiseShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100;
    float step = 0.1;
> = 1;
uniform float scale<
    string label = "Scale";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 10;
    float step = 0.0001;
> = 6;
uniform float noiseLevel<
    string label = "Noise Level";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 1;
    float step = 0.001;
> = 1;
uniform bool monochromatic = false;
uniform bool use_rand = false;

float rand(float2 st)
{
  return frac(sin(dot(st.xy, float2(12.9898, 78.233))) * 43758.5453123);
}

float4 mainImage(VertData v_in) : TARGET
{ 
  float time = rand_activation_f + (speed / 60) * elapsed_time * 0.00001;

  if (use_rand) {
    time = rand_f;
  }

  float4 x;

  if (monochromatic) {
    x = rand(float2(v_in.uv.x, v_in.uv.y) * scale + time + scale);
  } else {
    x = float4(
      rand(float2(v_in.uv.x, v_in.uv.y) * scale + time + 1 * scale),
      rand(float2(v_in.uv.x, v_in.uv.y) * scale + time + 2 * scale),
      rand(float2(v_in.uv.x, v_in.uv.y) * scale + time + 3 * scale),
      1
    );
  }

  float4 rgba = image.Sample(textureSampler, v_in.uv);

  float3 output = lerp(rgba, x, noiseLevel);

  return float4(output.r, output.g, output.b, rgba.a);
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

