function Get-OBSInvertLumaShader {

[Alias('Set-OBSInvertLumaShader','Add-OBSInvertLumaShader')]
param(
# Set the Invert_Color of OBSInvertLumaShader
[Alias('Invert_Color')]
[ComponentModel.DefaultBindingProperty('Invert_Color')]
[Management.Automation.SwitchParameter]
$InvertColor,
# Set the Invert_Luma of OBSInvertLumaShader
[Alias('Invert_Luma')]
[ComponentModel.DefaultBindingProperty('Invert_Luma')]
[Management.Automation.SwitchParameter]
$InvertLuma,
# Set the Gamma_Correction of OBSInvertLumaShader
[Alias('Gamma_Correction')]
[ComponentModel.DefaultBindingProperty('Gamma_Correction')]
[Management.Automation.SwitchParameter]
$GammaCorrection,
# Set the Test_Ramp of OBSInvertLumaShader
[Alias('Test_Ramp')]
[ComponentModel.DefaultBindingProperty('Test_Ramp')]
[Management.Automation.SwitchParameter]
$TestRamp,
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
$shaderName = 'invert-luma'
$ShaderNoun = 'OBSInvertLumaShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Invert shader 1.0 - for OBS Shaderfilter
// Copyright 2021 by SkeletonBow
// https://twitter.com/skeletonbowtv
// https://twitch.tv/skeletonbowtv

// Performs RGB color inversion or YUV luma inversion with optional sRGB gamma handling

uniform bool Invert_Color = false;
uniform bool Invert_Luma = true;
uniform bool Gamma_Correction = true;
uniform bool Test_Ramp = false;

float3 encodeSRGB(float3 linearRGB)
{
    float3 a = float3(12.92,12.92,12.92) * linearRGB;
    float3 b = float3(1.055,1.055,1.055) * pow(linearRGB, float3(1.0 / 2.4,1.0 / 2.4,1.0 / 2.4)) - float3(0.055,0.055,0.055);
    float3 c = step(float3(0.0031308,0.0031308,0.0031308), linearRGB);
    return float3(lerp(a, b, c));
}

float3 decodeSRGB(float3 screenRGB)
{
    float3 a = screenRGB / float3(12.92,12.92,12.92);
    float3 b = pow((screenRGB + float3(0.055,0.055,0.055)) / float3(1.055,1.055,1.055), float3(2.4,2.4,2.4));
    float3 c = step(float3(0.04045,0.04045,0.04045), screenRGB);
    return float3(lerp(a, b, c));
}

float3 HUEtoRGB(in float H)
{
	float R = abs(H * 6 - 3) - 1;
	float G = 2 - abs(H * 6 - 2);
	float B = 2 - abs(H * 6 - 4);
	return float3(clamp(float3(R,G,B), float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0)));
}

float3 RGBtoYUV(float3 color)
{
	// YUV matriz (BT709 luma coefficients)
#ifdef OPENGL
        float3x3 toYUV = float3x3(
			float3(0.2126, -0.09991,  0.615),
			float3(0.7152, -0.33609, -0.55861),
			float3(0.0722,  0.436,   -0.05639));
#else
        float3x3 toYUV = {
		{  0.2126, -0.09991,  0.615  },
		{  0.7152, -0.33609, -0.55861 },
		{  0.0722,  0.436,   -0.05639 },
	};
#endif
	return mul(color, toYUV);
}

float3 YUVtoRGB(float3 color)
{
	// YUV matriz (BT709)
#ifdef OPENGL
        float3x3 fromYUV = float3x3(
			float3(1.000,    1.000,   1.000),
			float3(0.0,     -0.21482, 2.12798),
			float3(1.28033, -0.38059, 0.0));
#else
	float3x3 fromYUV = { 
		{ 1.000,    1.000,   1.000 },
		{ 0.0,     -0.21482, 2.12798 },
		{ 1.28033, -0.38059, 0.0 },
	};
#endif
	return mul(color, fromYUV);
}

float3 generate_ramps(float3 color, float2 uv)
{
	float3 ramp = float3(0.0, 0.0, 0.0);
	if(uv.y < 0.2)
		ramp.r = uv.x;			// Red ramp
	else if(uv.y < 0.4)
		ramp.g = uv.x;			// Green ramp
	else if(uv.y < 0.6)
		ramp.b = uv.x;			// Blue ramp
	else if(uv.y < 0.8)
		ramp = float3(uv.x, uv.x, uv.x);			// Grey ramp
	else
		ramp = HUEtoRGB(uv.x);	// Hue rainbow
	
	return ramp;
}

float4 mainImage( VertData v_in ) : TARGET
{
	float2 uv = v_in.uv;
	float4 obstex = image.Sample( textureSampler, uv );
	float3 color = obstex.rgb;
	// Apply sRGB gamma transfer encode
	if(Gamma_Correction) color = encodeSRGB( color );
	// Override display with test patterns to visually see what is happening
	if( Test_Ramp )	color = generate_ramps( obstex.rgb, uv );
	// RGB color invert	
	if( Invert_Color ) {
		color = float3(1.0, 1.0, 1.0) - color;
	}
	// YUV luma invert
	if( Invert_Luma ) {
		float3 yuv = RGBtoYUV( color );
		yuv.x = 1.0 - yuv.x;
		color = YUVtoRGB(yuv);
	}
	// Apply sRGB gamma transfer decode
	if(Gamma_Correction) color = decodeSRGB( color );
	return float4(color, obstex.a);
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

