function Get-OBSExeldroBentCameraShader {

[Alias('Set-OBSExeldroBentCameraShader','Add-OBSExeldroBentCameraShader')]
param(
# Set the left_side_width of OBSExeldroBentCameraShader
[Alias('left_side_width')]
[ComponentModel.DefaultBindingProperty('left_side_width')]
[Single]
$LeftSideWidth,
# Set the left_side_size of OBSExeldroBentCameraShader
[Alias('left_side_size')]
[ComponentModel.DefaultBindingProperty('left_side_size')]
[Single]
$LeftSideSize,
# Set the left_side_shadow of OBSExeldroBentCameraShader
[Alias('left_side_shadow')]
[ComponentModel.DefaultBindingProperty('left_side_shadow')]
[Single]
$LeftSideShadow,
# Set the left_flip_width of OBSExeldroBentCameraShader
[Alias('left_flip_width')]
[ComponentModel.DefaultBindingProperty('left_flip_width')]
[Single]
$LeftFlipWidth,
# Set the left_flip_shadow of OBSExeldroBentCameraShader
[Alias('left_flip_shadow')]
[ComponentModel.DefaultBindingProperty('left_flip_shadow')]
[Single]
$LeftFlipShadow,
# Set the right_side_width of OBSExeldroBentCameraShader
[Alias('right_side_width')]
[ComponentModel.DefaultBindingProperty('right_side_width')]
[Single]
$RightSideWidth,
# Set the right_side_size of OBSExeldroBentCameraShader
[Alias('right_side_size')]
[ComponentModel.DefaultBindingProperty('right_side_size')]
[Single]
$RightSideSize,
# Set the right_side_shadow of OBSExeldroBentCameraShader
[Alias('right_side_shadow')]
[ComponentModel.DefaultBindingProperty('right_side_shadow')]
[Single]
$RightSideShadow,
# Set the right_flip_width of OBSExeldroBentCameraShader
[Alias('right_flip_width')]
[ComponentModel.DefaultBindingProperty('right_flip_width')]
[Single]
$RightFlipWidth,
# Set the right_flip_shadow of OBSExeldroBentCameraShader
[Alias('right_flip_shadow')]
[ComponentModel.DefaultBindingProperty('right_flip_shadow')]
[Single]
$RightFlipShadow,
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
$shaderName = 'exeldro-bent-camera'
$ShaderNoun = 'OBSExeldroBentCameraShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float left_side_width<
    string label = "Left side width";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.1;
uniform float left_side_size<
    string label = "Left side size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.9;
uniform float left_side_shadow<
    string label = "Left side shadow";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.8;
uniform float left_flip_width<
    string label = "Left flip width";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.05;
uniform float left_flip_shadow<
    string label = "Left flip shadow";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.6;

uniform float right_side_width<
    string label = "Right side width";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.1;
uniform float right_side_size<
    string label = "Right side size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.9;
uniform float right_side_shadow<
    string label = "Right side shadow";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.8;
uniform float right_flip_width<
    string label = "Right flip width";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.05;
uniform float right_flip_shadow<
    string label = "Right flip shadow";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.6;

float4 mainImage(VertData v_in) : TARGET
{
    float2 pos=v_in.uv;
    float shadow = 1.0;
    if(pos.x < left_side_width){
        pos.y -= 0.5;
        pos.y /= left_side_size;
        pos.y += 0.5;
        pos.x -= left_side_width + left_flip_width / 2.0;
        pos.x /= left_side_size;
        pos.x += left_side_width + left_flip_width / 2.0;
        shadow = left_side_shadow;
    }else if(pos.x < left_side_width + left_flip_width){
        float factor = 1.0 - ((left_side_width + left_flip_width)-pos.x)/left_flip_width*(1.0 - left_side_size);
        pos.y -= 0.5;
        pos.y /= factor;
        pos.y += 0.5;
        pos.x -= left_side_width + left_flip_width;
        pos.x /= factor;
        pos.x += left_side_width + left_flip_width;
        shadow = left_flip_shadow;
    }

    if(1.0 - pos.x < right_side_width){
        pos.y -= 0.5;
        pos.y /= right_side_size;
        pos.y += 0.5;
        pos.x -= 1.0 - (right_side_width + right_flip_width / 2.0);
        pos.x /= right_side_size;
        pos.x += 1.0 - (right_side_width + right_flip_width / 2.0);
        shadow = right_side_shadow;
    }else if(1.0 - pos.x < right_side_width + right_flip_width){
        float factor = 1.0 - ((right_side_width + right_flip_width) - (1.0 - pos.x))/right_flip_width*(1.0 - right_side_size);
        pos.y -= 0.5;
        pos.y /= factor;
        pos.y += 0.5;
        pos.x -= 1.0 - (right_side_width + right_flip_width);
        pos.x /= factor;
        pos.x += 1.0 -(right_side_width + right_flip_width);
        shadow = right_flip_shadow;
    }
    float4 p_color = image.Sample(textureSampler, pos);
    p_color.rgb *= shadow;
    return p_color;
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

