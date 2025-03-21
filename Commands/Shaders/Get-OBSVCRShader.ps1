function Get-OBSVCRShader {

[Alias('Set-OBSVCRShader','Add-OBSVCRShader')]
param(
# Set the vertical_shift of OBSVCRShader
[Alias('vertical_shift')]
[ComponentModel.DefaultBindingProperty('vertical_shift')]
[Single]
$VerticalShift,
# Set the distort of OBSVCRShader
[ComponentModel.DefaultBindingProperty('distort')]
[Single]
$Distort,
# Set the vignet of OBSVCRShader
[ComponentModel.DefaultBindingProperty('vignet')]
[Single]
$Vignet,
# Set the stripe of OBSVCRShader
[ComponentModel.DefaultBindingProperty('stripe')]
[Single]
$Stripe,
# Set the vertical_factor of OBSVCRShader
[Alias('vertical_factor')]
[ComponentModel.DefaultBindingProperty('vertical_factor')]
[Single]
$VerticalFactor,
# Set the vertical_height of OBSVCRShader
[Alias('vertical_height')]
[ComponentModel.DefaultBindingProperty('vertical_height')]
[Single]
$VerticalHeight,
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
$shaderName = 'VCR'
$ShaderNoun = 'OBSVCRShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/ldjGzV
//Converted to OpenGL by Exeldro February 19, 2022
uniform float vertical_shift<
    string label = "vertical shift";
    string widget_type = "slider";
    float minimum = -5.0;
    float maximum = 5.0;
    float step = 0.001;
> = 0.4;
uniform float distort<
    string label = "distort";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 5.0;
    float step = 0.001;
> = 1.2;
uniform float vignet<
    string label = "vignet";
    string widget_type = "slider";
    float minimum = -5.0;
    float maximum = 5.0;
    float step = 0.001;
> = 1.0;
uniform float stripe<
    string label = "stripe";
    string widget_type = "slider";
    float minimum = -5.0;
    float maximum = 5.0;
    float step = 0.001;
> = 1.0;
uniform float vertical_factor<
    string label = "vertical factor";
    string widget_type = "slider";
    float minimum = -5.0;
    float maximum = 5.0;
    float step = 0.001;
> = 1.0;
uniform float vertical_height<
    string label = "vertical height";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1000.0;
    float step = 0.1;
> = 30.0;

float onOff(float a, float b, float c)
{
	return step(c, sin(elapsed_time + a*cos(elapsed_time*b)));
}

float ramp(float y, float start, float end)
{
	float inside = step(start,y) - step(end,y);
	float fact = (y-start)/(end-start)*inside;
	return (1.-fact) * inside;
	
}

float modu(float x, float y)
{
	return (x / y) - floor(x / y);
}

float stripes(float2 uv)
{
	return ramp(modu(uv.y*4. + elapsed_time/2.+sin(elapsed_time + sin(elapsed_time*0.63)),1.),0.5,0.6)*stripe;
}

float4 getVideo(float2 uv)
{
	float2 look = uv;
	float window = 1./(1.+20.*(look.y-modu(elapsed_time/4.,1.))*(look.y-modu(elapsed_time/4.,1.)));
	look.x = look.x + sin(look.y*10. + elapsed_time)/50.*onOff(4.,4.,.3)*(1.+cos(elapsed_time*80.))*window;
	float vShift = vertical_shift*onOff(2.,3.,.9)*(sin(elapsed_time)*sin(elapsed_time*20.) + 
										 (0.5 + 0.1*sin(elapsed_time*200.)*cos(elapsed_time)));
	look.y = modu((look.y + vShift) , 1.);
    return image.Sample(textureSampler, look);
}

float2 screenDistort(float2 uv)
{
	uv -= float2(.5,.5);
	uv = uv*distort*(1./1.2+2.*uv.x*uv.x*uv.y*uv.y);
	uv += float2(.5,.5);
	return uv;
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 uv = v_in.uv;
    uv = screenDistort(uv);
	float4 video = getVideo(uv);
    float vigAmt = 3.+.3*sin(elapsed_time + 5.*cos(elapsed_time*5.));
	float vignette = ((1.-vigAmt*(uv.y-.5)*(uv.y-.5))*(1.-vigAmt*(uv.x-.5)*(uv.x-.5))-1.)*vignet+1.;
    video += stripes(uv);
    video *= vignette;
	video *= (((12.+modu((uv.y*vertical_height+elapsed_time),1.))/13.)-1.)*vertical_factor+1.;
    return float4(video.r, video.g, video.b ,1.0);
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

