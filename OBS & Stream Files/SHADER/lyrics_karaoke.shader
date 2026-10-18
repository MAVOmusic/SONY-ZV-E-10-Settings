// Karaoke lyrics cleaner for the obs-shaderfilter plugin (v1.10.0)
// Replaces the Chroma Key (black, Similarity/Smoothness/Spill all 1) +
// Colour Correction (Gamma -3, Contrast 4, Saturation 5, Hue Shift 180,
// Multiply #FFFF00) pair that was used on the Rocksmith lyrics source.
// That pair keys on near-black only, so anti-aliased letter edges, video
// compression noise and any dark-but-not-black background survive as
// semi-transparent mush, and the extreme gamma/contrast crushes the
// letter shapes (see the yellow strip with blobs over the letters).
//
// This shader instead, on the RAW lyrics source (black background,
// light text - apply it INSTEAD of both filters above, not after them):
//   1. Keys on brightness with a soft threshold (clean, solid letters,
//      faint compression noise below the threshold disappears).
//   2. Optional de-speckle: mixes the key with the 3x3 minimum, which
//      deletes isolated 1-pixel noise dots without thinning the text.
//   3. Recolours the letters with a flat Text Colour (default yellow).
//      Pixels that are strongly COLOURED in the source (saturation above
//      the split point - e.g. a syllable the game highlights in colour)
//      get the Highlight Colour instead, so any in-game karaoke
//      highlight is kept. Neutral/grey/white text always uses Text Colour.
//   4. Adds a solid dark Outline (dilated key minus the letters) and an
//      optional soft Glow behind it, so the line stays readable over a
//      busy camera picture / CD wall in fullscreen and in Shorts.
//   5. Optionally boldens the letters (dilation) for small vertical text.
// Output alpha is transparent where there is no text, so the source can
// sit directly over the camera scene. No timing/animation is possible in
// a per-pixel shader: the line changes and any sung-word highlight still
// come from Rocksmith itself.
//
// Suggested starting values (the defaults): Threshold 0.25, Softness 0.35,
// De-speckle 0.5, Bold 0, Outline width 2, Glow 0.35.
// If letters look thin/broken: lower Threshold to 0.18 or raise Bold to 1.
// If grey background haze remains: raise Threshold to 0.35.
// Put edge_aware_sharpen.shader AFTER this one only if the text still
// looks soft at 100% preview; normally it is not needed on text.

uniform float3 text_color<
    string label = "Text colour";
    string widget_type = "color";
> = {1.0, 0.85, 0.0};

uniform float3 highlight_color<
    string label = "Highlight colour (for coloured pixels in the source, e.g. sung syllable)";
    string widget_type = "color";
> = {0.2, 1.0, 0.35};

uniform float3 outline_color<
    string label = "Outline colour";
    string widget_type = "color";
> = {0.0, 0.0, 0.0};

uniform float threshold_key<
    string label = "Key threshold (brightness below this is removed)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.9;
    float step = 0.01;
> = 0.25;

uniform float softness<
    string label = "Key softness (edge smoothness)";
    string widget_type = "slider";
    float minimum = 0.02;
    float maximum = 0.8;
    float step = 0.01;
> = 0.35;

uniform float despeckle<
    string label = "De-speckle (removes isolated noise dots)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.5;

uniform float highlight_split<
    string label = "Highlight split (source saturation above this uses Highlight colour, 1 = never)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.45;

uniform float bold_px<
    string label = "Bold (pixels the letters grow by, 0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 3.0;
    float step = 0.5;
> = 0.0;

uniform float outline_px<
    string label = "Outline width (pixels, 0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 6.0;
    float step = 0.5;
> = 2.0;

uniform float glow_strength<
    string label = "Glow strength (0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.35;

uniform float text_opacity<
    string label = "Text opacity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 1.0;

uniform bool test_show_key<
    string label = "TEST: show cleaned key only (white = text, proves the shader is running)";
> = false;

float luma(float3 c)
{
    return dot(c, float3(0.299, 0.587, 0.114));
}

