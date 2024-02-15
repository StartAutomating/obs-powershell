function Get-OBSGaussianExampleShader {

[Alias('Set-OBSGaussianExampleShader','Add-OBSGaussianExampleShader')]
param(
# Set the ViewProj of OBSGaussianExampleShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSGaussianExampleShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSGaussianExampleShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSGaussianExampleShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSGaussianExampleShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_size of OBSGaussianExampleShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the uv_pixel_interval of OBSGaussianExampleShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the initial_image of OBSGaussianExampleShader
[Alias('initial_image')]
[ComponentModel.DefaultBindingProperty('initial_image')]
[String]
$InitialImage,
# Set the before_image of OBSGaussianExampleShader
[Alias('before_image')]
[ComponentModel.DefaultBindingProperty('before_image')]
[String]
$BeforeImage,
# Set the after_image of OBSGaussianExampleShader
[Alias('after_image')]
[ComponentModel.DefaultBindingProperty('after_image')]
[String]
$AfterImage,
# Set the text_color of OBSGaussianExampleShader
[Alias('text_color')]
[ComponentModel.DefaultBindingProperty('text_color')]
[String]
$TextColor,
# Set the max_distance of OBSGaussianExampleShader
[Alias('max_distance')]
[ComponentModel.DefaultBindingProperty('max_distance')]
[Single]
$MaxDistance,
# Set the exp of OBSGaussianExampleShader
[ComponentModel.DefaultBindingProperty('exp')]
[Single]
$Exp,
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
$shaderName = 'gaussian-example'
$ShaderNoun = 'OBSGaussianExampleShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_size;
uniform float2 uv_pixel_interval;

/*-------------------------.
| :: Texture and sampler:: |
''-------------------------*/


uniform texture2d initial_image;
sampler_state initial_sampler 
{
	Filter    = Linear;
	AddressU  = Border;
	AddressV  = Border;
	BorderColor = 00000000;
	texture2d  = initial_image;
};

uniform texture2d before_image;
sampler_state before_sampler {
	Filter    = Linear;
	AddressU  = Border;
	AddressV  = Border;
	BorderColor = 00000000;
	texture2d  = before_image;
};

uniform texture2d after_image;
sampler_state after_sampler {
	Filter    = Linear;
	AddressU  = Border;
	AddressV  = Border;
	BorderColor = 00000000;
	texture2d  = after_image;
};

sampler_state textureSampler {
	Filter    = Linear;
	AddressU  = Border;
	AddressV  = Border;
	BorderColor = 00000000;
};

struct VertData {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

struct ColorData {
	float4 initial_color : SV_TARGET0;
	float4 before_color: SV_TARGET1;
	float4 after_color : SV_TARGET2;
};

uniform float4 text_color;
uniform float max_distance;
uniform float exp;

#define PI 3.141592653589793238462643383279502884197169399375105820974

VertData mainTransform(VertData v_in)
{
	VertData vert_out = v_in;
	vert_out.pos = mul(float4(v_in.pos.xyz, 1.0), ViewProj);
	vert_out.uv = v_in.uv * uv_scale + uv_offset;
	return vert_out;
}

float4 grayscale(float4 color)
{
	float grayscale = color.r * 0.3 + color.g * 0.59 + color.b * 0.11;
	return float4(grayscale, grayscale, grayscale, color.a);
}

float4 gaussian(VertData v_in, float angle)
{
	float rad = radians(angle);
	float2 dir = float2(sin(rad), cos(rad)) * (uv_pixel_interval * max_distance);
	float2 dir_2 = dir * 2.0;
	float4 ret = image.Sample(textureSampler, v_in.uv) * 0.375;
	
	float4 px_away = image.Sample(textureSampler, v_in.uv + dir);
	px_away += image.Sample(textureSampler, v_in.uv - dir);
	px_away *= 0.25;
	
	float4 px_2_away = image.Sample(textureSampler, v_in.uv + dir_2);
	px_2_away += image.Sample(textureSampler, v_in.uv + dir_2);
	px_2_away *= 0.0625;
	
	return ret + px_away + px_2_away;
}

ColorData setColorData(VertData v_in): SV_TARGET0
{
	//string RenderTarget0 = "initial_image";
	ColorData cd;// = (ColorData)0;
	cd.initial_color = image.Sample(textureSampler, v_in.uv);
	cd.before_color = float4(0.0,0.0,1.0,1.0);
	cd.after_color = float4(1.0,0.0,0.0,1.0);
	return cd;
}

float4 blurImageH(VertData v_in) : SV_TARGET1
{
	//string RenderTarget1 = "before_image";	
	//ColorData cd = (ColorData)0;
	//cd.initial_color = image.Sample(textureSampler, v_in.uv);
	//cd.before_color = float4(0.0,0.0,1.0,1.0);//gaussian(v_in, 0); 
	return float4(0.0,0.0,1.0,1.0);
}

float4 blurImageV(VertData v_in) : SV_TARGET2
{
	//string RenderTarget2 = "after_image";
	//ColorData cd = (ColorData)0;
	//cd.after_color = 	float4(1.0,0.0,0.0,1.0); //gaussian(v_in, 90); 
	return float4(1.0,0.0,0.0,1.0);
}

float4 mainImage(VertData v_in) : SV_TARGET0
{	
	float4 color;
	ColorData cd;// = (ColorData)0;
	
	//cd.initial_color = initial_image.Sample(initial_sampler, v_in.uv);
	//cd.before_color = before_image.Sample(before_sampler, v_in.uv);
	cd.after_color = after_image.Sample(before_sampler, v_in.uv);
	
	if (max_distance <= 5) {
		color = cd.before_color;
	}
	else {
		color = cd.after_color;//image.Sample(textureSampler, v_in.uv);
	}

	float4 gray = grayscale(color);
	float4 gray_text = grayscale(text_color);
	float d = distance(gray.rgb, gray_text.rgb);
	if (d <= dot(max_distance, uv_pixel_interval.x * max_distance)){
		float d_c = pow(d*2, exp) / pow(2, exp);
		d_c = sin(d_c * PI / 2);
		d = pow(1.0 - sin(d * PI/4), exp);

		color.rgb = float3(d,d,d);
	}

	return color;
}

technique Draw
{	
	pass pre
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader = setColorData(v_in);
	}	

	pass b0 
	{		
		vertex_shader = mainTransform(v_in);
		pixel_shader = blurImageH(v_in);
	}

	pass b1 	
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader = blurImageV(v_in);
	}

	pass p0
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader = mainImage(v_in);
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

