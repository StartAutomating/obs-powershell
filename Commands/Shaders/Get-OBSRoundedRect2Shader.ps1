function Get-OBSRoundedRect2Shader {

[Alias('Set-OBSRoundedRect2Shader','Add-OBSRoundedRect2Shader')]
param(
# Set the corner_radius of OBSRoundedRect2Shader
[Alias('corner_radius')]
[ComponentModel.DefaultBindingProperty('corner_radius')]
[Int32]
$CornerRadius,
# Set the border_thickness of OBSRoundedRect2Shader
[Alias('border_thickness')]
[ComponentModel.DefaultBindingProperty('border_thickness')]
[Int32]
$BorderThickness,
# Set the border_color of OBSRoundedRect2Shader
[Alias('border_color')]
[ComponentModel.DefaultBindingProperty('border_color')]
[String]
$BorderColor,
# Set the border_alpha_start of OBSRoundedRect2Shader
[Alias('border_alpha_start')]
[ComponentModel.DefaultBindingProperty('border_alpha_start')]
[Single]
$BorderAlphaStart,
# Set the border_alpha_end of OBSRoundedRect2Shader
[Alias('border_alpha_end')]
[ComponentModel.DefaultBindingProperty('border_alpha_end')]
[Single]
$BorderAlphaEnd,
# Set the alpha_cut_off of OBSRoundedRect2Shader
[Alias('alpha_cut_off')]
[ComponentModel.DefaultBindingProperty('alpha_cut_off')]
[Single]
$AlphaCutOff,
# Set the faster_scan of OBSRoundedRect2Shader
[Alias('faster_scan')]
[ComponentModel.DefaultBindingProperty('faster_scan')]
[Management.Automation.SwitchParameter]
$FasterScan,
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
$shaderName = 'rounded_rect2'
$ShaderNoun = 'OBSRoundedRect2Shader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform int corner_radius<
    string label = "Corner radius";
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
    string label = "Border alpha start";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;
uniform float border_alpha_end<
    string label = "Border alpha end";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.0;
uniform float alpha_cut_off<
    string label = "Aplha cut off";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.5;
uniform bool faster_scan = true;

float4 mainImage(VertData v_in) : TARGET
{
    float4 pixel = image.Sample(textureSampler, v_in.uv);
    int closedEdgeX = 0;
    int closedEdgeY = 0;
    if(pixel.a < alpha_cut_off){
        return float4(1.0,0.0,0.0,0.0);
    }
    float check_dist = float(corner_radius);
    if(border_thickness > check_dist)
        check_dist = border_thickness;
    if(image.Sample(textureSampler, v_in.uv + float2(check_dist*uv_pixel_interval.x,0)).a < alpha_cut_off){
        closedEdgeX = int(check_dist);
    }else if(image.Sample(textureSampler, v_in.uv + float2(-check_dist*uv_pixel_interval.x,0)).a < alpha_cut_off){
        closedEdgeX = int(-check_dist);
    }
    if(image.Sample(textureSampler, v_in.uv + float2(0,check_dist*uv_pixel_interval.y)).a < alpha_cut_off){
        closedEdgeY = int(check_dist);
    }else if(image.Sample(textureSampler, v_in.uv + float2(0,-check_dist*uv_pixel_interval.y)).a < alpha_cut_off){
        closedEdgeY = int(-check_dist);
    }
    if(closedEdgeX == 0 && closedEdgeY == 0){
        return pixel;
    }
    if(!faster_scan || closedEdgeX != 0){
        [loop] for(int x = 1;float(x)<check_dist ;x++){
            if(image.Sample(textureSampler, v_in.uv + float2(x*uv_pixel_interval.x, 0)).a < alpha_cut_off){
                closedEdgeX = x;
                break;
            }
            if(image.Sample(textureSampler, v_in.uv + float2(-x*uv_pixel_interval.x, 0)).a < alpha_cut_off){
                closedEdgeX = -x;
                break;
            }
        }
    }
    if(!faster_scan || closedEdgeY != 0){
        [loop] for(int y = 1;y<check_dist;y++){
            if(image.Sample(textureSampler, v_in.uv + float2(0, y*uv_pixel_interval.y)).a < alpha_cut_off){
                closedEdgeY = y;
                break;
            }
            if(image.Sample(textureSampler, v_in.uv + float2(0, -y*uv_pixel_interval.y)).a < alpha_cut_off){
                closedEdgeY = -y;
                break;
            }
        }
    }
    int closedEdgeXabs = closedEdgeX < 0 ? -closedEdgeX : closedEdgeX;
    int closedEdgeYabs = closedEdgeY < 0 ? -closedEdgeY : closedEdgeY;
    if(closedEdgeX == 0){
        if(closedEdgeYabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeYabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            if(border_alpha_start < border_alpha_end){
                pixel.rgb = pixel.rgb * (1.0 - fade_color.a) + fade_color.rgb * fade_color.a;
                pixel.a = border_alpha_end + (float(closedEdgeYabs) / float(border_thickness))*(pixel.a-border_alpha_end);
                return pixel;
            }
            return fade_color;
        }else{
            return pixel;
        }
    }
    if(closedEdgeY == 0){
        if(closedEdgeXabs <= border_thickness){
            float4 fade_color = border_color;
            fade_color.a = border_alpha_end + (float(closedEdgeXabs) / float(border_thickness))*(border_alpha_start-border_alpha_end);
            if(border_alpha_start < border_alpha_end){
                pixel.rgb = pixel.rgb * (1.0 - fade_color.a) + fade_color.rgb * fade_color.a;
                pixel.a = border_alpha_end + (float(closedEdgeXabs) / float(border_thickness))*(pixel.a-border_alpha_end);
                return pixel;
            }
            return fade_color;
        }else{
            return pixel;
        }
    }

    float d = distance(float2(closedEdgeXabs, closedEdgeYabs), float2(check_dist,check_dist));
    if(d > check_dist && border_thickness > corner_radius){
        if(closedEdgeXabs < corner_radius && closedEdgeYabs < corner_radius){
            float cd = distance(float2(closedEdgeXabs, closedEdgeYabs), float2(corner_radius,corner_radius));
            if(floor(cd) > corner_radius)
                return float4(0.0,0.0,0.0,0.0);
            if(cd > corner_radius){
                d = border_thickness + cd - corner_radius;
            } else if(d > border_thickness){
                d = border_thickness;    
            }
        }else if(d > border_thickness){
            d = border_thickness;
        }
    }
    if(floor(d) <= check_dist){
        if(border_thickness > 0){
            if(ceil(check_dist-d) <= border_thickness){
                float4 fade_color = border_color;
                fade_color.a = border_alpha_end + ((check_dist-d)/ float(border_thickness))*(border_alpha_start-border_alpha_end);
                if(border_alpha_start < border_alpha_end){
                    fade_color.rgb = pixel.rgb * (1.0 - fade_color.a) + fade_color.rgb * fade_color.a;
                    fade_color.a = border_alpha_end + ((check_dist-d) / float(border_thickness))*(pixel.a-border_alpha_end);
                }
                if(d > check_dist)
                    fade_color.a *= 1.0 -(d - check_dist);
                return fade_color;
            }else if(d >= 0 && floor(check_dist-d) <= border_thickness && border_alpha_start >= border_alpha_end){
                float4 fade_color = border_color;
                float f;
                if(border_thickness > (check_dist-d))
                    f = border_thickness - (check_dist-d);
                else
                    f = 1.0 -((check_dist-d) - border_thickness);
                fade_color.rgb = pixel.rgb * (1.0 - f) + fade_color.rgb * f;
                return fade_color;
            }
        }
        if (d > check_dist)
            pixel.a *= 1.0 - (d - check_dist);
        return pixel;
        
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

