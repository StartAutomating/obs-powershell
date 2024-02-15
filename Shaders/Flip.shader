// A Simple Flip Shader

uniform bool Horizontal<
    string label = "Flip horizontally";
> = true;
uniform bool Vertical<
    string label = "Flip vertically";
> = true;

float4 mainImage(VertData v_in) : TARGET
{
    float2 pos = v_in.uv;
    if (Horizontal == true) {
        pos.x = 1 - pos.x;
    }
    if (Vertical == true) {
        pos.y = 1 - pos.y;
    }
    
    return image.Sample(textureSampler, pos);
}
