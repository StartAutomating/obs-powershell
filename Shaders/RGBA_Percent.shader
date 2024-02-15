// Simple RGBA Percent Shader
// Allows Red, Green, or Blue to be adjusted between 0-200%
// Allows Alpha to be adjusted between 0/100%
uniform float RedPercent<
    string label = "Red percentage";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 200;
    float step = 1.0;
> = 100;

uniform float GreenPercent<
    string label = "Green percentage";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 200;
    float step = 1.0;
> = 100;

uniform float BluePercent<
    string label = "Blue percentage";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 200;
    float step = 1.0;
> = 100.0;


uniform float AlphaPercent<
    string label = "Alpha percentage";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 1.0;
> = 100.0;

float4 mainImage(VertData v_in) : TARGET
{
    float2 pos = v_in.uv;                
    
    float4 imageColors = image.Sample(textureSampler, v_in.uv);
    float4 adjustedColor = float4(
        imageColors.r * (RedPercent * 0.01), 
        imageColors.g * (GreenPercent * 0.01), 
        imageColors.b * (BluePercent * 0.01), 
        imageColors.a * (AlphaPercent * 0.01)
    );
    return adjustedColor;
}
