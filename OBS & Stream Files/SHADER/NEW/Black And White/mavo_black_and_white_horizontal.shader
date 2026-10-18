// MAVO Black and White HORIZONTAL (PC) for obs-shaderfilter (v1.12.0 - FINAL, defaults = horizontal preset)
// v1.11.2: user test of the v1 presets measured DARKER on the face than
// the old saturation-0 (skin-band median 71 vs 98 horizontal; near-black
// 31.5% vs 29.1%): the Contrast S-curve darkens everything below its
// 0.5 pivot, and the face lives at 0.3-0.4, so it ate the Gamma lift.
// Iteration 2: Tone Gamma 0.85 (stronger lift), Contrast halved
// (H 0.05 / V 0.08), Vertical sharpen DOWN to 1.8 with threshold 0.015
// and Denoise 0.30 (its detail energy measured ~2.5x the old vertical -
// grit from sharpening the tighter upscale). Defaults = Horizontal v2.
// Replaces using hsl_hsv_saturation.shader with both Sat Gains at 0 as the
// "Black N White" look. Saturation 0 is fine, but it is ONLY a desaturate:
// it adds no contrast shaping, no sharpening, and its HSL/HSV round trip
// can band in dark gradients. This shader does the job properly in one pass:
//   1. Rec.709 luma (matches how the stream/encoder sees brightness).
//   2. Light 3x3 denoise BEFORE sharpening, so sensor noise in the dark
//      room is not sharpened into B&W grit (the edge-aware trick from
//      edge_aware_sharpen.shader: coring threshold + shadow protection).
//   3. Tone Gamma (lifts midtones/the face) + a gentle Contrast S-curve,
//      because a straight desaturate of the final camera settings is
//      darker and flatter than the colour image feels.
//   4. Edge-aware sharpening on the luma only.
// Alpha is preserved (input alpha out), so it is safe on any source.
//
// FINAL PRESETS (start here, confirm on the final camera settings -
// the old Black N White settings were made pre-4K / pre-final-exposure):
//   Horizontal (PC): defaults below.  Tone Gamma 0.85, Contrast 0.05,
//     Denoise 0.15, Sharpen 2.0, Threshold 0.01.
//   Vertical (mobile): Tone Gamma 0.85, Contrast 0.08, Denoise 0.30,
//     Sharpen 1.8, Threshold 0.015 - the vertical crop is a bigger
//     upscale, so LESS sharpening (measured grit at 2.5) but more
//     denoise; same face lift as horizontal.
// The old hsl_hsv_saturation Black N White (Gain 0 / Gamma 1 / Parallel)
// stays as backup; do not delete it until this is confirmed on a song.

uniform float tone_gamma<
    string label = "Tone Gamma (below 1 lifts midtones/face, 1 = neutral)";
    string widget_type = "slider";
    float minimum = 0.5;
    float maximum = 1.5;
    float step = 0.01;
> = 0.85;

uniform float contrast<
    string label = "Contrast (gentle S-curve)";
    string widget_type = "slider";
    float minimum = -0.5;
    float maximum = 0.8;
    float step = 0.01;
> = 0.05;

uniform float denoise<
    string label = "Denoise before sharpening (0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.6;
    float step = 0.05;
> = 0.15;

uniform float sharpen_amount<
    string label = "Sharpen amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 4.0;
    float step = 0.05;
> = 2.0;

uniform float sharpen_threshold<
    string label = "Sharpen noise threshold (raise if grit appears)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.1;
    float step = 0.001;
> = 0.01;

uniform float shadow_protect<
    string label = "Shadow protect (sharpening fades below this brightness)";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 0.5;
    float step = 0.01;
> = 0.2;

float luma709(float3 c)
{
    return dot(c, float3(0.2126, 0.7152, 0.0722));
}

float4 mainImage(VertData v_in) : TARGET
{
    float4 c = image.Sample(textureSampler, v_in.uv);
    float2 px = uv_pixel_interval;

    // 3x3 gaussian blur of luma (centre 4/16, edges 2/16, corners 1/16)
    float b = luma709(c.rgb) * 0.25;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2( px.x, 0.0)).rgb) * 0.125;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2(-px.x, 0.0)).rgb) * 0.125;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2(0.0,  px.y)).rgb) * 0.125;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2(0.0, -px.y)).rgb) * 0.125;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2( px.x,  px.y)).rgb) * 0.0625;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2(-px.x,  px.y)).rgb) * 0.0625;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2( px.x, -px.y)).rgb) * 0.0625;
    b += luma709(image.Sample(textureSampler, v_in.uv + float2(-px.x, -px.y)).rgb) * 0.0625;

    float y0 = luma709(c.rgb);
    float y = lerp(y0, b, denoise);            // denoise base
    float d = y0 - b;                          // detail (high frequency)
    float s = sign(d) * max(abs(d) - sharpen_threshold, 0.0);   // coring
    float w = saturate(b / shadow_protect);    // no sharpening in deep shadow
    y = saturate(y + clamp(s * sharpen_amount * w, -0.12, 0.12));

    y = pow(saturate(y), tone_gamma);          // midtone/face lift
    y = saturate(y + contrast * y * (1.0 - y) * (y - 0.5) * 2.0); // S-curve

    return float4(y, y, y, c.a);
}
