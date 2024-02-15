function Get-OBSMatrixShader {

[Alias('Set-OBSMatrixShader','Add-OBSMatrixShader')]
param(
# Set the ViewProj of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSMatrixShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSMatrixShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSMatrixShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_size of OBSMatrixShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the uv_pixel_interval of OBSMatrixShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSMatrixShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the rand_instance_f of OBSMatrixShader
[Alias('rand_instance_f')]
[ComponentModel.DefaultBindingProperty('rand_instance_f')]
[Single]
$RandInstanceF,
# Set the rand_activation_f of OBSMatrixShader
[Alias('rand_activation_f')]
[ComponentModel.DefaultBindingProperty('rand_activation_f')]
[Single]
$RandActivationF,
# Set the loops of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('loops')]
[Int32]
$Loops,
# Set the local_time of OBSMatrixShader
[Alias('local_time')]
[ComponentModel.DefaultBindingProperty('local_time')]
[Single]
$LocalTime,
# Set the mouse of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('mouse')]
[Single[]]
$Mouse,
# Set the Invert_Direction of OBSMatrixShader
[Alias('Invert_Direction')]
[ComponentModel.DefaultBindingProperty('Invert_Direction')]
[Management.Automation.SwitchParameter]
$InvertDirection,
# Set the lumaMin of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('lumaMin')]
[Single]
$LumaMin,
# Set the lumaMinSmooth of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('lumaMinSmooth')]
[Single]
$LumaMinSmooth,
# Set the Ratio of OBSMatrixShader
[ComponentModel.DefaultBindingProperty('Ratio')]
[Single]
$Ratio,
# Set the Alpha_Percentage of OBSMatrixShader
[Alias('Alpha_Percentage')]
[ComponentModel.DefaultBindingProperty('Alpha_Percentage')]
[Single]
$AlphaPercentage,
# Set the Apply_To_Alpha_Layer of OBSMatrixShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
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
$shaderName = 'matrix'
$ShaderNoun = 'OBSMatrixShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Matrix effect by Charles Fettinger for obs-shaderfilter plugin 7/2020 v.2
// https://github.com/Oncorporation/obs-shaderfilter
// https://www.shadertoy.com/view/XljBW3  The cat is a glitch (Matrix) - coverted from and updated

#define vec2 float2
#define vec3 float3
#define vec4 float4
#define ivec2 int2
#define ivec3 int3
#define ivec4 int4
#define mat2 float2x2
#define mat3 float3x3
#define mat4 float4x4
#define fract frac
#define mix lerp
#define iTime float

uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_size;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float rand_instance_f;
uniform float rand_activation_f;
uniform int loops;
uniform float local_time;


uniform float2 mouse<
	string label = "Virtual Mouse Coordinates";
	string widget_type = "slider";
	float2 minimum = {0, 0};
	float2 maximum = {100., 100.};
	float2 scale = {.01, .01};
	float2 step = {.01, .01};
> = {0., 0.};


int2 iMouse() {
	return int2(mouse.x * uv_size.x, mouse.y * uv_size.y);
}

sampler_state textureSampler {
	Filter    = Linear;
	AddressU  = Clamp;
	AddressV  = Clamp;
};

/* ps start

*/

uniform bool Invert_Direction<
	string label = "Invert Direction";
> = true;

uniform float lumaMin<
    string label = "Luma Min";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.01;
uniform float lumaMinSmooth<
    string label = "Luma Min Smooth";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.01;
uniform float Ratio<
    string label = "Ratio";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 4.0;
uniform float Alpha_Percentage<
    string label = "Alpha Percentage";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 100; //<Range(0.0,100.0)>
uniform bool Apply_To_Alpha_Layer = true;

#define PI2 6.28318530718
#define PI 3.1416


float vorocloud(float2 p){
	float f = 0.0;
	float flow = 1.0;
	float time = elapsed_time;
	if(Invert_Direction){
		flow *= -1;
	}
	/*
	//periodically stop
	if (loops % 16 >= 8.0)
	{
		time = local_time - elapsed_time;
	}
	*/
		
	float r = clamp(Ratio,-50,50);
    float2 pp = cos(float2(p.x * 14.0, (16.0 * p.y + cos(floor(p.x * 30.0)) + flow * time * PI2)) );
    p = cos(p * 12.1 + pp * r + sin(time/PI)*(r/PI) + 0.5 * cos(pp.x * r + sin(time/PI)*(r/PI)));
    
    float2 pts[4];    
    
    pts[0] = float2(0.5, 0.6);
    pts[1] = float2(-0.4, 0.4);
    pts[2] = float2(0.2, -0.7);
    pts[3] = float2(-0.3, -0.4);
    
    float d = 5.0;
    
    for(int i = 0; i < 4; i++){
      	pts[i].x += 0.03 * cos(float(i)) + p.x;
      	pts[i].y += 0.03 * sin(float(i)) + p.y;
    	d = min(d, distance(pts[i], pp));
    }
    
    f = 2.0 * pow(1.0 - 0.3 * d, 13.0);
    
    f = min(f, 1.0);
    
	return f;
}

vec4 scene(float2 UV){
	float alpha = clamp(Alpha_Percentage *.01 ,0,1.0);

	float x = UV.x;
	float y = UV.y;
    
	float2 p = float2(x, y) - 0.5;
    
	vec4 col = vec4(0.0,0.0,0.0,0.0);
	col.g += 0.02;
    
	float v = vorocloud(p);
	v = 0.2 * floor(v * 5.0);
    
	col.r += 0.1 * v;
	col.g += 0.6 * v;
	col.b += 0.5 * pow(v, 5.0);
    
    
	v = vorocloud(p * 2.0);
	v = 0.2 * floor(v * 5.0);
    
	col.r += 0.1 * v;
	col.g += 0.2 * v;
	col.b += 0.01 * pow(v, 5.0);
    
	col.a = 1.0;
	float luma = dot(col.rgb,float3(0.299,0.587,0.114));
	float luma_min = smoothstep(lumaMin, lumaMin + lumaMinSmooth, luma);
	col.a = clamp(luma_min,0.0,1.0);

	float4 original_color = image.Sample(textureSampler, UV);
	
	// skip if (alpha is zero and only apply to alpha layer is true) 
	if (!(original_color.a <= 0.0 && Apply_To_Alpha_Layer == true))
	{
		if (Apply_To_Alpha_Layer == false)
			original_color.a = alpha;
		
		col.rgb = lerp(original_color.rgb, col.rgb, alpha); //apply alpha slider
		col = lerp(original_color, col, col.a); //remove black background color
	}
	else
	{
		col.a = original_color.a;
	}

	return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / uv_size;
	fragColor = scene(uv);
}

/*ps end*/

struct VertFragData {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

VertFragData VSDefault(VertFragData vtx) {
	vtx.pos = mul(float4(vtx.pos.xyz, 1.0), ViewProj);
	return vtx;
}

float4 PSDefault(VertFragData vtx) : TARGET {
	float4 col = float4(1., 1., 1., 1.);
	mainImage(col, vtx.uv * uv_size);
	return col;
}

technique Draw 
{
	pass
	{
		vertex_shader = VSDefault(vtx);
		pixel_shader  = PSDefault(vtx); 
	}
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

