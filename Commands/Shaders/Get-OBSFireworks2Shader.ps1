function Get-OBSFireworks2Shader {

[Alias('Set-OBSFireworks2Shader','Add-OBSFireworks2Shader')]
param(
# Set the Speed of OBSFireworks2Shader
[ComponentModel.DefaultBindingProperty('Speed')]
[Single]
$Speed,
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
$shaderName = 'fireworks2'
$ShaderNoun = 'OBSFireworks2Shader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// based on https://www.shadertoy.com/view/4dBGRw

uniform float Speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 200.0;
    float step = 1.0;
> = 100.0;

#ifndef OPENGL
#define mat2 float2x2
#define mix lerp
float mod(float x, float y)
{
		return x - y * floor(x / y);
}
#endif
//Creates a diagonal red-and-white striped pattern.
float3 barberpole(float2 pos, float2 rocketpos){
	float d = (pos.x-rocketpos.x)+(pos.y-rocketpos.y);
	float3 col=float3(1.0,1.0,1.0);	

	d = mod(d*20.,2.0);
	if(d>1.0){
		col=float3(1.0,0.0,0.0);
	}
	return col;	
}

float4 rocket(float2 pos, float2 rocketpos){
	float4 col = float4(0.0,0.0,0.0,0.0);
	float f = 0.;
	float absx= abs(rocketpos.x - pos.x);
	float absy = abs(rocketpos.y-pos.y);
	//wooden stick
	if(absx<0.01&&absy<0.22){
		col=float4(1.0,0.5,0.5,1.0);	
	}
	
	//Barberpole
	
	if(absx<0.05&&absy<0.15){
		col=float4(barberpole(pos, rocketpos),1.0);	
	}
	//Rocket Point
	float pointw=(rocketpos.y-pos.y-0.25)*-0.7;
	if((rocketpos.y-pos.y)>0.1){
		f=smoothstep(pointw-0.001,pointw+0.001,absx);
		
		col=mix(float4(1.0,0.0,0.0,1.0),col, f);	
	}
	//Shadow
	
	f =-.5 + smoothstep(-0.05, 0.05, (rocketpos.x-pos.x));
	col.rgb *= 0.7+f;
	
	return col;
}



float rand(float val, float seed){
	return cos(val*sin(val*seed)*seed);	
}

float distance2( in float2 a, in float2 b ) { return dot(a-b,a-b); }



float4 drawParticles(float2 pos, float3 particolor, float time, float2 cpos, float gravity, float seed, float timelength){
    float4 col= float4(0.0,0.0,0.0,0.0);
    float2 pp = float2(1.0,0.0);
    mat2 rr = mat2( cos(1.0), -sin(1.0), sin(1.0), cos(1.0) );
    for(float i=1.0;i<=128.0;i++){
        float d=rand(i, seed);
        float fade=(i/128.0)*time;
        float2 particpos = cpos + time*pp*d;
        pp = mul(rr,pp);
        col.rgb = mix(particolor/fade, col, smoothstep(0.0, 0.0001, distance2(particpos, pos)));
    }
    col.rgb*=smoothstep(0.0,1.0,(timelength-time)/timelength);
	col.a = col.r+col.g+col.b;
    return col;
}
float4 drawFireworks(float time, float2 uv, float3 particolor, float seed){
	
	float timeoffset = 2.0;
	float4 col=float4(0.0,0.0,0.0,0.0);
	if(time<=0.){
		return col;	
	}
    time *= Speed /100.0;
	if(mod(time, 6.0)>timeoffset){
	    col= drawParticles(uv, particolor, mod(time, 6.0)-timeoffset, float2(rand(ceil(time/6.0),seed),-0.5), 0.5, ceil(time/6.0), seed);
	}else{
		
		col= rocket(uv*3., float2(3.*rand(ceil(time/6.0),seed),3.*(-0.5+(timeoffset-mod(time, 6.0)))));	
	}
	return col;	
}

float4 mainImage(VertData v_in) : TARGET
{
	float2 uv =float2(1.0,1.0) -  2.0* v_in.uv;
	uv.y = -uv.y;
	uv.x *= uv_size.x/uv_size.y;
	float4 col = image.Sample(textureSampler, v_in.uv);
	//col.rgb += 0.1*uv.y;
	float4 c;
    c = drawFireworks(elapsed_time    , uv,float3(1.0,0.1,0.1), 1.);
	col = mix(col, c, c.a);
	c = drawFireworks(elapsed_time-2.0, uv,float3(0.0,1.0,0.5), 2.);
    col = mix(col, c, c.a);
	c = drawFireworks(elapsed_time-4.0, uv,float3(1.0,1.0,0.1), 3.);
    col = mix(col, c, c.a);
	
	return  col;
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

