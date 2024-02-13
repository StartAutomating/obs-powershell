function Get-OBSAlphaBorderShader {

[Alias('Set-OBSAlphaBorderShader','Add-OBSAlphaBorderShader')]
param(
# Set the border_color of OBSAlphaBorderShader
[Alias('border_color')]
[ComponentModel.DefaultBindingProperty('border_color')]
[Single[]]
$BorderColor,
# Set the border_thickness of OBSAlphaBorderShader
[Alias('border_thickness')]
[ComponentModel.DefaultBindingProperty('border_thickness')]
[Int32]
$BorderThickness,
# Set the alpha_cut_off of OBSAlphaBorderShader
[Alias('alpha_cut_off')]
[ComponentModel.DefaultBindingProperty('alpha_cut_off')]
[Single]
$AlphaCutOff,
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
    $ShaderNoun = 'OBSAlphaBorderShader'
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float4 border_color<
    string label = "Border color";
> = {0.0,0.0,0.0,1.0};
uniform int border_thickness<
    string label = "Border thickness";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 0;
uniform float alpha_cut_off<
    string label = "Alpha cut off";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.5;

float4 mainImage(VertData v_in) : TARGET
{
    float4 pix = image.Sample(textureSampler, v_in.uv);
    if (pix.a > alpha_cut_off)
        return pix;
    [loop] for(int x = -border_thickness;x<border_thickness;x++){
            [loop] for(int y = -border_thickness;y<border_thickness;y++){
                if(abs(x*x)+abs(y*y) < border_thickness*border_thickness){
                    float4 t = image.Sample(textureSampler, v_in.uv + float2(x*uv_pixel_interval.x,y*uv_pixel_interval.y));
                    if(t.a > alpha_cut_off)
                        return border_color;
                }
            }
    }
    return pix;
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

