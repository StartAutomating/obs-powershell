function Get-OBSRoundedRectPerSideShader {

[Alias('Set-OBSRoundedRectPerSideShader','Add-OBSRoundedRectPerSideShader')]
param(
# Set the corner_radius_bottom of OBSRoundedRectPerSideShader
[Alias('corner_radius_bottom')]
[ComponentModel.DefaultBindingProperty('corner_radius_bottom')]
[Int32]
$CornerRadiusBottom,
# Set the corner_radius_left of OBSRoundedRectPerSideShader
[Alias('corner_radius_left')]
[ComponentModel.DefaultBindingProperty('corner_radius_left')]
[Int32]
$CornerRadiusLeft,
# Set the corner_radius_top of OBSRoundedRectPerSideShader
[Alias('corner_radius_top')]
[ComponentModel.DefaultBindingProperty('corner_radius_top')]
[Int32]
$CornerRadiusTop,
# Set the corner_radius_right of OBSRoundedRectPerSideShader
[Alias('corner_radius_right')]
[ComponentModel.DefaultBindingProperty('corner_radius_right')]
[Int32]
$CornerRadiusRight,
# Set the border_thickness of OBSRoundedRectPerSideShader
[Alias('border_thickness')]
[ComponentModel.DefaultBindingProperty('border_thickness')]
[Int32]
$BorderThickness,
# Set the border_color of OBSRoundedRectPerSideShader
[Alias('border_color')]
[ComponentModel.DefaultBindingProperty('border_color')]
[String]
$BorderColor,
# Set the border_alpha_start of OBSRoundedRectPerSideShader
[Alias('border_alpha_start')]
[ComponentModel.DefaultBindingProperty('border_alpha_start')]
[Single]
$BorderAlphaStart,
# Set the border_alpha_end of OBSRoundedRectPerSideShader
[Alias('border_alpha_end')]
[ComponentModel.DefaultBindingProperty('border_alpha_end')]
[Single]
$BorderAlphaEnd,
# Set the alpha_cut_off of OBSRoundedRectPerSideShader
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
$shaderName = 'rounded_rect_per_side'
$ShaderNoun = 'OBSRoundedRectPerSideShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform int corner_radius_bottom<
    string label = "Corner radius bottom";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 200;
    int step = 1;
>;
uniform int corner_radius_left<
    string label = "Corner radius left";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 200;
    int step = 1;
>;
uniform int corner_radius_top<
    string label = "Corner radius top";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 200;
    int step = 1;
>;
uniform int corner_radius_right<
    string label = "Corner radius right";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 200;
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
    string label = "border alpha start";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 1.0;
uniform float border_alpha_end<
    string label = "border alpha end";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;
uniform float alpha_cut_off<
    string label = "alpha cut off";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;

float4 mainImage(VertData v_in) : TARGET
{
    float4 output_color = image.Sample(textureSampler, v_in.uv);
    int closedEdgeX = 0;
    int closedEdgeY = 0;
    if(output_color.a < alpha_cut_off){
        return float4(1.0,0.0,0.0,0.0);
    }
    if(image.Sample(textureSampler, v_in.uv + float2(corner_radius_right*uv_pixel_interval.x,0)).a < alpha_cut_off){
        closedEdgeX = corner_radius_right;
    }else if(image.Sample(textureSampler, v_in.uv + float2(-corner_radius_left*uv_pixel_interval.x,0)).a < alpha_cut_off){
        closedEdgeX = -corner_radius_left;
    }
    if(image.Sample(textureSampler, v_in.uv + float2(0,corner_radius_bottom*uv_pixel_interval.y)).a < alpha_cut_off){
        closedEdgeY = corner_radius_bottom;
    }else if(image.Sample(textureSampler, v_in.uv + float2(0,-corner_radius_top*uv_pixel_interval.y)).a < alpha_cut_off){
        closedEdgeY = -corner_radius_top;
    }
    if(closedEdgeX == 0 && closedEdgeY == 0){
        return output_color;
    }
    if(closedEdgeX != 0){
        [loop] for(int x = 1;x<corner_radius_right;x++){
            if(image.Sample(textureSampler, v_in.uv + float2(x*uv_pixel_interval.x, 0)).a < alpha_cut_off){
                closedEdgeX = x;
                break;
            }
        }
        [loop] for(int x = 1;x<corner_radius_left;x++){
            if(image.Sample(textureSampler, v_in.uv + float2(-x*uv_pixel_interval.x, 0)).a < alpha_cut_off){
                closedEdgeX = -x;
                break;
            }
        }
    }
    if(closedEdgeY != 0){
        [loop] for(int y = 1;y<corner_radius_bottom;y++){
            if(image.Sample(textureSampler, v_in.uv + float2(0, y*uv_pixel_interval.y)).a < alpha_cut_off){
                closedEdgeY = y;
                break;
            }
        }
        [loop] for(int y = 1;y<corner_radius_top;y++){
            if(image.Sample(textureSampler, v_in.uv + float2(0, -y*uv_pixel_interval.y)).a < alpha_cut_off){
                closedEdgeY = -y;
                break;
            }
        }
    }
    int closedEdgeXabs = closedEdgeX < 0 ? -closedEdgeX : closedEdgeX;
    int closedEdgeYabs = closedEdgeY < 0 ? -closedEdgeY : closedEdgeY;
    float corner_radius_x = closedEdgeX < 0? corner_radius_left: corner_radius_right;
    float corner_radius_y = closedEdgeY < 0 ? corner_radius_top:corner_radius_bottom;
    float corner_radius = corner_radius_x < corner_radius_y ? corner_radius_x : corner_radius_y;
    if(closedEdgeXabs > corner_radius){
        closedEdgeXabs = 0;
    }
    if(closedEdgeYabs > corner_radius){
        closedEdgeYabs = 0;
    }
    if(closedEdgeXabs == 0 && closedEdgeYabs == 0){
        return output_color;
    }
    if(closedEdgeXabs == 0){
        if(closedEdgeYabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeYabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return output_color;
        }
    }
    if(closedEdgeYabs == 0){
        if(closedEdgeXabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeXabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return output_color;
        }
    }

    float closest = closedEdgeXabs<closedEdgeYabs?closedEdgeXabs:closedEdgeYabs;
    float d = distance(float2(closedEdgeXabs, closedEdgeYabs), float2(corner_radius,corner_radius));
    if(d<corner_radius){
        if(corner_radius-d <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + ((corner_radius-d)/ float(border_thickness))*(border_alpha_start-border_alpha_end);
            return fade_color;
        }else{
            return output_color;
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

