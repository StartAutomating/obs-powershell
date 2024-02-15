function Get-OBSCutRectPerCornerShader {

[Alias('Set-OBSCutRectPerCornerShader','Add-OBSCutRectPerCornerShader')]
param(
# Set the corner_tl of OBSCutRectPerCornerShader
[Alias('corner_tl')]
[ComponentModel.DefaultBindingProperty('corner_tl')]
[Int32]
$CornerTl,
# Set the corner_tr of OBSCutRectPerCornerShader
[Alias('corner_tr')]
[ComponentModel.DefaultBindingProperty('corner_tr')]
[Int32]
$CornerTr,
# Set the corner_br of OBSCutRectPerCornerShader
[Alias('corner_br')]
[ComponentModel.DefaultBindingProperty('corner_br')]
[Int32]
$CornerBr,
# Set the corner_bl of OBSCutRectPerCornerShader
[Alias('corner_bl')]
[ComponentModel.DefaultBindingProperty('corner_bl')]
[Int32]
$CornerBl,
# Set the border_thickness of OBSCutRectPerCornerShader
[Alias('border_thickness')]
[ComponentModel.DefaultBindingProperty('border_thickness')]
[Int32]
$BorderThickness,
# Set the border_color of OBSCutRectPerCornerShader
[Alias('border_color')]
[ComponentModel.DefaultBindingProperty('border_color')]
[String]
$BorderColor,
# Set the border_alpha_start of OBSCutRectPerCornerShader
[Alias('border_alpha_start')]
[ComponentModel.DefaultBindingProperty('border_alpha_start')]
[Single]
$BorderAlphaStart,
# Set the border_alpha_end of OBSCutRectPerCornerShader
[Alias('border_alpha_end')]
[ComponentModel.DefaultBindingProperty('border_alpha_end')]
[Single]
$BorderAlphaEnd,
# Set the alpha_cut_off of OBSCutRectPerCornerShader
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
$shaderName = 'cut_rect_per_corner'
$ShaderNoun = 'OBSCutRectPerCornerShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Q-mii & Exeldro February 18, 2022
uniform int corner_tl<
    string label = "Corner top left";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform int corner_tr<
    string label = "Corner top right";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform int corner_br<
    string label = "Corner bottom right";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform int corner_bl<
    string label = "Corner bottom left";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform int border_thickness<
    string label = "Border thickness";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform float4 border_color;
uniform float border_alpha_start<
    string label = "Border aplha start";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;
uniform float border_alpha_end<
    string label = "Border aplha start";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.0;
uniform float alpha_cut_off<
    string label = "Alpha cut off";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.5;

float4 mainImage(VertData v_in) : TARGET
{
    float4 pixel = image.Sample(textureSampler, v_in.uv);
    int closedEdgeX = 0;
    int closedEdgeY = 0;
    if(pixel.a < alpha_cut_off){
        return float4(1.0,0.0,0.0,0.0);
    }
    int corner_top = corner_tl>corner_tr?corner_tl:corner_tr;
    int corner_right = corner_tr>corner_br?corner_tr:corner_br;
    int corner_bottom = corner_bl>corner_br?corner_bl:corner_br;
    int corner_left = corner_tl>corner_bl?corner_tl:corner_bl;
    
    if(image.Sample(textureSampler, v_in.uv + float2(corner_right*uv_pixel_interval.x,0)).a < alpha_cut_off){
        closedEdgeX = corner_right;
    }else if(image.Sample(textureSampler, v_in.uv + float2(-corner_left*uv_pixel_interval.x,0)).a < alpha_cut_off){
        closedEdgeX = -corner_left;
    }
    if(image.Sample(textureSampler, v_in.uv + float2(0,corner_bottom*uv_pixel_interval.y)).a < alpha_cut_off){
        closedEdgeY = corner_bottom;
    }else if(image.Sample(textureSampler, v_in.uv + float2(0,-corner_top*uv_pixel_interval.y)).a < alpha_cut_off){
        closedEdgeY = -corner_top;
    }
    if(closedEdgeX == 0 && closedEdgeY == 0){
        return pixel;
    }
    if(closedEdgeX != 0){
        [loop] for(int x = 1;x<corner_right;x++){
            if(image.Sample(textureSampler, v_in.uv + float2(x*uv_pixel_interval.x, 0)).a < alpha_cut_off){
                closedEdgeX = x;
                break;
            }
        }
        [loop] for(int x = 1;x<corner_left;x++){
            if(image.Sample(textureSampler, v_in.uv + float2(-x*uv_pixel_interval.x, 0)).a < alpha_cut_off){
                closedEdgeX = -x;
                break;
            }
        }
    }
    if(closedEdgeY != 0){
        [loop] for(int y = 1;y<corner_bottom;y++){
            if(image.Sample(textureSampler, v_in.uv + float2(0, y*uv_pixel_interval.y)).a < alpha_cut_off){
                closedEdgeY = y;
                break;
            }
        }
        [loop] for(int y = 1;y<corner_top;y++){
            if(image.Sample(textureSampler, v_in.uv + float2(0, -y*uv_pixel_interval.y)).a < alpha_cut_off){
                closedEdgeY = -y;
                break;
            }
        }
    }
    int closedEdgeXabs = closedEdgeX < 0 ? -closedEdgeX : closedEdgeX;
    int closedEdgeYabs = closedEdgeY < 0 ? -closedEdgeY : closedEdgeY;
    int corner_radius = 0;
    if(closedEdgeX < 0 && closedEdgeY < 0){
        corner_radius = corner_tl;
    }else if(closedEdgeX > 0 && closedEdgeY < 0){
        corner_radius = corner_tr;
    }else if(closedEdgeX > 0 && closedEdgeY > 0){
        corner_radius = corner_br;
    }else if(closedEdgeX < 0 && closedEdgeY > 0){
        corner_radius = corner_bl;
    }
    if(closedEdgeXabs > corner_radius && closedEdgeYabs > corner_radius){
        return pixel;
    }
    if(closedEdgeXabs == 0){
        if(closedEdgeYabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeYabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return pixel;
        }
    }
    if(closedEdgeYabs == 0){
        if(closedEdgeXabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeXabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return pixel;
        }
    }
    if(closedEdgeXabs > corner_radius){
        if(closedEdgeYabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeYabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return pixel;
        }
    }
    if(closedEdgeYabs > corner_radius){
        if(closedEdgeXabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeXabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return pixel;
        }
    }
    float d = closedEdgeXabs+closedEdgeYabs;
    if(d>corner_radius){
        if(d-corner_radius <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + ((d-corner_radius)/ float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return pixel;
        }
    }
    return float4(0.0,0.0,0.0,0.0);
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

