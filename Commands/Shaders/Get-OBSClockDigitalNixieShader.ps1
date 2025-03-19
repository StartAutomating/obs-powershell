function Get-OBSClockDigitalNixieShader {

[Alias('Set-OBSClockDigitalNixieShader','Add-OBSClockDigitalNixieShader')]
param(
# Set the current_time_ms of OBSClockDigitalNixieShader
[Alias('current_time_ms')]
[ComponentModel.DefaultBindingProperty('current_time_ms')]
[Int32]
$CurrentTimeMs,
# Set the current_time_sec of OBSClockDigitalNixieShader
[Alias('current_time_sec')]
[ComponentModel.DefaultBindingProperty('current_time_sec')]
[Int32]
$CurrentTimeSec,
# Set the current_time_min of OBSClockDigitalNixieShader
[Alias('current_time_min')]
[ComponentModel.DefaultBindingProperty('current_time_min')]
[Int32]
$CurrentTimeMin,
# Set the current_time_hour of OBSClockDigitalNixieShader
[Alias('current_time_hour')]
[ComponentModel.DefaultBindingProperty('current_time_hour')]
[Int32]
$CurrentTimeHour,
# Set the timeMode of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('timeMode')]
[Int32]
$TimeMode,
# Set the offsetHours of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('offsetHours')]
[Int32]
$OffsetHours,
# Set the offsetSeconds of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('offsetSeconds')]
[Int32]
$OffsetSeconds,
# Set the corecolor of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('corecolor')]
[Single[]]
$Corecolor,
# Set the halocolor of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('halocolor')]
[Single[]]
$Halocolor,
# Set the flarecolor of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('flarecolor')]
[Single[]]
$Flarecolor,
# Set the anodecolor of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('anodecolor')]
[Single[]]
$Anodecolor,
# Set the anodehighlightscolor of OBSClockDigitalNixieShader
[ComponentModel.DefaultBindingProperty('anodehighlightscolor')]
[Single[]]
$Anodehighlightscolor,
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
$shaderName = 'clock_digital_nixie'
$ShaderNoun = 'OBSClockDigitalNixieShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/fsBcRm
uniform int current_time_ms;
uniform int current_time_sec;
uniform int current_time_min;
uniform int current_time_hour;
uniform int timeMode<
  string label = "Time mode";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "Time";
  int    option_1_value = 1;
  string option_1_label = "Enable duration";
  int    option_2_value = 2;
  string option_2_label = "Active duration";
  int    option_3_value = 3;
  string option_3_label = "Show duration";
  int    option_4_value = 4;
  string option_4_label = "Load duration";
> = 0;

uniform int offsetHours = 0;
uniform int offsetSeconds = 0;

// Colors as named variables, if you want to tweak them
uniform float3 corecolor = {1.0,0.7,0.0};
uniform float3 halocolor = {1.0,0.5,0.0};
uniform float3 flarecolor = {1.0,0.3,0.0};
uniform float3 anodecolor = {0.2,0.1,0.1};
uniform float3 anodehighlightscolor = {1.0,0.5,0.0};

#ifndef OPENGL
#define mod(x,y) (x - y * floor(x / y))
#define lessThan(a,b) (a < b)
#define greaterThan(a,b) (a > b)
#endif

// psrdnoise (c) Stefan Gustavson and Ian McEwan,
// ver. 2021-12-02, published under the MIT license:
// https://github.com/stegu/psrdnoise/
float psrdnoise(float2 x, float2 period, float alpha, out float2 gradient)
{
	float2 uv = float2(x.x+x.y*0.5, x.y);
	float2 i0 = floor(uv), f0 = frac(uv);
	float cmp = step(f0.y, f0.x);
	float2 o1 = float2(cmp, 1.0-cmp);
	float2 i1 = i0 + o1, i2 = i0 + 1.0;
	float2 v0 = float2(i0.x - i0.y*0.5, i0.y);
	float2 v1 = float2(v0.x + o1.x - o1.y*0.5, v0.y + o1.y);
	float2 v2 = float2(v0.x + 0.5, v0.y + 1.0);
	float2 x0 = x - v0, x1 = x - v1, x2 = x - v2;
	float3 iu, iv, xw, yw;
	if(any(greaterThan(period, float2(0.0,0.0)))) {
		xw = float3(v0.x, v1.x, v2.x);
		yw = float3(v0.y, v1.y, v2.y);
		if(period.x > 0.0)
			xw = mod(float3(v0.x, v1.x, v2.x), period.x);
		if(period.y > 0.0)
			yw = mod(float3(v0.y, v1.y, v2.y), period.y);
		iu = floor(xw + 0.5*yw + 0.5); iv = floor(yw + 0.5);
	} else {
		iu = float3(i0.x, i1.x, i2.x); iv = float3(i0.y, i1.y, i2.y);
	}
	float3 hash = mod(iu, 289.0);
	hash = mod((hash*51.0 + 2.0)*hash + iv, 289.0);
	hash = mod((hash*34.0 + 10.0)*hash, 289.0);
	float3 psi = hash*0.07482 + alpha;
	float3 gx = cos(psi); float3 gy = sin(psi);
	float2 g0 = float2(gx.x, gy.x);
	float2 g1 = float2(gx.y, gy.y);
	float2 g2 = float2(gx.z, gy.z);
	float3 w = 0.8 - float3(dot(x0, x0), dot(x1, x1), dot(x2, x2));
	w = max(w, 0.0); float3 w2 = w*w; float3 w4 = w2*w2;
	float3 gdotx = float3(dot(g0, x0), dot(g1, x1), dot(g2, x2));
	float n = dot(w4, gdotx);
	float3 w3 = w2*w; float3 dw = -8.0*w3*gdotx;
	float2 dn0 = w4.x*g0 + dw.x*x0;
	float2 dn1 = w4.y*g1 + dw.y*x1;
	float2 dn2 = w4.z*g2 + dw.z*x2;
	gradient = 10.9*(dn0 + dn1 + dn2);
	return 10.9*n;
}

// Compute the shortest distance from p
// to a line segment from p1 to p2.
float lined(float2 p1, float2 p2, float2 p) {
    float2 p1p2 = p2 - p1;
    float2 v = normalize(p1p2);
    float2 s = p - p1;
    float t = dot(v, s);
    if (t<0.0) return length(s);
    if (t>length(p1p2)) return length(p - p2);
    return length(s - t*v);
}

// Compute the shortest distance from p to a circle
// with center at c and radius r. (Extremely simple.)
float circled(float2 c, float r, float2 p) {
    return abs(length(p - c) - r);
}

// Compute the shortest distance from p to a
// circular arc with center c from p1 to p2.
// p1, p2 are in the +angle direction (ccw),
// to resolve the major/minor arc ambiguity, so
// specifying p1, p2 in the wrong order will
// yield the complement to the arc you wanted.
// If p1 = p2, the entire circle is drawn, but
// you don''t want to use this function to draw
// a circle. Use the simple circled() instead.
// If p1 and p2 have different distances to c,
// the end of the arc will not look right. If
// this is inconvenient, uncomment the 3rd line.
float arcd(float2 c, float2 p1, float2 p2, float2 p) {

    float2 v1 = p1 - c;
    float2 v2 = p2 - c;
    // Optional: make sure p1, p2 are both on the circle
    // v2 = normalize(v2)*length(v1);
    float2 v = p - c;

    float2 w = float2(dot(v, -float2(-v1.y, v1.x)), dot(v, float2(-v2.y, v2.x)));

    if(dot(v1, float2(-v2.y, v2.x)) >= 0.0) { // Arc angle <= pi
        if(all(lessThan(float2(0.0,0.0), w))) {
            return min(length(p1-p), length(p2-p)); // nearest end
        } else {
            return abs(length(v) - length(v1)); // dist to arc
        }
    } else { // Arc angle > pi
        if(any(lessThan(float2(0.0,0.0), w))) {
            return min(length(p1-p), length(p2-p));
        } else {
            return abs(length(v) - length(v1));
        }
    }
}

// A convenient anti-aliased step() using auto derivatives
float aastep(float threshold, float value) {
    float afwidth = 0.7 * length(float2(ddx(value), ddy(value)));
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

// A smoothstep() that blends to an aastep() under minification
float aasmoothstep(float t1, float t2, float v) {
	float aw = 0.7 * length(float2(ddx(v), ddy(v)));
	float sw = max(0.5*(t2-t1), aw);
	float st = 0.5*(t1+t2);
	return smoothstep(st-sw, st+sw, v);
}

// Distance field of a hexagonal (simplex) grid
// The return vector contains the distances to the
// three closest points, sorted by magnitude.
float3 hexgrid(float2 p) {

    const float stretch = 1.0/0.8660;
	
    //  v.y = v.y + 0.0001; // needed if no stretching (rounding errors)
    p.y = p.y * stretch;
    // Transform to grid space (axis-aligned "simplex" grid)
    float2 uv = float2(p.x + p.y*0.5, p.y);
    // Determine which simplex we''re in, with i0 being the "base"
    float2 i0 = floor(uv);
    float2 f0 = frac(uv);
    // o1 is the offset in simplex space to the second corner
    float cmp = step(f0.y, f0.x);
    float2 o1 = float2(cmp, 1.0-cmp);
    // Enumerate the remaining simplex corners
    float2 i1 = i0 + o1;
    float2 i2 = i0 + float2(1.0, 1.0);
    // Transform corners back to texture space
    float2 p0 = float2(i0.x - i0.y * 0.5, i0.y);
    float2 p1 = float2(p0.x + o1.x - o1.y * 0.5, p0.y + o1.y);
    float2 p2 = float2(p0.x + 0.5, p0.y + 1.0);
    float3 d = float3(length(p-p0), length(p-p1), length(p-p2));
    // Only three values - bubble sort is just fine.
    d.yz = (d.y < d.z) ? d.yz : d.zy;
    d.xy = (d.x < d.y) ? d.xy : d.yx;
    d.yz = (d.y < d.z) ? d.yz : d.zy;
    return d;
}

// The digits. Simple functions, only a lot of them.

// These glyphs and their implementation as distance fields
// are the original work of me (stefan.gustavson@gmail.com),
// and the code below is released under the MIT license:
// https://opensource.org/licenses/MIT
// (If that is inconvenient for you, let me know. I''m reasonable.)
//
// Experts say mortals should not attempt to design character shapes.
// "It''s just ten simple digits", I thought, "How hard can it be?"
// A week later, after countless little tweaks to proportions and
// curvature, and with a notepad full of sketches and pen-and-paper
// math, some of it horribly wrong because it was decades since I
// solved this kind of equations by hand, I know the answer:
// It can be *really* hard. But also loads of fun!
//
float nixie0(float2 p) {
    // Special hack instead of pasting together arcs and lines
    float d = lined(float2(2.0,2.0), float2(2.0, 6.0), p);
    return abs(d - 2.0);
}

float nixie1(float2 p) {
    float d1 = lined(float2(2.0, 0.0), float2(2.0, 8.0), p);
    float d2 = lined(float2(2.0, 8.0), float2(1.0, 6.0), p);
    return min(d1, d2);
}

float nixie1alt(float2 p) { // Straight line
    return lined(float2(2.0, 0.0), float2(2.0, 8.0), p);
}

float nixie2(float2 p) {
    const float x = 3.2368345; // Icky coordinates,
    const float y = 4.4283002; // used twice below
    float d1 = lined(float2(4.25, 0.0), float2(-0.25, 0.0), p);
    float d2 = arcd(float2(10.657842, -5.001899), // Also icky
                    float2(x, y), float2(-0.25, 0.0), p);
    float d3 = arcd(float2(2.0, 6.0), float2(x, y), float2(0.0, 6.0), p);
    return min(min(d1, d2), d3);
}

float nixie2alt(float2 p) { // Straight neck
    float d1 = lined(float2(4.0, 0.0), float2(0.0,0.0), p);
    float d2 = lined(float2(0.0,0.0), float2(3.6, 4.8), p);
    float d3 = arcd(float2(2.0, 6.0), float2(3.6, 4.8), float2(0.0, 6.0), p);
    return min(min(d1, d2), d3);
}

float nixie3(float2 p) {
    // Two round parts:
    // float d1 = arcd(float2(2.0, 2.1), float2(-0.1, 2.1), float2(2.0, 4.2), p);
    // float d2 = arcd(float2(2.0, 6.1), float2(2.0, 4.2), float2(0.1, 6.1), p);
    // Angled top, more like classic Nixie tube digits:
    float d1 = arcd(float2(2.0, 2.25), float2(-0.25, 2.25), float2(2.0, 4.5), p);
    float d2 = lined(float2(2.0, 4.5), float2(4.0, 7.75), p);
    float d3 = lined(float2(4.0, 7.75), float2(0.0, 7.75), p);
    return min(min(d1, d2), d3);
}

float nixie3alt(float2 p) { // Two round parts of the same size
    float d1 = arcd(float2(2.0,2.0), float2(0.0, 2.0), float2(2.0, 4.0), p);
    float d2 = arcd(float2(2.0, 6.0), float2(2.0, 4.0), float2(0.0, 6.0), p);
    return min(d1, d2);
}

float nixie4(float2 p) {
    // This digit is 5.0 units wide, most others are 4.0 or 4.5
    float d1 = lined(float2(4.0, 0.0), float2(4.0, 8.0), p);
    float d2 = lined(float2(4.0, 8.0), float2(0.0, 2.0), p);
    float d3 = lined(float2(0.0, 2.0), float2(5.0, 2.0), p);
    return min(min(d1, d2), d3);
}

float nixie4alt(float2 p) {
    // This digit is 4.0 units wide, but looks cropped
    float d1 = lined(float2(4.0, 0.0), float2(4.0, 8.0), p);
    float d2 = lined(float2(4.0, 8.0), float2(0.0, 2.0), p);
    float d3 = lined(float2(0.0, 2.0), float2(4.0, 2.0), p);
    return min(min(d1, d2), d3);
}

float nixie5(float2 p) {
    float d1 = lined(float2(4.0, 7.75), float2(0.5, 7.75), p);
    float d2 = lined(float2(0.5, 7.75), float2(0.0, 4.5), p);
    float d3 = lined(float2(0.0, 4.5), float2(2.0, 4.5), p);
    float d4 = arcd(float2(2.0, 2.25), float2(-0.25, 2.25), float2(2.0, 4.5), p);
    return min(min(d1, d2), min(d3, d4));
}

float nixie5alt(float2 p) {
    float d1 = lined(float2(4.0, 8.0), float2(0.0, 8.0), p);
    float d2 = lined(float2(0.0, 8.0), float2(0.0, 5.0), p);
    float d3 = lined(float2(0.0, 5.0), float2(2.0, 5.0), p);
    float d4 = arcd(float2(2.0, 3.0), float2(4.0, 3.0), float2(2.0, 5.0), p);
    float d5 = lined(float2(4.0, 3.0), float2(4.0, 2.0), p);
    float d6 = arcd(float2(2.0,2.0), float2(0.0, 2.0), float2(4.0, 2.0), p);
    return min(min(min(d1, d2), min(d3, d4)), min(d5, d6));
}

float nixie6(float2 p) {
    float d1 = arcd(float2(84.0/13.0, 2.25), float2(3.0, 8.0), float2(-0.25, 2.25), p);
    float d2 = circled(float2(2.0, 2.25), 2.25, p);
    return min(d1, d2);
}

float nixie6alt(float2 p) { // Straight neck
    float d1 = lined(float2(0.4, 3.2), float2(3.0, 8.0), p);
    float d2 = circled(float2(2.0,2.0), 2.0, p);
    return min(d1, d2);
}

float nixie7(float2 p) { // Ugly coordinates, but these expressions are exact
    float d1 = lined(float2(0.0, 7.75), float2(0.25*sqrt(2259.0)-8.0, 7.75), p);
    float d2 = arcd(float2(-8.0, 12.0), float2(2.5, 5.0), float2(0.25*sqrt(2259.0)-8.0, 7.75), p);
    float d3 = arcd(float2(10.0, 0.0), float2(2.5, 5.0), float2(10.0-2.5*sqrt(13.0), 0.0), p);
    return min(min(d1, d2), d3);
}

float nixie7alt(float2 p) { // Straight neck
    float d1 = lined(float2(0.0, 8.0), float2(4.0, 8.0), p);
    float d2 = lined(float2(4.0, 8.0), float2(1.0, 0.0), p);
    return min(d1, d2);
}

float nixie8(float2 p) {
    float d1 = circled(float2(2.0, 2.2), 2.2, p);
    float d2 = circled(float2(2.0, 6.2), 1.8, p);
    return min(d1, d2);
}

float nixie8alt(float2 p) { // Same size loops
    float d1 = circled(float2(2.0,2.0), 2.0, p);
    float d2 = circled(float2(2.0, 6.0), 2.0, p);
    return min(d1, d2);
}

float nixie9(float2 p) {
    float d1 = arcd(float2(-32.0/13.0, 5.75), float2(1.0, 0.0), float2(4.25, 5.75), p);
    float d2 = circled(float2(2.0, 5.75), 2.25, p);
    return min(d1, d2);
}

float nixie9alt(float2 p) { // Straight neck
    float d1 = lined(float2(3.6, 4.8), float2(1.0, 0.0), p);
    float d2 = circled(float2(2.0, 6.0), 2.0, p);
    return min(d1, d2);
}

float nixieminus(float2 p) {
    return lined(float2(0.5, 4.0), float2(3.5, 4.0), p);
}

float nixieequals(float2 p) {
    float d1 = lined(float2(0.5, 3.0), float2(3.5, 3.0), p);
    float d2 = lined(float2(0.5, 5.0), float2(3.5, 5.0), p);
    return min(d1, d2);
}

float nixieplus(float2 p) {
    float d1 = lined(float2(0.0, 4.0), float2(4.0, 4.0), p);
    float d2 = lined(float2(2.0, 2.0), float2(2.0, 6.0), p);
    return min(d1, d2);
}

float nixiedot(float2 p) {
    // circled with r=0 yields a point, but with more work
    return length(p - float2(2.0, 0.0));
}

float nixiecolon(float2 p) {
    float d1 = length(p - float2(2.0,2.0));
    float d2 = length(p - float2(2.0, 5.0));
    return min(d1, d2);
}

// End of MIT-licensed code

float number(int n, float2 p) {
    switch(n) {
        case 0: return nixie0(p);
        case 1: return nixie1(p);
        case 2: return nixie2(p);
        case 3: return nixie3(p);
        case 4: return nixie4(p);
        case 5: return nixie5(p);
        case 6: return nixie6(p);
        case 7: return nixie7(p);
        case 8: return nixie8(p);
        case 9: return nixie9(p);
        default: return 1e10;
    }
}
// Display the current time with a retro Nixie-tube look
// Stefan Gustavson (stegu on shadertoy.com) 2022-01-26
// All code in the "Image" tab is public domain.
// Functions in the "Common" tab are also public domain,
// except where a separate license is specified.
float4 mainImage(VertData v_in) : TARGET
{
    float2 uv = ((float2(v_in.uv.x,1.0-v_in.uv.y) * uv_size)/uv_size.x);
    float time = 0.0;
	if(timeMode == 0){
		time = float(current_time_hour*3600+current_time_min*60+current_time_sec) + float(current_time_ms)/1000.0;
	}else if(timeMode == 1){
		time = elapsed_time_enable;
	}else if(timeMode == 2){
		time = elapsed_time_active;
	}else if(timeMode == 3){
		time = elapsed_time_show;
	}else if(timeMode == 4){
		time = elapsed_time_start;
	}
    time += offsetSeconds + offsetHours * 3600;
    if(time < 0)
		time = 0.9999-time;
    float2 p = -3.0+uv*50.0 - float2(0.0,9.0);

    float bbox = 1.0-max(max(1.0-aastep(-3.0, p.x), aastep(47.0, p.x)),
                           max(1.0-aastep(-3.0, p.y), aastep(11.0, p.y)));

    // Some relief for the GPU: exit early if we''re in the black margins
    if(bbox == 0.0) {
        return float4(float3(0.0,0.0,0.0),1.0);
    }
    
    // If not, well, let''s put that GPU to good use!
    float secs = floor(mod(time, 60.0));
    float mins = floor(mod(time, 3600.0)/60.0);
    float hrs = floor(time/3600.0);
    int h10 = int(floor(hrs/10.0));
    int h1 = int(floor(mod(hrs, 10.0)));
    int m10 = int(floor(mins/10.0));
    int m1 = int(floor(mod(mins, 10.0)));
    int s10 = int(floor(secs/10.0));
    int s1 = int(floor(mod(secs, 10.0)));

    float2 wspace = float2(6.5, 0.0);
    float2 nspace = float2(3.5, 0.0);
    float d = 1e10;
    d = min(d, number(h10, p));
    d = min(d, number(h1, p-wspace));
    d = min(d, nixiecolon(p-wspace-1.45*nspace)-0.2);
    d = min(d, number(m10, p-2.0*wspace-nspace));
    d = min(d, number(m1, p-3.0*wspace-nspace));
    d = min(d, nixiecolon(p-3.0*wspace-2.4*nspace)-0.2);
    d = min(d, number(s10, p-4.0*wspace-2.0*nspace));
    d = min(d, number(s1, p-5.0*wspace-2.0*nspace));

    float2 g; // For gradients returned from psrdnoise()

    // Digit outlines
    float core = 1.0-aastep(0.2, d);
    // "flare" is a wide blurry region around the characters, and
    // "flarenoise" is a spatio-temporal modulation of its extents
    // (slight flickering, but not all characters at the same time)
    float flarenoise = psrdnoise(float2(p.x*0.1,5.0*elapsed_time), float2(0.0,0.0), 0.0, g);
    float flare = 1.0-smoothstep(0.0, 2.5, d + 0.05*flarenoise);
    flare *= flare; // A more rapid decline towards the edge
    // "glow" is a variation in the intensity of the glowy cathode (core)
    float glow = 0.8+0.2*psrdnoise(p - float2(0.0, 2.0*elapsed_time), float2(0.0,0.0), 4.0*time, g);
    // Now we mess up the distance field a little for the "halo" effect
    d += 0.1*psrdnoise(p - float2(0.0, 2.0*elapsed_time), float2(0.0,0.0), 8.0*time, g);
    d += 0.05*psrdnoise(2.0*p - float2(0.0, 4.0*elapsed_time) + 0.15*g, float2(0.0,0.0), -16.0*time, g);
    // "halo" is a kind of flame/plasma cloud near the core. A real Nixie tube
    // doesn''t have this, but it adds some appealing visual detail.
    // Looks more like hot filaments than "cold cathodes", but... oh, well.
    float halo = 1.0-smoothstep(-0.3, 0.3, d);

    // Brittle parameters! This scale/shift of p has a strong impact
    // on the pattern at the edges of the grid through "anodefade".
    float3 anodedists = hexgrid(1.7*p+float2(0.1,0.23));
    float anodedist = anodedists.y - anodedists.x; // Voronoi cell borders
    // Fade the hexagonal holes in the anode towards the edges
    float anodefade = max(max(1.0-aasmoothstep(-2.2, -1.5, p.x), aasmoothstep(45.5, 46.2, p.x)),
                          max(1.0-aasmoothstep(-2.0, -1.6, p.y), aasmoothstep(9.4, 10.0, p.y)));
    float anode = 1.0 - aastep(0.1, anodedist - anodefade);

    float anodecolornoise = 0.02*psrdnoise(p*float2(0.2,2.0), float2(0.0,0.0), 0.0, g);
    float3 anodecolorresult = anodecolor+ anodecolornoise*anodehighlightscolor; // Long variable names, I know

    float3 mixcolor = float3(0.0,0.0,0.0); // Mix additively from black
    mixcolor = lerp(mixcolor, flarecolor, 0.5*flare);
    mixcolor = lerp(mixcolor, halocolor, 0.9*halo);
    mixcolor = lerp(mixcolor, corecolor, core*glow);
    mixcolor = lerp(mixcolor, anodecolorresult, anode);
    mixcolor *= bbox; // AA-mask to black at the very edge of the bounding box
    return  float4(mixcolor,1.0);
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

