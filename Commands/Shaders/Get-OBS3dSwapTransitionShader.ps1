function Get-OBS3dSwapTransitionShader {

[Alias('Set-OBS3dSwapTransitionShader','Add-OBS3dSwapTransitionShader')]
param(
# Set the image_a of OBS3dSwapTransitionShader
[Alias('image_a')]
[ComponentModel.DefaultBindingProperty('image_a')]
[String]
$ImageA,
# Set the image_b of OBS3dSwapTransitionShader
[Alias('image_b')]
[ComponentModel.DefaultBindingProperty('image_b')]
[String]
$ImageB,
# Set the transition_time of OBS3dSwapTransitionShader
[Alias('transition_time')]
[ComponentModel.DefaultBindingProperty('transition_time')]
[Single]
$TransitionTime,
# Set the convert_linear of OBS3dSwapTransitionShader
[Alias('convert_linear')]
[ComponentModel.DefaultBindingProperty('convert_linear')]
[Management.Automation.SwitchParameter]
$ConvertLinear,
# Set the reflection of OBS3dSwapTransitionShader
[ComponentModel.DefaultBindingProperty('reflection')]
[Single]
$Reflection,
# Set the perspective of OBS3dSwapTransitionShader
[ComponentModel.DefaultBindingProperty('perspective')]
[Single]
$Perspective,
# Set the depth of OBS3dSwapTransitionShader
[ComponentModel.DefaultBindingProperty('depth')]
[Single]
$Depth,
# Set the background_color of OBS3dSwapTransitionShader
[Alias('background_color')]
[ComponentModel.DefaultBindingProperty('background_color')]
[String]
$BackgroundColor,
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
$shaderName = '3d_swap_transition'
$ShaderNoun = 'OBS3dSwapTransitionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/MlXGzf

uniform texture2d image_a;
uniform texture2d image_b;
uniform float transition_time = 0.5;
uniform bool convert_linear = true;

uniform float reflection<
    string label = "Reflection (0.4)";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 1.00;
    float step = 0.01;
> = 0.4;
uniform float perspective<
    string label = "Perspective (0.2)";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 1.00;
    float step = 0.01;
> = .2;
uniform float depth<
    string label = "Depth (3.0)";
    string widget_type = "slider";
    float minimum = 1.00;
    float maximum = 10.00;
    float step = 0.1;
> = 3.;

#ifndef OPENGL
#define lessThan(a,b) (a < b)
#endif


uniform float4 background_color = {0.0, 0.0, 0.0, 1.0};
 
bool inBounds (float2 p) {
  return all(lessThan(float2(0.0,0.0), p)) && all(lessThan(p, float2(1.0,1.0)));
}
 
float2 project (float2 p) {
  return p * float2(1.0, -1.2) + float2(0.0, 2.22);
}
 
float4 bgColor (float2 p, float2 pfr, float2 pto) {
  float4 c = background_color;
  pfr = project(pfr);
  if (inBounds(pfr)) {
    c += lerp(background_color, image_a.Sample(textureSampler, pfr), reflection * lerp(0.0, 1.0, pfr.y));
  }
  pto = project(pto);
  if (inBounds(pto)) {
    c += lerp(background_color, image_b.Sample(textureSampler, pto), reflection * lerp(0.0, 1.0, pto.y));
  }
  return c;
}
 
float4 mainImage(VertData v_in) : TARGET {
  float2 p = v_in.uv;
  float2 pfr = float2(-1.,-1.);
  float2 pto  = float2(-1.,-1.);
 
  float progress = transition_time;
  float size = lerp(1.0, depth, progress);
  float persp = perspective * progress;
  pfr = (p + float2(-0.0, -0.5)) * float2(size/(1.0-perspective*progress), size/(1.0-size*persp*p.x)) + float2(0.0, 0.5);
 
  size = lerp(1.0, depth, 1.-progress);
  persp = perspective * (1.-progress);
  pto = (p + float2(-1.0, -0.5)) * float2(size/(1.0-perspective*(1.0-progress)), size/(1.0-size*persp*(0.5-p.x))) + float2(1.0, 0.5);
 
  bool fromOver = progress < 0.5;
  float4 rgba = background_color;
  if (fromOver) {
    if (inBounds(pfr)) {
      rgba = image_a.Sample(textureSampler, pfr);
    }
    else if (inBounds(pto)) {
      rgba = image_b.Sample(textureSampler, pto);
    }
    else {
      rgba = bgColor(p, pfr, pto);
    }
  }
  else {
    if (inBounds(pto)) {
      rgba = image_b.Sample(textureSampler, pto);
    }
    else if (inBounds(pfr)) {
      rgba = image_a.Sample(textureSampler, pfr);
    }
    else {
      rgba = bgColor(p, pfr, pto);
    }
  }
  if (convert_linear)
		rgba.rgb = srgb_nonlinear_to_linear(rgba.rgb);
	return rgba;
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

