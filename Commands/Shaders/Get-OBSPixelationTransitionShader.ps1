function Get-OBSPixelationTransitionShader {

[Alias('Set-OBSPixelationTransitionShader','Add-OBSPixelationTransitionShader')]
param(
# Set the transition_time of OBSPixelationTransitionShader
[Alias('transition_time')]
[ComponentModel.DefaultBindingProperty('transition_time')]
[Single]
$TransitionTime,
# Set the convert_linear of OBSPixelationTransitionShader
[Alias('convert_linear')]
[ComponentModel.DefaultBindingProperty('convert_linear')]
[Management.Automation.SwitchParameter]
$ConvertLinear,
# Set the power of OBSPixelationTransitionShader
[ComponentModel.DefaultBindingProperty('power')]
[Single]
$Power,
# Set the center_x of OBSPixelationTransitionShader
[Alias('center_x')]
[ComponentModel.DefaultBindingProperty('center_x')]
[Single]
$CenterX,
# Set the center_y of OBSPixelationTransitionShader
[Alias('center_y')]
[ComponentModel.DefaultBindingProperty('center_y')]
[Single]
$CenterY,
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
$shaderName = 'pixelation-transition'
$ShaderNoun = 'OBSPixelationTransitionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float transition_time<
    string label = "Transittion Time";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;
uniform bool convert_linear = true;
uniform float power<
    string label = "Power";
    string widget_type = "slider";
    float minimum = 0.5;
    float maximum = 8.0;
    float step = 0.01;
> = 3.0;
uniform float center_x<
    string label = "X";
    string widget_type = "slider";
	string group = "Center";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;
uniform float center_y<
    string label = "Y";
    string widget_type = "slider";
	string group = "Center";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;

float4 mainImage(VertData v_in) : TARGET
{
	//1..0..1
	float scale = abs(transition_time - 0.5) * 2.0;
	scale = pow(scale, power);

	float2 uv = v_in.uv;
	uv -= float2(center_x, center_y);
	uv *= uv_size;
	uv *= scale;
	uv = floor(uv);
	uv /= scale;
	uv /= uv_size;
	uv += float2(center_x, center_y);
	uv = clamp(uv, 1.0/uv_size, 1.0);
	float4 rgba = image.Sample(textureSampler, uv);
	if(convert_linear)
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

