function Get-OBSBackgroundRemovalShader {

[Alias('Set-OBSBackgroundRemovalShader','Add-OBSBackgroundRemovalShader')]
param(
# Set the ViewProj of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSBackgroundRemovalShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSBackgroundRemovalShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSBackgroundRemovalShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSBackgroundRemovalShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSBackgroundRemovalShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSBackgroundRemovalShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the notes of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the target of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('target')]
[String]
$Target,
# Set the color of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('color')]
[String]
$Color,
# Set the opacity of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('opacity')]
[Single]
$Opacity,
# Set the invert of OBSBackgroundRemovalShader
[ComponentModel.DefaultBindingProperty('invert')]
[Management.Automation.SwitchParameter]
$Invert,
# Set the Convert_709to601 of OBSBackgroundRemovalShader
[Alias('Convert_709to601')]
[ComponentModel.DefaultBindingProperty('Convert_709to601')]
[Management.Automation.SwitchParameter]
$Convert709to601,
# Set the Convert_601to709 of OBSBackgroundRemovalShader
[Alias('Convert_601to709')]
[ComponentModel.DefaultBindingProperty('Convert_601to709')]
[Management.Automation.SwitchParameter]
$Convert601to709,
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
$shaderName = 'background_removal'
$ShaderNoun = 'OBSBackgroundRemovalShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// background removal effect By Charles Fettinger (https://github.com/Oncorporation)  4/2019
//Converted to OpenGL by Exeldro February 19, 2022
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;
uniform string notes = "Opacity between 10 and 20 works. Adjust `Color` from white to fix environmental changes.\r\r\nUsage:\r\n1) Disable `Auto` settings like focus, white balance, etc.\r\n2) Take a video of just the background. \r\n3) Take a frame and use it as the background image. Windows Snipping Tool (%windir%\\system32\\SnippingTool.exe). \r\r\nThis eliminates differences based upon camera/video settings.";

uniform texture2d target;
uniform float4 color;
uniform float opacity = 15.0;
uniform bool invert;
uniform bool Convert_709to601;
uniform bool Convert_601to709;


sampler_state textureSampler {
	Filter    = Linear;
	AddressU  = Clamp;
	AddressV  = Clamp;
};

struct VertDataIn {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

struct VertDataOut {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
	float2 uv2 : TEXCOORD1;
};

float dot(float3 a,float3 b){
	return a.x*b.x+a.y*b.y+a.z*b.z;
}

//BT.601 to BT.709
// Correct video colorspace BT.601 [SD] to BT.709 [HD] for HD video input
// Use this shader only if BT.709 [HD] encoded video is incorrectly matrixed to full range RGB with the BT.601 [SD] colorspace.
float4 Convert601to709(float4 rgba)
{
	float3 s1 = rgba.rgb;
	s1 = s1.rrr * float3(0.299, -0.1495 / 0.886, 0.5) + s1.ggg * float3(0.587, -0.2935 / 0.886, -0.2935 / 0.701) + s1.bbb * float3(0.114, 0.5, -0.057 / 0.701); // RGB to Y''CbCr, BT.601 [SD] colorspace
	return (s1.rrr + float3(0, -0.1674679 / 0.894, 1.8556) * s1.ggg + float3(1.5748, -0.4185031 / 0.894, 0) * s1.bbb).rgbb; // Y''CbCr to RGB output, BT.709 [HD] colorspace
}

//BT.709 to BT.601
float4 Convert709to601(float4 rgba)
{
	float3 s1 = rgba.rgb;
	s1 = float3(dot(float3(.2126, .7152, .0722), s1), dot(float3(-.1063 / .9278, -.3576 / .9278, .5), s1), dot(float3(.5, -.3576 / .7874, -.0361 / .7874), s1));
	return float3(s1.x + 1.402*s1.z, dot(s1, float3(1, -.202008 / .587, -.419198 / .587)), s1.x + 1.772*s1.y).rgbb;
}

VertDataOut VSDefault(VertDataIn v_in)
{
	VertDataOut vert_out;
	vert_out.pos = mul(float4(v_in.pos.x, v_in.pos.y, v_in.pos.z, 1.0), ViewProj);
	vert_out.uv  = v_in.uv;
	vert_out.uv2 = v_in.uv * uv_scale + uv_offset;
	return vert_out;
}

float4 PSColorMaskRGBA(VertDataOut v_in) : TARGET
{
	float Tolerance = opacity * 0.01;
	float4 rgba = image.Sample(textureSampler, v_in.uv);

	float4 targetRGB = target.Sample(textureSampler, v_in.uv2) * color;
	if (invert){
		targetRGB.rgb = 1.0 - targetRGB.rgb;
	}
	if (Convert_709to601)
	{
		rgba.rgb = Convert709to601(rgba).rgb;
		targetRGB.rgb = Convert709to601(targetRGB).rgb;
	}

	if (Convert_601to709)
	{
		rgba.rgb = Convert601to709(rgba).rgb;
		targetRGB.rbg = Convert601to709(targetRGB).rgb;
	}	

	float4 shadowRGB = targetRGB * targetRGB;

	if ((abs(targetRGB.r - rgba.r) <= Tolerance &&
		abs(targetRGB.g - rgba.g) <= Tolerance &&
		abs(targetRGB.b - rgba.b) <= Tolerance)
		|| (abs(shadowRGB.r - rgba.r) <= Tolerance &&
			abs(shadowRGB.g - rgba.g) <= Tolerance &&
			abs(shadowRGB.b - rgba.b) <= Tolerance))
	{
		rgba.rgba = float4(0,0,0,0);
	}
	return rgba;
}

technique Draw
{
	pass
	{
		vertex_shader = VSDefault(v_in);
		pixel_shader  = PSColorMaskRGBA(v_in);
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

