function Get-OBSZigZagShader {

[Alias('Set-OBSZigZagShader','Add-OBSZigZagShader')]
param(
# Set the radius of OBSZigZagShader
[ComponentModel.DefaultBindingProperty('radius')]
[Single]
$Radius,
# Set the angle of OBSZigZagShader
[ComponentModel.DefaultBindingProperty('angle')]
[Single]
$Angle,
# Set the period of OBSZigZagShader
[ComponentModel.DefaultBindingProperty('period')]
[Single]
$Period,
# Set the amplitude of OBSZigZagShader
[ComponentModel.DefaultBindingProperty('amplitude')]
[Single]
$Amplitude,
# Set the center_x of OBSZigZagShader
[Alias('center_x')]
[ComponentModel.DefaultBindingProperty('center_x')]
[Single]
$CenterX,
# Set the center_y of OBSZigZagShader
[Alias('center_y')]
[ComponentModel.DefaultBindingProperty('center_y')]
[Single]
$CenterY,
# Set the phase of OBSZigZagShader
[ComponentModel.DefaultBindingProperty('phase')]
[Single]
$Phase,
# Set the animate of OBSZigZagShader
[ComponentModel.DefaultBindingProperty('animate')]
[Int32]
$Animate,
# Set the notes of OBSZigZagShader
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
$shaderName = 'ZigZag'
$ShaderNoun = 'OBSZigZagShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Created by Radegast Stravinsky for obs-shaderfilter 9/2020
uniform float radius<
    string label = "radius";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 5.0;
    float step = 0.001;
> = 0.0;
uniform float angle<
    string label = "angle";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 360.0;
    float step = 0.1;
> = 180.0;
uniform float period<
    string label = "period";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 5.0;
    float step = 0.001;
> = 0.5;
uniform float amplitude<
    string label = "amplitude";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 5.0;
    float step = 0.001;
> = 1.0;

uniform float center_x<
    string label = "center x";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.5;
    float step = 0.001;
> = 0.25;
uniform float center_y<
    string label = "center y";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.5;
    float step = 0.001;
> = 0.25;

uniform float phase<
    string label = "phase";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 5.0;
    float step = 0.001;
> = 1.0;
uniform int animate<
  string label = "animate";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "No";
  int    option_1_value = 1;
  string option_1_label = "Amplitude";
  int    option_2_value = 2;
  string option_2_label = "Time";
> = 0;


uniform string notes = "Distorts the screen, creating a rippling effect that moves clockwise and anticlockwise."


float4 mainImage(VertData v_in) : TARGET
{
    float2 center = float2(center_x, center_y);
	VertData v_out;
    v_out.pos = v_in.pos;
    float2 hw = uv_size;
    float ar = 1. * hw.y/hw.x;

    v_out.uv = 1. * v_in.uv - center;
    
    center.x /= ar;
    v_out.uv.x /= ar;
    
    float dist = distance(v_out.uv, center);
    if (dist < radius)
    {
        float percent = (radius-dist)/radius;
        float theta = percent * percent * 
        (
            animate == 1 ? 
                amplitude * sin(elapsed_time) : 
                amplitude
        ) 
        * sin(percent * percent / period * radians(angle) + (phase + 
        (
            animate == 2 ? 
            elapsed_time : 
            0
        )));

        float s =  sin(theta);
        float c = cos(theta);
        v_out.uv = float2(dot(v_out.uv-center, float2(c,-s)), dot(v_out.uv-center, float2(s,c)));
        v_out.uv += (2 * center);
        
        v_out.uv.x *= ar;

        return image.Sample(textureSampler, v_out.uv);
    }
    else
    {
        return image.Sample(textureSampler, v_in.uv);
    }
        
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

