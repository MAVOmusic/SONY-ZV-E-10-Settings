// MAVO Manga Edges HORIZONTAL (PC) - look 2/25 "Animate Me" (v1.14.0)
// Replaces edge_detection.shader (Sobel, hard binary threshold at
// Sensitivity 0.05). That shader's problems on our 4K source: single-
// pixel Sobel with a hard on/off threshold turns sensor noise and CD-
// cover texture into dense speckle, and the always-on Sharpen in front
// of it makes that worse. This version treats it as manga line art:
//   1. Luma is pre-blurred (3x3 gaussian, mixable) BEFORE edges are
//      measured, so 1-pixel noise dies but real outlines survive.
//   2. Gradient is measured at a 2-pixel distance (line_distance):
//      lines are drawn from real contours, not pixel grain.
//   3. SOFT edge mapping instead of the binary switch: gradient is
//      ramped from Threshold to Threshold+Softness, so lines are
//      anti-aliased white on black, thin where weak, solid where
//      strong, with far less speckle between.
// Output: edge colour (white) on a black sheet, alpha preserved.
// Measured simulation (Image Files/JPG/Shaders/Animate Me -
// Simulation.jpg): edge coverage 21.5% vs the old binary 29.8% on the
// same frame - same story told with about a quarter less ink, and the
// flat-dark speckle drops with it. If a line you want is missing,
// lower Threshold by 0.01; if speckle returns, raise it by 0.01.
// The vertical file has Threshold 0.065 / Softness 0.15 because the
// vertical crop upscale enlarges noise along with the lines.

uniform float3 edge_color<
    string label = "Edge colour";
    string widget_type = "color";
> = {1.0, 1.0, 1.0};

uniform float threshold_edge<
    string label = "Threshold (gradient below this is black; lower = more lines)";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 0.3;
    float step = 0.005;
> = 0.05;

uniform float softness_edge<
    string label = "Softness (gradient range up to solid white)";
    string widget_type = "slider";
    float minimum = 0.02;
    float maximum = 0.4;
    float step = 0.005;
> = 0.13;

uniform float line_distance<
    string label = "Line distance (pixels the gradient spans; higher = bolder/smoother lines)";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 3.0;
    float step = 0.5;
> = 2.0;

uniform float pre_blur<
    string label = "Pre-blur amount (noise killer before edge detection)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 1.0;

float luma601(float3 c)
{
    return dot(c, float3(0.299, 0.587, 0.114));
}

float blurred_luma(float2 uv)
{
    float2 px = uv_pixel_interval;
    float b = luma601(image.Sample(textureSampler, uv).rgb) * 0.25;
    b += luma601(image.Sample(textureSampler, uv + float2( px.x, 0.0)).rgb) * 0.125;
    b += luma601(image.Sample(textureSampler, uv + float2(-px.x, 0.0)).rgb) * 0.125;
    b += luma601(image.Sample(textureSampler, uv + float2(0.0,  px.y)).rgb) * 0.125;
    b += luma601(image.Sample(textureSampler, uv + float2(0.0, -px.y)).rgb) * 0.125;
    b += luma601(image.Sample(textureSampler, uv + float2( px.x,  px.y)).rgb) * 0.0625;
    b += luma601(image.Sample(textureSampler, uv + float2(-px.x,  px.y)).rgb) * 0.0625;
    b += luma601(image.Sample(textureSampler, uv + float2( px.x, -px.y)).rgb) * 0.0625;
    b += luma601(image.Sample(textureSampler, uv + float2(-px.x, -px.y)).rgb) * 0.0625;
    return lerp(luma601(image.Sample(textureSampler, uv).rgb), b, pre_blur);
}

float4 mainImage(VertData v_in) : TARGET
{
    float4 src = image.Sample(textureSampler, v_in.uv);
    float2 d = uv_pixel_interval * line_distance;
    float gx = blurred_luma(v_in.uv + float2(d.x, 0.0)) - blurred_luma(v_in.uv - float2(d.x, 0.0));
    float gy = blurred_luma(v_in.uv + float2(0.0, d.y)) - blurred_luma(v_in.uv - float2(0.0, d.y));
    float g = sqrt(gx * gx + gy * gy);
    float e = smoothstep(threshold_edge, threshold_edge + softness_edge, g);
    return float4(edge_color * e, src.a);
}
