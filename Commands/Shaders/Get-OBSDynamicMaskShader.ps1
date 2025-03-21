function Get-OBSDynamicMaskShader {

[Alias('Set-OBSDynamicMaskShader','Add-OBSDynamicMaskShader')]
param(
# Set the input_source of OBSDynamicMaskShader
[Alias('input_source')]
[ComponentModel.DefaultBindingProperty('input_source')]
[String]
$InputSource,
# Set the red_base_value of OBSDynamicMaskShader
[Alias('red_base_value')]
[ComponentModel.DefaultBindingProperty('red_base_value')]
[Single]
$RedBaseValue,
# Set the red_red_input_value of OBSDynamicMaskShader
[Alias('red_red_input_value')]
[ComponentModel.DefaultBindingProperty('red_red_input_value')]
[Single]
$RedRedInputValue,
# Set the red_green_input_value of OBSDynamicMaskShader
[Alias('red_green_input_value')]
[ComponentModel.DefaultBindingProperty('red_green_input_value')]
[Single]
$RedGreenInputValue,
# Set the red_blue_input_value of OBSDynamicMaskShader
[Alias('red_blue_input_value')]
[ComponentModel.DefaultBindingProperty('red_blue_input_value')]
[Single]
$RedBlueInputValue,
# Set the red_alpha_input_value of OBSDynamicMaskShader
[Alias('red_alpha_input_value')]
[ComponentModel.DefaultBindingProperty('red_alpha_input_value')]
[Single]
$RedAlphaInputValue,
# Set the red_multiplier of OBSDynamicMaskShader
[Alias('red_multiplier')]
[ComponentModel.DefaultBindingProperty('red_multiplier')]
[Single]
$RedMultiplier,
# Set the green_base_value of OBSDynamicMaskShader
[Alias('green_base_value')]
[ComponentModel.DefaultBindingProperty('green_base_value')]
[Single]
$GreenBaseValue,
# Set the green_red_input_value of OBSDynamicMaskShader
[Alias('green_red_input_value')]
[ComponentModel.DefaultBindingProperty('green_red_input_value')]
[Single]
$GreenRedInputValue,
# Set the green_green_input_value of OBSDynamicMaskShader
[Alias('green_green_input_value')]
[ComponentModel.DefaultBindingProperty('green_green_input_value')]
[Single]
$GreenGreenInputValue,
# Set the green_blue_input_value of OBSDynamicMaskShader
[Alias('green_blue_input_value')]
[ComponentModel.DefaultBindingProperty('green_blue_input_value')]
[Single]
$GreenBlueInputValue,
# Set the green_alpha_input_value of OBSDynamicMaskShader
[Alias('green_alpha_input_value')]
[ComponentModel.DefaultBindingProperty('green_alpha_input_value')]
[Single]
$GreenAlphaInputValue,
# Set the green_multiplier of OBSDynamicMaskShader
[Alias('green_multiplier')]
[ComponentModel.DefaultBindingProperty('green_multiplier')]
[Single]
$GreenMultiplier,
# Set the blue_base_value of OBSDynamicMaskShader
[Alias('blue_base_value')]
[ComponentModel.DefaultBindingProperty('blue_base_value')]
[Single]
$BlueBaseValue,
# Set the blue_red_input_value of OBSDynamicMaskShader
[Alias('blue_red_input_value')]
[ComponentModel.DefaultBindingProperty('blue_red_input_value')]
[Single]
$BlueRedInputValue,
# Set the blue_green_input_value of OBSDynamicMaskShader
[Alias('blue_green_input_value')]
[ComponentModel.DefaultBindingProperty('blue_green_input_value')]
[Single]
$BlueGreenInputValue,
# Set the blue_blue_input_value of OBSDynamicMaskShader
[Alias('blue_blue_input_value')]
[ComponentModel.DefaultBindingProperty('blue_blue_input_value')]
[Single]
$BlueBlueInputValue,
# Set the blue_alpha_input_value of OBSDynamicMaskShader
[Alias('blue_alpha_input_value')]
[ComponentModel.DefaultBindingProperty('blue_alpha_input_value')]
[Single]
$BlueAlphaInputValue,
# Set the blue_multiplier of OBSDynamicMaskShader
[Alias('blue_multiplier')]
[ComponentModel.DefaultBindingProperty('blue_multiplier')]
[Single]
$BlueMultiplier,
# Set the alpha_base_value of OBSDynamicMaskShader
[Alias('alpha_base_value')]
[ComponentModel.DefaultBindingProperty('alpha_base_value')]
[Single]
$AlphaBaseValue,
# Set the alpha_red_input_value of OBSDynamicMaskShader
[Alias('alpha_red_input_value')]
[ComponentModel.DefaultBindingProperty('alpha_red_input_value')]
[Single]
$AlphaRedInputValue,
# Set the alpha_green_input_value of OBSDynamicMaskShader
[Alias('alpha_green_input_value')]
[ComponentModel.DefaultBindingProperty('alpha_green_input_value')]
[Single]
$AlphaGreenInputValue,
# Set the alpha_blue_input_value of OBSDynamicMaskShader
[Alias('alpha_blue_input_value')]
[ComponentModel.DefaultBindingProperty('alpha_blue_input_value')]
[Single]
$AlphaBlueInputValue,
# Set the alpha_alpha_input_value of OBSDynamicMaskShader
[Alias('alpha_alpha_input_value')]
[ComponentModel.DefaultBindingProperty('alpha_alpha_input_value')]
[Single]
$AlphaAlphaInputValue,
# Set the alpha_multiplier of OBSDynamicMaskShader
[Alias('alpha_multiplier')]
[ComponentModel.DefaultBindingProperty('alpha_multiplier')]
[Single]
$AlphaMultiplier,
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
$shaderName = 'dynamic-mask'
$ShaderNoun = 'OBSDynamicMaskShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform texture2d input_source<
    string label = "Input Source";
>;

uniform float red_base_value<
    string label = "Base Value";
    string widget_type = "slider";
    string group = "Red Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;
uniform float red_red_input_value<
    string label = "Red Input Value";
    string widget_type = "slider";
    string group = "Red Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float red_green_input_value<
    string label = "Green Input Value";
    string widget_type = "slider";
    string group = "Red Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float red_blue_input_value<
    string label = "Blue Input Value";
    string widget_type = "slider";
    string group = "Red Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float red_alpha_input_value<
    string label = "Alpha Input Value";
    string widget_type = "slider";
    string group = "Red Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float red_multiplier<
    string label = "Multiplier";
    string widget_type = "slider";
    string group = "Red Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;

uniform float green_base_value<
    string label = "Base Value";
    string widget_type = "slider";
    string group = "Green Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;
uniform float green_red_input_value<
    string label = "Red Input Value";
    string widget_type = "slider";
    string group = "Green Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float green_green_input_value<
    string label = "Green Input Value";
    string widget_type = "slider";
    string group = "Green Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float green_blue_input_value<
    string label = "Blue Input Value";
    string widget_type = "slider";
    string group = "Green Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float green_alpha_input_value<
    string label = "Alpha Input Value";
    string widget_type = "slider";
    string group = "Green Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float green_multiplier<
    string label = "Multiplier";
    string widget_type = "slider";
    string group = "Green Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;

uniform float blue_base_value<
    string label = "Base Value";
    string widget_type = "slider";
    string group = "Blue Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;
uniform float blue_red_input_value<
    string label = "Red Input Value";
    string widget_type = "slider";
    string group = "Blue Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float blue_green_input_value<
    string label = "Green Input Value";
    string widget_type = "slider";
    string group = "Blue Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float blue_blue_input_value<
    string label = "Blue Input Value";
    string widget_type = "slider";
    string group = "Blue Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float blue_alpha_input_value<
    string label = "Alpha Input Value";
    string widget_type = "slider";
    string group = "Blue Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float blue_multiplier<
    string label = "Multiplier";
    string widget_type = "slider";
    string group = "Blue Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
>  = 1.0;

uniform float alpha_base_value<
    string label = "Base Value";
    string widget_type = "slider";
    string group = "Alpha Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;
uniform float alpha_red_input_value<
    string label = "Red Input Value";
    string widget_type = "slider";
    string group = "Alpha Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float alpha_green_input_value<
    string label = "Green Input Value";
    string widget_type = "slider";
    string group = "Alpha Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float alpha_blue_input_value<
    string label = "Blue Input Value";
    string widget_type = "slider";
    string group = "Alpha Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float alpha_alpha_input_value<
    string label = "Alpha Input Value";
    string widget_type = "slider";
    string group = "Alpha Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float alpha_multiplier<
    string label = "Multiplier";
    string widget_type = "slider";
    string group = "Alpha Channel";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 1.0;

float4 mainImage(VertData v_in) : TARGET
{
	float4 input_color = input_source.Sample(textureSampler, v_in.uv);
    float4 mask;
    mask.r = (red_base_value + red_red_input_value * input_color.r + red_green_input_value * input_color.g + red_blue_input_value * input_color.b + red_alpha_input_value * input_color.a) * red_multiplier;
    mask.g = (green_base_value + green_red_input_value * input_color.r + green_green_input_value * input_color.g + green_blue_input_value * input_color.b + green_alpha_input_value * input_color.a) * green_multiplier;
    mask.b = (blue_base_value + blue_red_input_value * input_color.r + blue_green_input_value * input_color.g + blue_blue_input_value * input_color.b + blue_alpha_input_value * input_color.a) * blue_multiplier;
    mask.a = (alpha_base_value + alpha_red_input_value * input_color.r + alpha_green_input_value * input_color.g + alpha_blue_input_value * input_color.b + alpha_alpha_input_value * input_color.a) * alpha_multiplier;
	float4 base = image.Sample(textureSampler, v_in.uv);
	return base * mask;
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

