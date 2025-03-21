// Simple Reflect Shader

// Reflects horizontally and/or vertically.

uniform bool Horizontal<
    string label = "Reflect horizontally";
> = false;
uniform bool Vertical<
    string label = "Reflect vertically";
> = true;

uniform int center_x_percent<
    string label = "center x percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform int center_y_percent<
    string label = "center y percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;


float4 mainImage(VertData v_in) : TARGET
{
    float2 pos = v_in.uv;
    float2 center_pos = float2(center_x_percent * .01, center_y_percent * .01);
    
    if (Horizontal == true) {
        if (pos.x < center_pos.x) {
            pos.x = center_pos.x - pos.x;
        } else if (pos.x == center_pos.x) {
            pos.x = pos.x;
        }  else {
            pos.x = pos.x - center_pos.x;
        }
    }
    if (Vertical == true) {
        if (pos.y < center_pos.y) {            
            pos.y = center_pos.y - pos.y;
        } else if (pos.y == center_pos.y) {
            pos.y = pos.y;
        }  else {
            pos.y = pos.y - center_pos.y;
        }
    }
    
    return image.Sample(textureSampler, pos);
}