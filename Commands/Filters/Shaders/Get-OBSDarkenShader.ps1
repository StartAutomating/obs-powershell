function Get-OBSDarkenShader {

[Alias('Set-OBSDarkenShader','Add-OBSDarkenShader')]
param(
# Set the Opacity_Percentage of OBSDarkenShader
[Alias('Opacity_Percentage')]
[ComponentModel.DefaultBindingProperty('Opacity_Percentage')]
[Single]
$OpacityPercentage,
# Set the Fill_Percentage of OBSDarkenShader
[Alias('Fill_Percentage')]
[ComponentModel.DefaultBindingProperty('Fill_Percentage')]
[Single]
$FillPercentage,
# Set the Notes of OBSDarkenShader
[ComponentModel.DefaultBindingProperty('Notes')]
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
# If set, will pass thru the commands that would be sent to OBS (these can be sent at any time with Send-OBS)
[Management.Automation.SwitchParameter]
$PassThru,
# If set, will not wait for a response from OBS (this will be faster, but will not return anything)
[Management.Automation.SwitchParameter]
$NoResponse
)


process {
if (-not $psBoundParameters['ShaderText']) {
    $shaderName = $shaderName    
    $ShaderNoun = 'OBSDarkenShader'
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float Opacity_Percentage = 100.0;
uniform float Fill_Percentage = 100.0;
uniform string Notes = "Simulates a photo editing darken layer blending mode. Fill percentage is the interior alpha and Opacity is the layer alpha.";

float4 mainImage(VertData v_in) : TARGET
{
	float4 other = float4(1.0, 1.0, 1.0, 1.0);
	float4 base = image.Sample(textureSampler, v_in.uv);
	float luminance = dot(base.rgb, float3(0.299, 0.587, 0.114));
	float4 gray = float4(luminance,luminance,luminance, 1.0);

	return min(base,other);
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
                [Regex]::Escape($shaderName),[Regex]::Escape($ShaderNoun -replace '^OBS' -replace 'Shader$') -join '|'
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
    '(?>Add|Set)' {
        $ShaderSettings = [Ordered]@{}
        :nextParameter foreach ($parameterMetadata in $MyInvocation.MyCommand.Parameters[@($psBoundParameters.Keys)]) {
            foreach ($parameterAttribute in $parameterMetadata.Attributes) {
                if ($parameterAttribute -isnot [ComponentModel.DefaultBindingPropertyAttribute]) { continue }
                $ShaderSettings[$parameterAttribute.Name] = $PSBoundParameters[$parameterMetadata.Name]
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

        if ($myVerb -eq 'Add') {
            $ShaderFilterSplat.ShaderText = $shaderText
            Add-OBSShaderFilter @ShaderFilterSplat
        } else {
            Set-OBSShaderFilter @ShaderFilterSplat
        }
    }
}

}


} 