float key_at(float2 uv)
{
    float4 c = image.Sample(textureSampler, uv);
    float key = smoothstep(threshold_key, threshold_key + softness, luma(c.rgb));
    if (despeckle > 0.001)
    {
        // 3x3 minimum: a pixel only survives if its neighbours are also
        // text, which kills isolated compression-noise dots.
        float m = key;
        m = min(m, smoothstep(threshold_key, threshold_key + softness, luma(image.Sample(textureSampler, uv + float2( uv_pixel_interval.x, 0.0)).rgb)));
        m = min(m, smoothstep(threshold_key, threshold_key + softness, luma(image.Sample(textureSampler, uv + float2(-uv_pixel_interval.x, 0.0)).rgb)));
        m = min(m, smoothstep(threshold_key, threshold_key + softness, luma(image.Sample(textureSampler, uv + float2(0.0,  uv_pixel_interval.y)).rgb)));
        m = min(m, smoothstep(threshold_key, threshold_key + softness, luma(image.Sample(textureSampler, uv + float2(0.0, -uv_pixel_interval.y)).rgb)));
        key = lerp(key, max(key * 0.35, m), despeckle); // keep letter cores solid
    }
    return key;
}

float key_dilated(float2 uv, float radius_px)
{
    // Max key over a small disc = letters grown by radius_px.
    float m = key_at(uv);
    if (radius_px <= 0.01)
        return m;
    float2 px = uv_pixel_interval;
    // Fixed tap pattern scaled by the radius (cheap, runs once per pixel).
    m = max(m, key_at(uv + float2( px.x, 0.0) * radius_px));
    m = max(m, key_at(uv + float2(-px.x, 0.0) * radius_px));
    m = max(m, key_at(uv + float2(0.0,  px.y) * radius_px));
    m = max(m, key_at(uv + float2(0.0, -px.y) * radius_px));
    m = max(m, key_at(uv + float2( px.x,  px.y) * radius_px * 0.7));
    m = max(m, key_at(uv + float2(-px.x,  px.y) * radius_px * 0.7));
    m = max(m, key_at(uv + float2( px.x, -px.y) * radius_px * 0.7));
    m = max(m, key_at(uv + float2(-px.x, -px.y) * radius_px * 0.7));
    m = max(m, key_at(uv + float2( px.x, 0.0) * radius_px * 0.5));
    m = max(m, key_at(uv + float2(-px.x, 0.0) * radius_px * 0.5));
    m = max(m, key_at(uv + float2(0.0,  px.y) * radius_px * 0.5));
    m = max(m, key_at(uv + float2(0.0, -px.y) * radius_px * 0.5));
    return m;
}

float4 mainImage(VertData v_in) : TARGET
{
    float4 src = image.Sample(textureSampler, v_in.uv);

    float fill = key_dilated(v_in.uv, bold_px);
    float outline_zone = key_dilated(v_in.uv, bold_px + outline_px);
    float glow_zone = key_dilated(v_in.uv, bold_px + outline_px + 4.0);

    if (test_show_key)
        return float4(fill, fill, fill, 1.0);

    // Text colour: flat colour for neutral text, highlight colour where
    // the source pixel itself is strongly coloured (saturation split),
    // smoothed by the key colour's own neighbourhood centre pixel.
    float mx = max(src.r, max(src.g, src.b));
    float mn = min(src.r, min(src.g, src.b));
    float saturation = (mx <= 0.001) ? 0.0 : (mx - mn) / mx;
    float use_highlight = smoothstep(highlight_split, highlight_split + 0.2, saturation);
    float3 fill_rgb = lerp(text_color, highlight_color, use_highlight);

    float outline = saturate(outline_zone - fill);
    float glow = saturate(glow_zone - outline_zone) * glow_strength;

    // Composite glow -> outline -> text (straight alpha out).
    float a_glow = glow;
    float a_outline = outline;
    float a_text = fill * text_opacity;

    float out_a = a_text + a_outline * (1.0 - a_text) + a_glow * (1.0 - a_text) * (1.0 - a_outline);
    float3 out_rgb = fill_rgb;
    if (a_outline > a_text)
        out_rgb = outline_color;
    if (a_text < 0.01 && a_outline < 0.01)
        out_rgb = text_color; // glow takes the text colour

    // Blend colours by coverage so edges stay clean.
    float total = a_text + a_outline + a_glow + 1e-5;
    out_rgb = (fill_rgb * a_text + outline_color * a_outline + text_color * a_glow) / total;

    return float4(out_rgb, saturate(out_a));
}
