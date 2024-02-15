function Get-OBSPieChartShader {

[Alias('Set-OBSPieChartShader','Add-OBSPieChartShader')]
param(
# Set the inner_radius of OBSPieChartShader
[Alias('inner_radius')]
[ComponentModel.DefaultBindingProperty('inner_radius')]
[Single]
$InnerRadius,
# Set the outer_radius of OBSPieChartShader
[Alias('outer_radius')]
[ComponentModel.DefaultBindingProperty('outer_radius')]
[Single]
$OuterRadius,
# Set the start_angle of OBSPieChartShader
[Alias('start_angle')]
[ComponentModel.DefaultBindingProperty('start_angle')]
[Single]
$StartAngle,
# Set the total of OBSPieChartShader
[ComponentModel.DefaultBindingProperty('total')]
[Int32]
$Total,
# Set the part_1 of OBSPieChartShader
[Alias('part_1')]
[ComponentModel.DefaultBindingProperty('part_1')]
[Int32]
$Part1,
# Set the color_1 of OBSPieChartShader
[Alias('color_1')]
[ComponentModel.DefaultBindingProperty('color_1')]
[String]
$Color1,
# Set the part_2 of OBSPieChartShader
[Alias('part_2')]
[ComponentModel.DefaultBindingProperty('part_2')]
[Int32]
$Part2,
# Set the color_2 of OBSPieChartShader
[Alias('color_2')]
[ComponentModel.DefaultBindingProperty('color_2')]
[String]
$Color2,
# Set the part_3 of OBSPieChartShader
[Alias('part_3')]
[ComponentModel.DefaultBindingProperty('part_3')]
[Int32]
$Part3,
# Set the color_3 of OBSPieChartShader
[Alias('color_3')]
[ComponentModel.DefaultBindingProperty('color_3')]
[String]
$Color3,
# Set the part_4 of OBSPieChartShader
[Alias('part_4')]
[ComponentModel.DefaultBindingProperty('part_4')]
[Int32]
$Part4,
# Set the color_4 of OBSPieChartShader
[Alias('color_4')]
[ComponentModel.DefaultBindingProperty('color_4')]
[String]
$Color4,
# Set the part_5 of OBSPieChartShader
[Alias('part_5')]
[ComponentModel.DefaultBindingProperty('part_5')]
[Int32]
$Part5,
# Set the color_5 of OBSPieChartShader
[Alias('color_5')]
[ComponentModel.DefaultBindingProperty('color_5')]
[String]
$Color5,
# Set the part_6 of OBSPieChartShader
[Alias('part_6')]
[ComponentModel.DefaultBindingProperty('part_6')]
[Int32]
$Part6,
# Set the color_6 of OBSPieChartShader
[Alias('color_6')]
[ComponentModel.DefaultBindingProperty('color_6')]
[String]
$Color6,
# Set the part_7 of OBSPieChartShader
[Alias('part_7')]
[ComponentModel.DefaultBindingProperty('part_7')]
[Int32]
$Part7,
# Set the color_7 of OBSPieChartShader
[Alias('color_7')]
[ComponentModel.DefaultBindingProperty('color_7')]
[String]
$Color7,
# Set the part_8 of OBSPieChartShader
[Alias('part_8')]
[ComponentModel.DefaultBindingProperty('part_8')]
[Int32]
$Part8,
# Set the color_8 of OBSPieChartShader
[Alias('color_8')]
[ComponentModel.DefaultBindingProperty('color_8')]
[String]
$Color8,
# Set the part_9 of OBSPieChartShader
[Alias('part_9')]
[ComponentModel.DefaultBindingProperty('part_9')]
[Int32]
$Part9,
# Set the color_9 of OBSPieChartShader
[Alias('color_9')]
[ComponentModel.DefaultBindingProperty('color_9')]
[String]
$Color9,
# Set the part_10 of OBSPieChartShader
[Alias('part_10')]
[ComponentModel.DefaultBindingProperty('part_10')]
[Int32]
$Part10,
# Set the color_10 of OBSPieChartShader
[Alias('color_10')]
[ComponentModel.DefaultBindingProperty('color_10')]
[String]
$Color10,
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
$shaderName = 'pie-chart'
$ShaderNoun = 'OBSPieChartShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float inner_radius<
    string label = "inner radius";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 32.0;
uniform float outer_radius<
    string label = "outer radius";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 50.0;
uniform float start_angle<
    string label = "Start angle";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 360.0;
    float step = 0.1;
> = 90.0;

uniform int total<
    string label = "Total";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 100;
uniform int part_1<
    string label = "Part 1";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 50;
uniform float4 color_1 = {0.0,0.26,0.62,1.0};
uniform int part_2<
    string label = "Part 2";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 25;
uniform float4 color_2 = {0.24,0.40,0.68,1.0};
uniform int part_3<
    string label = "Part 3";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 10;
uniform float4 color_3 = {0.38,0.56,0.75,1.0};
uniform int part_4<
    string label = "Part 4";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 5;
uniform float4 color_4 = {0.52,0.72,0.81,1.0};
uniform int part_5<
    string label = "Part 5";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 3;
uniform float4 color_5 = {0.69,0.87,0.86,1.0};
uniform int part_6<
    string label = "Part 6";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 2;
uniform float4 color_6 = {1.0,0.79,0.73,1.0};
uniform int part_7<
    string label = "Part 7";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 1;
uniform float4 color_7 = {0.99,0.57,0.57,1.0};
uniform int part_8<
    string label = "Part 8";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 1;
uniform float4 color_8 = {0.91,0.36,0.44,1.0};
uniform int part_9<
    string label = "Part 9";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 1;
uniform float4 color_9 = {0.77,0.16,0.32,1.0};
uniform int part_10<
    string label = "Part 10";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 1000;
    int step = 1;
> = 0;
uniform float4 color_10 = {0.58,0.0,0.23,1.0};

float4 mainImage(VertData v_in) : TARGET
{
    const float pi = 3.14159265358979323846;
#ifdef OPENGL
    float[10] parts = float[10](part_1, part_2, part_3, part_4, part_5, part_6, part_7, part_8, part_9, part_10);
    float4[10] colors = float4[10](color_1, color_2, color_3, color_4, color_5, color_6, color_7, color_8, color_9, color_10);
#else
    float parts[] = {part_1, part_2, part_3, part_4, part_5, part_6, part_7, part_8, part_9, part_10};
    float4 colors[] = {color_1, color_2, color_3, color_4, color_5, color_6, color_7, color_8, color_9, color_10};
#endif
    float2 center = float2(0.5, 0.5);
    float2 factor;
    if(uv_size.x < uv_size.y){
        factor = float2(1.0, uv_size.y/uv_size.x);
    }else{
        factor = float2(uv_size.x/uv_size.y, 1.0);
    }
    center = center * factor;
    float d = distance(center, v_in.uv * factor);
    if(d > outer_radius/100.0 || d < inner_radius/100.0){
        return image.Sample(textureSampler, v_in.uv);
    }
    float2 toCenter = center - v_in.uv*factor;
    float angle = atan2(toCenter.y ,toCenter.x);
    angle = angle - (start_angle / 180.0 * pi);
    if(angle < 0.0) 
        angle = pi + pi + angle;
    if(angle < 0.0) 
        angle = pi + pi + angle;
    angle = angle / (pi + pi);
    float t = 0.0;
    for(int i = 0; i < 10; i+=1) {
        float part = parts[i]/total;
        if(angle > t && angle <= t+part){
            return colors[i];
        }
        t = t + part;
    }
    return image.Sample(textureSampler, v_in.uv);
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

