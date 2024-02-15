function Get-OBSRotatoeShader {

[Alias('Set-OBSRotatoeShader','Add-OBSRotatoeShader')]
param(
# Set the ViewProj of OBSRotatoeShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSRotatoeShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSRotatoeShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSRotatoeShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSRotatoeShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSRotatoeShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSRotatoeShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSRotatoeShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the speed_percent of OBSRotatoeShader
[Alias('speed_percent')]
[ComponentModel.DefaultBindingProperty('speed_percent')]
[Int32]
$SpeedPercent,
# Set the Axis_X of OBSRotatoeShader
[Alias('Axis_X')]
[ComponentModel.DefaultBindingProperty('Axis_X')]
[Single]
$AxisX,
# Set the Axis_Y of OBSRotatoeShader
[Alias('Axis_Y')]
[ComponentModel.DefaultBindingProperty('Axis_Y')]
[Single]
$AxisY,
# Set the Axis_Z of OBSRotatoeShader
[Alias('Axis_Z')]
[ComponentModel.DefaultBindingProperty('Axis_Z')]
[Single]
$AxisZ,
# Set the Angle_Degrees of OBSRotatoeShader
[Alias('Angle_Degrees')]
[ComponentModel.DefaultBindingProperty('Angle_Degrees')]
[Single]
$AngleDegrees,
# Set the Rotate_Transform of OBSRotatoeShader
[Alias('Rotate_Transform')]
[ComponentModel.DefaultBindingProperty('Rotate_Transform')]
[Management.Automation.SwitchParameter]
$RotateTransform,
# Set the Rotate_Pixels of OBSRotatoeShader
[Alias('Rotate_Pixels')]
[ComponentModel.DefaultBindingProperty('Rotate_Pixels')]
[Management.Automation.SwitchParameter]
$RotatePixels,
# Set the Rotate_Colors of OBSRotatoeShader
[Alias('Rotate_Colors')]
[ComponentModel.DefaultBindingProperty('Rotate_Colors')]
[Management.Automation.SwitchParameter]
$RotateColors,
# Set the center_width_percentage of OBSRotatoeShader
[Alias('center_width_percentage')]
[ComponentModel.DefaultBindingProperty('center_width_percentage')]
[Int32]
$CenterWidthPercentage,
# Set the center_height_percentage of OBSRotatoeShader
[Alias('center_height_percentage')]
[ComponentModel.DefaultBindingProperty('center_height_percentage')]
[Int32]
$CenterHeightPercentage,
# Set the notes of OBSRotatoeShader
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
$shaderName = 'rotatoe'
$ShaderNoun = 'OBSRotatoeShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Rotation Effect By Charles Fettinger (https://github.com/Oncorporation)  10/2019
//Converted to OpenGL by Q-mii, Exeldro, & skeletonbow
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;

uniform int speed_percent<
    string label = "speed percentage";
    string widget_type = "slider";
    int minimum = -100;
    int maximum = 100;
    int step = 1;
> = 50; //<Range(-10.0, 10.0)>
uniform float Axis_X<
    string label = "Axis X";
    string widget_type = "slider";
    float minimum = -2.0;
    float maximum = 2.0;
    float step = 0.1;
> = 0.0;
uniform float Axis_Y<
    string label = "Axis Y";
    string widget_type = "slider";
    float minimum = -2.0;
    float maximum = 2.0;
    float step = 0.01;
> = 0.0;
uniform float Axis_Z<
    string label = "Axis Z";
    string widget_type = "slider";
    float minimum = -2.0;
    float maximum = 2.0;
    float step = 0.01;
> = 1.0;
uniform float Angle_Degrees<
    string label = "Angle Degrees";
    string widget_type = "slider";
    float minimum = -180.0;
    float maximum = 180.0;
    float step = 0.01;
> = 45.0;
uniform bool Rotate_Transform = true;
uniform bool Rotate_Pixels = false;
uniform bool Rotate_Colors = false;
uniform int center_width_percentage<
    string label = "center width percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform int center_height_percentage<
    string label = "center height percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;

uniform string notes<
    string widget_type = "info";
> = " Choose axis, angle and speed, then rotate away! center_width_percentage & center_height_percentage allow you to change the pixel spin axis";

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

float3x3 rotAxis(float3 axis, float a) {
	float s=sin(a);
	float c=cos(a);
	float oc=1.0-c;

	float3 as=axis*s;

	float3x3 p=float3x3(axis.x*axis,axis.y*axis,axis.z*axis);
	float3x3 q=float3x3(c,-as.z,as.y,as.z,c,-as.x,-as.y,as.x,c);
	return p*oc+q;
}

VertData mainTransform(VertData v_in)
{
	VertData vert_out;
	vert_out.pos =  mul(float4(v_in.pos.xyz, 1.0), ViewProj);

	float speed = speed_percent * 0.01;
	// circular easing variable
	float PI = 3.1415926535897932384626433832795; //acos(-1);
	float PI180th = 0.0174532925; //PI divided by 180
	float direction = abs(sin((elapsed_time - 0.001) * speed));	
	float t = sin(elapsed_time * speed);
	float angle_degrees = PI180th * Angle_Degrees;

	// use matrix to transform rotation
	if (Rotate_Transform)
		vert_out.pos.xyz = mul(vert_out.pos.xyz,rotAxis(float3(Axis_X,Axis_Y,Axis_Z), (angle_degrees * t))).xyz;

	vert_out.uv  = v_in.uv * uv_scale + uv_offset;

	return vert_out;
}

float4 mainImage(VertData v_in) : TARGET
{
	float4 rgba = image.Sample(textureSampler, v_in.uv);
	
	float speed = speed_percent * 0.01;
	// circular easing variable
	float PI = 3.1415926535897932384626433832795; //acos(-1);
	float PI180th = 0.0174532925; //PI divided by 180
	float direction = abs(sin((elapsed_time - 0.001) * speed));	
	float t = sin(elapsed_time * speed);
	float angle_degrees = PI180th * Angle_Degrees;


	// use matrix to transform pixels
	if (Rotate_Pixels)
	{
		float2 center_pixel_coordinates = float2((center_width_percentage * 0.01), (center_height_percentage * 0.01) );
		rgba = image.Sample(textureSampler, mul(float3(v_in.uv - center_pixel_coordinates, 1.0), rotAxis(float3(Axis_X ,Axis_Y, Axis_Z ), (angle_degrees * t))).xy + center_pixel_coordinates);
	}
	if (Rotate_Colors)
		rgba.rgb = mul(rgba.rgb, rotAxis(float3(Axis_X,Axis_Y,Axis_Z), (angle_degrees * t))).xyz;

	return rgba;
}

technique Draw
{
	pass
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader  = mainImage(v_in);
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

