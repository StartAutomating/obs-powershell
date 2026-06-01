function Get-OBSDisplacementMapShader {

[Alias('Set-OBSDisplacementMapShader','Add-OBSDisplacementMapShader')]
param(
# Set the displacement_info of OBSDisplacementMapShader
[Alias('displacement_info')]
[ComponentModel.DefaultBindingProperty('displacement_info')]
[String]
$DisplacementInfo,
# Set the displacement_x of OBSDisplacementMapShader
[Alias('displacement_x')]
[ComponentModel.DefaultBindingProperty('displacement_x')]
[Single]
$DisplacementX,
# Set the displacement_y of OBSDisplacementMapShader
[Alias('displacement_y')]
[ComponentModel.DefaultBindingProperty('displacement_y')]
[Single]
$DisplacementY,
# Set the mask_layer of OBSDisplacementMapShader
[Alias('mask_layer')]
[ComponentModel.DefaultBindingProperty('mask_layer')]
[String]
$MaskLayer,
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
$shaderName = 'displacement_map'
$ShaderNoun = 'OBSDisplacementMapShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform string displacement_info<
  string label = "Displacement";
  string widget_type = "info";
> = "Displaces the current image with the Mask Layer. Red channel is affected to X (horizontal) displacement and Green channel to Y (vertical). rgb(.5, .5, .5) is no displacement.";

uniform float displacement_x<
  string label = "Displacement X (px)";
> = 16.0;

uniform float displacement_y<
  string label = "Displacement Y (px)";
> = 16.0;

uniform texture2d mask_layer <string label = "Mask Layer";>;

float4 mainImage(VertData v_in) : TARGET
{
    float4 map = mask_layer.Sample(textureSampler, v_in.uv);
		float4 base = image.Sample(textureSampler, v_in.uv);

    float2 displace_strength = float2(displacement_x, displacement_y) / uv_size;
    float4 displace = float4(
      (map.r * 2) - 1,
      (map.g * 2) - 1,
      (map.b * 2) - 1,
      map.a
    );

    float2 displace_uv = float2(displace.r, displace.g) * displace_strength;
		float4 displaced = image.Sample(textureSampler, v_in.uv + displace_uv);

    return float4(displaced.r, displaced.g, displaced.b, displaced.a * displace.a);
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

