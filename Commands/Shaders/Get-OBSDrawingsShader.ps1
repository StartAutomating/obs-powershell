function Get-OBSDrawingsShader {

[Alias('Set-OBSDrawingsShader','Add-OBSDrawingsShader')]
param(
# Set the AngleNum of OBSDrawingsShader
[ComponentModel.DefaultBindingProperty('AngleNum')]
[Int32]
$AngleNum,
# Set the SampNum of OBSDrawingsShader
[ComponentModel.DefaultBindingProperty('SampNum')]
[Int32]
$SampNum,
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
$shaderName = 'drawings'
$ShaderNoun = 'OBSDrawingsShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/ldlcWs

uniform int AngleNum<
    string label = "Number of angles";
    string widget_type = "slider";
    int minimum = 0.0;
    int maximum = 25;
    int step = 1;
> = 3;
uniform int SampNum<
    string label = "Number of samples";
    string widget_type = "slider";
    int minimum = 0.0;
    int maximum = 25;
    int step = 1;
> = 9;

float4 getCol(float2 pos)
{
    // take aspect ratio into account
    float2 uv=pos;
    float4 c1=image.Sample(textureSampler, uv);
    float4 e=smoothstep(float4(-0.05,-0.05,-0.05,-0.05),float4(-0.0,-0.0,-0.0,-0.0),float4(uv,float2(1,1)-uv));
    c1=lerp(float4(1,1,1,0),c1,e.x*e.y*e.z*e.w);
    float d=clamp(dot(c1.xyz,float3(-.5,1.,-.5)),0.0,1.0);
    float4 c2=float4(.7,.7,.7,.7);
    return min(lerp(c1,c2,1.8*d),.7);
}

float4 getColHT(float2 pos)
{
 	return smoothstep(0.795,1.05,getCol(pos)*.8+.2+1.0);
}

float getVal(float2 pos)
{
    float4 c=getCol(pos);
 	return pow(dot(c.xyz,float3(.333,.333,.333)),1.)*1.;
}

float2 getGrad(float2 pos, float eps)
{
   	float2 d=float2(eps,0.);
    return float2(
        getVal(pos+d.xy)-getVal(pos-d.xy),
        getVal(pos+d.yx)-getVal(pos-d.yx)
    )/eps/2.;
}


  float lum( float3 c) {
              return dot(c, float3(0.3, 0.59, 0.11));
             }


 float3 clipcolor( float3 c) {
                  float l = lum(c);
                  float n = min(min(c.r, c.g), c.b);
                  float x = max(max(c.r, c.g), c.b);
                
                 if (n < 0.0) {
                     c.r = l + ((c.r - l) * l) / (l - n);
                     c.g = l + ((c.g - l) * l) / (l - n);
                     c.b = l + ((c.b - l) * l) / (l - n);
                 }
                 if (x > 1.25) {
                     c.r = l + ((c.r - l) * (1.0 - l)) / (x - l);
                     c.g = l + ((c.g - l) * (1.0 - l)) / (x - l);
                     c.b = l + ((c.b - l) * (1.0 - l)) / (x - l);
                 }
                 return c;
             }

 float3 setlum( float3 c,  float l) {
                 float d = l - lum(c);
                 c = c + float3(d,d,d);
                 return clipcolor(0.85*c);
 }

float4 mainImage(VertData v_in) : TARGET
{
    float2 pos = v_in.uv;
    float3 col = float3(0,0,0);
    float3 col2 = float3(0,0,0);
    float sum=0.;
    
    for(int i=0;i<AngleNum;i++)
    {
        float ang=6.28318530717959/float(AngleNum)*(float(i)+0.8);
        float2 v=float2(cos(ang),sin(ang));
        for(int j=0;j<SampNum;j++)
        {
            float2 dpos  = v.yx*float2(1,-1)*float(j);
            float2 dpos2 = 5.0*( v.xy*float(j*j)/float(SampNum)*.5);
	        float2 g;
            float fact;
            float fact2;
            float s=3.5;

            float2 pos2=pos+s*dpos+dpos2;
            
            g=getGrad(pos2,0.08);
            fact=dot(g,v)-.5*abs(dot(g,v.yx*float2(1,-1)));
            fact2=dot(normalize(g+float2(.0001,.0001)),v.yx*float2(1,-1));
            
            fact=clamp(fact,0.,.05);
            fact2=abs(fact2);
            
            fact*=1.-float(j)/float(SampNum);
            col += fact;
            col2 += fact2;
            sum+=fact2;
            
        }
    }
    col/=float(SampNum*AngleNum)*0.65;
    col2/=sum;
    col.x*=1.6;
    col.x=1.-col.x;
    col.x*=col.x*col.x;

    float2 s=sin(pos.xy*.1);
    float3 karo=float3(1,1,1);
    karo-=.75755*float3(.25,.1,.1)*dot(exp(-s*s*80.),float2(1.,1.));
    float r=length(pos-float2(0.5,0.5));
    float vign=1.-r*r*r;
	float4 fragColor = float4(float3(col.x*col2*karo*vign ),1);
    float4 origCol = image.Sample(textureSampler, v_in.uv);
    float4 overlayColor = /*float4(0.3755,0.05,0.,0.0)**/origCol;
           
    fragColor = float4( setlum(1.25*overlayColor.rgb, lum(fragColor.rgb)) * 1.0, 1.0);
    fragColor.rgb -= 0.75- clamp (origCol.r + origCol.g + origCol.b , 0.0 , 0.75);
    return fragColor;
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

