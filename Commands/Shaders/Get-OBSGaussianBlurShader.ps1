function Get-OBSGaussianBlurShader {

[Alias('Set-OBSGaussianBlurShader','Add-OBSGaussianBlurShader')]
param(
# Set the ViewProj of OBSGaussianBlurShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSGaussianBlurShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the imageSize of OBSGaussianBlurShader
[ComponentModel.DefaultBindingProperty('imageSize')]
[Single[]]
$ImageSize,
# Set the imageTexel of OBSGaussianBlurShader
[ComponentModel.DefaultBindingProperty('imageTexel')]
[Single[]]
$ImageTexel,
# Set the u_radius of OBSGaussianBlurShader
[Alias('u_radius')]
[ComponentModel.DefaultBindingProperty('u_radius')]
[Int32]
$URadius,
# Set the u_diameter of OBSGaussianBlurShader
[Alias('u_diameter')]
[ComponentModel.DefaultBindingProperty('u_diameter')]
[Int32]
$UDiameter,
# Set the u_texelDelta of OBSGaussianBlurShader
[Alias('u_texelDelta')]
[ComponentModel.DefaultBindingProperty('u_texelDelta')]
[Single[]]
$UTexelDelta,
# Set the elapsed_time of OBSGaussianBlurShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSGaussianBlurShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSGaussianBlurShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSGaussianBlurShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the kernel of OBSGaussianBlurShader
[ComponentModel.DefaultBindingProperty('kernel')]
[String]
$Kernel,
# Set the kernelTexel of OBSGaussianBlurShader
[ComponentModel.DefaultBindingProperty('kernelTexel')]
[Single[]]
$KernelTexel,
# Set the pixel_size of OBSGaussianBlurShader
[Alias('pixel_size')]
[ComponentModel.DefaultBindingProperty('pixel_size')]
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
$shaderName = 'gaussian-blur'
$ShaderNoun = 'OBSGaussianBlurShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Q-mii & Exeldro March 11, 2022
// OBS Default
uniform float4x4 ViewProj;

// Settings (Shared)
uniform texture2d image;
uniform float2 imageSize;
uniform float2 imageTexel;
uniform int u_radius;
uniform int u_diameter;
uniform float2 u_texelDelta;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;

// Settings (Private)
//uniform float registerkernel[25];
uniform texture2d kernel;
uniform float2 kernelTexel;
uniform float pixel_size = 1.0;

sampler_state pointClampSampler {
	Filter    = Point;
	AddressU  = Clamp;
	AddressV  = Clamp;
};

sampler_state bilinearClampSampler {
	Filter    = Bilinear;
	AddressU  = Clamp;
	AddressV  = Clamp;
};

struct VertData {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

float Gaussian(float x, float o)
{
	float pivalue = 3.1415926535897932384626433832795;
	return (1.0 / (o * sqrt(2.0 * pivalue))) * exp((-(x * x)) / (2.0 * (o * o)));
}

VertData VSDefault(VertData vert_in)
{
	VertData vert_out;
	vert_out.pos = mul(float4(vert_in.pos.xyz, 1.0), ViewProj);
	vert_out.uv  = vert_in.uv;
	return vert_out;
}

float4 InternalGaussian(float2 p_uv, float2 p_uvStep, int p_radius,
  texture2d p_image, float2 p_imageTexel)
  {    
	float l_gauss = Gaussian(0.0, 1.0);
	float4 l_value = image.Sample(pointClampSampler, p_uv) * l_gauss;
	float2 l_uvoffset = float2(0, 0);
	for (int k = 1; k <= p_radius; k++) {
		l_uvoffset += p_uvStep;
        float l_g = Gaussian(float(k), uv_pixel_interval.x + uv_pixel_interval.y);
		float4 l_p = image.Sample(pointClampSampler, p_uv + l_uvoffset) * l_g;
		float4 l_n = image.Sample(pointClampSampler, p_uv - l_uvoffset) * l_g;
		l_value += l_p + l_n;
		l_gauss += l_g;
	}
	l_value = l_value * (1.0 / l_gauss);
	return l_value;
}

float4 InternalGaussianPrecalculated(float2 p_uv, float2 p_uvStep, int p_radius,
  texture2d p_image, float2 p_imageTexel,
  texture2d p_kernel, float2 p_kernelTexel)
  {
	float4 l_value = image.Sample(pointClampSampler, p_uv)
		* kernel.Sample(pointClampSampler, float2(0, 0)).r;
	float2 l_uvoffset = float2(0, 0);
	for (int k = 1; k <= p_radius; k++) {
		l_uvoffset += p_uvStep;
		float l_g = kernel.Sample(pointClampSampler, p_kernelTexel * k).r;
		float4 l_p = image.Sample(pointClampSampler, p_uv + l_uvoffset) * l_g;
		float4 l_n = image.Sample(pointClampSampler, p_uv - l_uvoffset) * l_g;
		l_value += l_p + l_n;
	}
	return l_value;
}

/*float4 InternalGaussianPrecalculatedNVOptimized(float2 p_uv, int pixel_size,
  texture2d p_image, float2 p_imageTexel,
  texture2d p_kernel, float2 p_kernelTexel)
  {
	if (pixel_size % 2 == 0) {
		float4 l_value = image.Sample(pointClampSampler, p_uv)
			* kernel.Sample(pointClampSampler, float2(0, 0)).r;
		float2 l_uvoffset = p_texel;
		float2 l_koffset = p_kernelTexel;
		for (int k = 1; k <= pixel_size; k++) {
			float l_g = kernel.Sample(pointClampSampler, l_koffset).r;
			float4 l_p = image.Sample(pointClampSampler, p_uv + l_uvoffset) * l_g;
			float4 l_n = image.Sample(pointClampSampler, p_uv - l_uvoffset) * l_g;
			l_value += l_p + l_n;
			l_uvoffset += p_texel;
			l_koffset += p_kernelTexel;
		}
		return l_value;
	} else {
		return InternalGaussianPrecalculated(p_uv, p_image, p_texel, pixel_size, p_kernel, p_kerneltexel);)
	}
}*/

float4 PSGaussian(VertData vert_in) : TARGET 
{
	
	float4 color = image.Sample(pointClampSampler, vert_in.uv);

	float intensity = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;

	return InternalGaussian(vert_in.uv, uv_offset, int(sqrt((uv_pixel_interval.x * uv_pixel_interval.x) + (uv_pixel_interval.y * uv_pixel_interval.y))), image, uv_scale);

	/*
	return InternalGaussianPrecalculated(
		vert_in.uv, u_texelDelta, u_radius,
		image, imageTexel,
		kernel, kernelTexel);
	*/

	/*
	return InternalGaussianPrecalculatedNVOptimize(
		vert_in.uv, u_texelDelta, u_radius,
		image, imageTexel,
		kernel, kernelTexel);
	*/
}

technique Draw
{
	pass
	{
		vertex_shader = VSDefault(vert_in);
		pixel_shader  = PSGaussian(vert_in);
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

