function Get-OBSHexagonShader {

[Alias('Set-OBSHexagonShader','Add-OBSHexagonShader')]
param(
# Set the Hex_Color of OBSHexagonShader
[Alias('Hex_Color')]
[ComponentModel.DefaultBindingProperty('Hex_Color')]
[String]
$HexColor,
# Set the Alpha_Percent of OBSHexagonShader
[Alias('Alpha_Percent')]
[ComponentModel.DefaultBindingProperty('Alpha_Percent')]
[Int32]
$AlphaPercent,
# Set the Quantity of OBSHexagonShader
[ComponentModel.DefaultBindingProperty('Quantity')]
[Single]
$Quantity,
# Set the Border_Width of OBSHexagonShader
[Alias('Border_Width')]
[ComponentModel.DefaultBindingProperty('Border_Width')]
[Int32]
$BorderWidth,
# Set the Blend of OBSHexagonShader
[ComponentModel.DefaultBindingProperty('Blend')]
[Management.Automation.SwitchParameter]
$Blend,
# Set the Equilateral of OBSHexagonShader
[ComponentModel.DefaultBindingProperty('Equilateral')]
[Management.Automation.SwitchParameter]
$Equilateral,
# Set the Zoom_Animate of OBSHexagonShader
[Alias('Zoom_Animate')]
[ComponentModel.DefaultBindingProperty('Zoom_Animate')]
[Management.Automation.SwitchParameter]
$ZoomAnimate,
# Set the Speed_Percent of OBSHexagonShader
[Alias('Speed_Percent')]
[ComponentModel.DefaultBindingProperty('Speed_Percent')]
[Int32]
$SpeedPercent,
# Set the Glitch of OBSHexagonShader
[ComponentModel.DefaultBindingProperty('Glitch')]
[Management.Automation.SwitchParameter]
$Glitch,
# Set the Distort_X of OBSHexagonShader
[Alias('Distort_X')]
[ComponentModel.DefaultBindingProperty('Distort_X')]
[Single]
$DistortX,
# Set the Distort_Y of OBSHexagonShader
[Alias('Distort_Y')]
[ComponentModel.DefaultBindingProperty('Distort_Y')]
[Single]
$DistortY,
# Set the Offset_X of OBSHexagonShader
[Alias('Offset_X')]
[ComponentModel.DefaultBindingProperty('Offset_X')]
[Single]
$OffsetX,
# Set the Offset_Y of OBSHexagonShader
[Alias('Offset_Y')]
[ComponentModel.DefaultBindingProperty('Offset_Y')]
[Single]
$OffsetY,
# Set the notes of OBSHexagonShader
[ComponentModel.DefaultBindingProperty('notes')]
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
$shaderName = 'hexagon'
$ShaderNoun = 'OBSHexagonShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Hexagon shader by Charles Fettinger for obs-shaderfilter plugin 4/2019
//https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Q-mii & Exeldro February 25, 2022
uniform float4 Hex_Color;
uniform int Alpha_Percent<
    string label = "Aplha percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 100;
uniform float Quantity<
    string label = "Quantity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 25;
uniform int Border_Width<
    string label = "Border Width";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 115;
    int step = 1;
> = 15;  // <- -15 to 85, -15 off top
uniform bool Blend;
uniform bool Equilateral;
uniform bool Zoom_Animate;
uniform int Speed_Percent<
    string label = "Speed Percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 100; 
uniform bool Glitch;
uniform float Distort_X<
    string label = "Distort X";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 1.0;
uniform float Distort_Y<
    string label = "Distort Y";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 1.0;
uniform float Offset_X<
    string label = "Offset X";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;
uniform float Offset_Y<
    string label = "Offset X";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.0;
uniform string notes<
    string widget_type = "info";
>= "Tiles:equilateral: around 12.33,nonequilateral: square rootable number. Distort of 1 is normal.";

float mod(float x, float y)
{
    return x - y * floor(x/y);
}

float2 mod2(float2 x, float2 y)
{
    return x - y * floor(x/y);
}

// 0 on edges, 1 in non_edge
float hex(float2 p) {
	float xyratio = 1;
	if (Equilateral)
		xyratio = uv_size.x /uv_size.y;

	// calc p 
	p.x = mul(p.x,xyratio);
	p.y += mod(floor(p.x) , 2.0)*0.5;
	p = abs((mod2(p , float2(1.0, 1.0)) - 0.5));
	return abs(max(p.x*1.5 + p.y, p.y*2.0) -1);
}

float4 mainImage(VertData v_in) : TARGET
{
	float4 rgba 		= image.Sample(textureSampler, v_in.uv * uv_scale + uv_offset);
	float alpha 		= float(Alpha_Percent) * 0.01;	
	float quantity 		= sqrt(clamp(Quantity, 0.0, 100.0));
	float border_width	= clamp(float(Border_Width - 15), -15, 100) * 0.01;
	float speed 		= float(Speed_Percent) * 0.01;
	float time 		= (1 + sin(elapsed_time * speed))*0.5;
	if (Zoom_Animate)
		quantity 	*= time;

	// create a (pos)ition reference, hex radius and smoothstep out the non_edge
	float2 pos 		= float2(v_in.uv.x * max(0,Distort_X), (1 - v_in.uv.y) * max(0,Distort_Y)) * uv_scale + uv_offset + float2(Offset_X, Offset_Y);
	if (Glitch)
		quantity 	*= lerp(pos.x, pos.y, rand_f);
	float2 p 		= (pos * quantity); // number of hexes to be created
	float  r 		= (1.0 -0.7)*0.5;	// cell default radius
	float non_edge 		= smoothstep(0.0, r + border_width, hex(p)); // approach border become edge

	// make the border colorable - non_edge is scaled
	float4 c = float4(non_edge, non_edge,non_edge,1.0) ;
	if (non_edge < 1)
	{
		c = Hex_Color;
		c.a = alpha;
		if (Blend)
			c = lerp(rgba, c, 1 - non_edge);
		return lerp(rgba,c,alpha);
	}
	return lerp(rgba, c * rgba, alpha);
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

