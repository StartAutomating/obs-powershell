function Get-OBSColorDepthShader {

[Alias('Set-OBSColorDepthShader','Add-OBSColorDepthShader')]
param(
# Set the colorDepth of OBSColorDepthShader
[ComponentModel.DefaultBindingProperty('colorDepth')]
[Single]
$ColorDepth,
# Set the pixelSize of OBSColorDepthShader
[ComponentModel.DefaultBindingProperty('pixelSize')]
[Single]
$PixelSize,
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
    $ShaderNoun = 'OBSColorDepthShader'
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/tscfWM
uniform float colorDepth<
    string label = "Color depth";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 100.0;
    float step = 0.01;
> = 5.0;

uniform float pixelSize<
    string label = "Pixel Size";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 100.0;
    float step = 0.01;
> = 5.0; 


float4 mainImage(VertData v_in) : TARGET
{
    // Change these to change results
    float2 size = uv_size / pixelSize;
    float2 uv = v_in.uv;
    // Maps UV onto grid of variable size to pixilate the image
    uv = round(uv*size)/size;
    float4 col = image.Sample(textureSampler, uv);
    // Maps color onto the specified color depth
    return float4(round(col.r * colorDepth) / colorDepth, 
                    round(col.g * colorDepth) / colorDepth,
                    round(col.b * colorDepth) / colorDepth, 1.0);
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

