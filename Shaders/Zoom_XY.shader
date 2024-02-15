// Zoom XY Shader

// A simple twist on the Zoom Shader in https://github.com/exeldro/obs-shaderfilter/

// The allow for an independent Horizontal and Vertical Zoom.

uniform int center_x_percent<
    string label = "center x percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform int center_y_percent<
    string label = "center y percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform float x_power<
    string label = "x power";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 20.0;
    float step = 0.001;
> = 1;

uniform float y_power<
    string label = "y power";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 20.0;
    float step = 0.001;
> = 1;

float4 mainImage(VertData v_in) : TARGET
{
    float2 center_pos = float2(center_x_percent * .01, center_y_percent * .01);
    float2 uv = v_in.uv;
    uv.x = (v_in.uv.x - center_pos.x) * x_power +  center_pos.x;
    uv.y = (v_in.uv.y - center_pos.y) * y_power +  center_pos.y;
    return image.Sample(textureSampler, uv);
}