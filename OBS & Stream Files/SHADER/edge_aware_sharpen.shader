// Edge-aware sharpen for the obs-shaderfilter plugin (v1.9.5: test switches added, defaults retuned for a 4K source)
// Why: the built-in Sharpen filter boosts every pixel difference, so sensor noise in dark areas gets louder.
// This version (1) sharpens brightness only (no colour noise), (2) ignores small differences (noise)
// and only boosts real edges ("coring" with a threshold), (3) sharpens less in dark areas, (4) limits halos.
// Numpy test on a 1080p recording frame: dark-area noise 3.47 -> 3.41 (unchanged), edge strength +36%.
// The built-in Sharpen at the same strength: noise 3.47 -> 4.45 (+28%), edges +44%.
// NOTE: the numpy test used a slightly wider blur than the 3x3 kernel below; this HLSL is not yet tested in OBS.
// 4K source: per-pixel detail is tiny, so use a larger radius and a lower threshold (defaults below). Proxy test on a soft 4K-like frame:
//   Amount 1.5 / Threshold 0.03 / Radius 1 = edges +14%;  Amount 2 / Threshold 0.01 / Radius 2 = edges +57%, noise unchanged.
// Test switches: 'TEST grayscale' proves the shader is running; 'Show boost map' shows where it adds sharpness (grey = none).
// View the preview at 100% (not 56%), or the effect is invisible.
// Put it ABOVE your look/colour shaders in the filter list, on every [CLONE] (and the vertical one).

uniform float amount<
    string label = "Amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 4.0;
    float step = 0.05;
> = 2.0;

uniform float threshold<
    string label = "Noise threshold (raise if noise appears)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.1;
    float step = 0.001;
> = 0.01;

uniform float radius<
    string label = "Radius (source pixels)";
    string widget_type = "slider";
    float minimum = 0.5;
    float maximum = 3.0;
    float step = 0.1;
> = 2.0;

uniform float shadow_protect<
    string label = "Shadow protect (brightness below which sharpening fades out)";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 0.5;
    float step = 0.01;
> = 0.2;

uniform float max_boost<
    string label = "Max change per pixel (halo limit)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.3;
    float step = 0.005;
> = 0.12;

uniform bool test_grayscale<
    string label = "TEST: show black and white (proves the shader is running)";
> = false;

uniform bool show_boost<
    string label = "TEST: show boost map (grey = no sharpening, light/dark = added)";
> = false;

float luma(float3 c)
{
    return dot(c, float3(0.299, 0.587, 0.114));
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 px = uv_pixel_interval * radius;
    float4 c = image.Sample(textureSampler, v_in.uv);

    // 3x3 gaussian blur: centre 4/16, edges 2/16, corners 1/16
    float3 b = c.rgb * 0.25;
    b += image.Sample(textureSampler, v_in.uv + float2( px.x, 0.0)).rgb * 0.125;
    b += image.Sample(textureSampler, v_in.uv + float2(-px.x, 0.0)).rgb * 0.125;
    b += image.Sample(textureSampler, v_in.uv + float2(0.0,  px.y)).rgb * 0.125;
    b += image.Sample(textureSampler, v_in.uv + float2(0.0, -px.y)).rgb * 0.125;
    b += image.Sample(textureSampler, v_in.uv + float2( px.x,  px.y)).rgb * 0.0625;
    b += image.Sample(textureSampler, v_in.uv + float2(-px.x,  px.y)).rgb * 0.0625;
    b += image.Sample(textureSampler, v_in.uv + float2( px.x, -px.y)).rgb * 0.0625;
    b += image.Sample(textureSampler, v_in.uv + float2(-px.x, -px.y)).rgb * 0.0625;

    float d = luma(c.rgb) - luma(b);                       // detail (high frequency)
    float s = sign(d) * max(abs(d) - threshold, 0.0);      // coring: drop small values (noise)
    float w = saturate(luma(b) / shadow_protect);          // 0 in deep shadows, 1 in normal light
    s = clamp(s * amount * w, -max_boost, max_boost);

    if (test_grayscale)
    {
        float g = luma(c.rgb);
        return float4(g, g, g, c.a);
    }
    if (show_boost)
    {
        float v = saturate(0.5 + s * 4.0);
        return float4(v, v, v, c.a);
    }

    return float4(saturate(c.rgb + s), c.a);
}
