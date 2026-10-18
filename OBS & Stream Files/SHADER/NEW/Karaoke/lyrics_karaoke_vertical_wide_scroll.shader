// Karaoke lyrics WIDE-SCROLL VERTICAL variant (v1.13.0 - OPTIONAL test, not final)
PURPOSE: bigger lyrics on Shorts WITHOUT editing CDLC. It zooms the
lyric strip (default 1.30x) and slowly ping-pong scrolls sideways, so
a long line that would overflow at that size travels instead of being
cut. Lines that already fit will also drift a little - that is the
unavoidable price: a per-pixel shader cannot measure a line's length
(no frame analysis in obs-shaderfilter), so it cannot know which lines
need scrolling. If the drift annoys on short lines, this variant is
not for you and the plain _vertical file stays the final one.
True auto-fit would need the timed lyric data extracted from the CDLC
(the vocals are already synced inside the file - a batch converter is
a separate project, not hours per song, but not built yet).
// NOTE (v1.12.1): the user uploaded his on-disk copy to check whether OBS
// writes slider values back into the .shader file. IT DOES NOT - his copy
// still had the old defaults Fill Solidity 2.0 / Backing Plate 0.45, while
// his confirmed tuned values (Fill Solidity 4.0 / Backing Plate 0.4) live
// only in his OBS filter settings. This repo copy therefore keeps the
// tuned values BAKED IN as defaults (4.0 / 0.4 below). Nothing else in
// his upload differed, so his other sliders were at these defaults.
// A _vertical copy sits next to this file (same values + Bold 1,
// Outer Border 3 for the smaller Shorts text).
// v1.10.2: STRONGER BORDERS. User test of v1.10.1: better, history line
// stays, but the middle of the line still blends into the busy CD-wall
// background and is unreadable at stream size. Three causes fixed:
// (1) the soft key left letter centres semi-transparent, so the
// background showed THROUGH the letters - new Fill Solidity pushes
// letter cores to fully opaque; (2) the outline was thinned again by
// the history tier - the outline is now always full strength;
// (3) new two-tone border: black inner stroke (default 3 px) + RED
// outer border (default 2 px, user approved red if needed) + an
// optional dark backing plate behind the whole line, which kills the
// busy background directly around the words. At small (Shorts) sizes
// raise Outline to 4 and Outer Border to 3.
// v1.10.1: KEEP THE LINE HISTORY. User test of v1.10.0: Rocksmith shows the
// main line bright and the previous/next line DIM; the old threshold
// (0.25) + de-speckle deleted that dim line, so there was no history of
// the line on screen. Now: threshold defaults to 0.12, de-speckle is
// gentler (0.25), and dim text is kept at History Opacity (default 0.6)
// with a fainter outline instead of being removed - main line solid,
// history line readable but clearly secondary.
// IMPORTANT (also from the test screenshot): the Filters preview showed
// this shader painting the whole Rocksmith frame (note highway included),
// because it keys ANY bright pixel. Put a Crop/Pad effect filter ABOVE
// this shader on the Lyrics source so only the lyric strip is processed,
// or keep the existing tight scene crop - never run it on the full game
// frame as the visible output.
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
// Suggested starting values (the defaults): Threshold 0.12, Softness 0.5,
// De-speckle 0.25, History Opacity 0.6, Bold 0, Outline width 2, Backing Plate 0.45.
// If the dim history line vanishes again: Threshold 0.08, History Opacity 0.75.
// If letters look thin/broken: raise Bold to 1 (do NOT raise Threshold).
// If grey background haze remains: raise Threshold in 0.02 steps only -
// every step also eats the dim history line.
// Put edge_aware_sharpen.shader AFTER this one only if the text still
// looks soft at 100% preview; normally it is not needed on text.

uniform float3 text_color<
    string label = "Text colour";
    string widget_type = "color";
> = {1.0, 1.0, 0.004}; // user exact #FFFF01

uniform float3 highlight_color<
    string label = "Highlight colour (for coloured pixels in the source, e.g. sung syllable)";
    string widget_type = "color";
> = {0.2, 1.0, 0.349}; // user exact #33FF59

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
> = 0.12;

uniform float softness<
    string label = "Key softness (edge smoothness)";
    string widget_type = "slider";
    float minimum = 0.02;
    float maximum = 0.8;
    float step = 0.01;
> = 0.5;

uniform float despeckle<
    string label = "De-speckle (removes isolated noise dots)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.25;

uniform float history_opacity<
    string label = "History opacity (dim previous/next line: kept, but at this opacity; 0 = old delete behaviour)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.6;

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
> = 3.0;

uniform float3 outer_color<
    string label = "Outer border colour (second ring, outside the black outline)";
    string widget_type = "color";
> = {1.0, 0.078, 0.078}; // user exact #FF1414

uniform float outer_px<
    string label = "Outer border width (pixels, 0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 6.0;
    float step = 0.5;
> = 2.0;

uniform float plate_opacity<
    string label = "Backing plate opacity (dark plate behind the whole line, 0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.85;
    float step = 0.05;
> = 0.4;

uniform float fill_solidity<
    string label = "Fill solidity (pushes letter centres to fully opaque; raise if background shows through letters)";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 4.0;
    float step = 0.25;
> = 4.0;

uniform float text_opacity<
    string label = "Text opacity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.95;

uniform float scroll_zoom<
    string label = "Wide zoom (1 = off, 1.3 = bigger text)";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 1.8;
    float step = 0.05;
> = 1.3;

uniform float scroll_speed<
    string label = "Scroll speed (0 = no scroll, just zoom+crop)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.2;
    float step = 0.005;
> = 0.04;

uniform float elapsed_time; // provided by obs-shaderfilter

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
    // Wide-scroll transform: zoom into the strip and ping-pong sideways.
    float amp = 0.5 * (1.0 - 1.0 / scroll_zoom) * 0.92;
    float tri = abs(frac(elapsed_time * scroll_speed) * 2.0 - 1.0);
    float2 uv_t = (v_in.uv - 0.5) / scroll_zoom + 0.5 + float2((tri - 0.5) * 2.0 * amp, 0.0);
    float4 src = image.Sample(textureSampler, uv_t);

    float fill_raw = key_dilated(uv_t, bold_px);
    float fill = saturate(fill_raw * fill_solidity); // solid letter cores
    float inner_zone = key_dilated(uv_t, bold_px + outline_px);
    float outer_zone = key_dilated(uv_t, bold_px + outline_px + outer_px);
    float plate_zone = key_dilated(uv_t, bold_px + outline_px + outer_px + 3.0);

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

    // Bright main line: tier ~1. Dim history line: tier lower, kept at
    // history_opacity. Borders are NOT reduced by tier any more (v1.10.2):
    // a thinner border on the dim line is what made it unreadable.
    float tier = saturate(fill_raw * 1.5);
    float keep = lerp(history_opacity, 1.0, tier);

    float a_text  = fill * text_opacity * keep;
    float a_inner = saturate(inner_zone - fill) ;                    // black stroke
    float a_outer = saturate(outer_zone - inner_zone);               // red ring
    float a_plate = saturate(plate_zone - outer_zone) * plate_opacity; // dark plate

    // Coverage-weighted colour blend; alpha is the union of all layers.
    float w_text = a_text;
    float w_in   = a_inner * (1.0 - a_text);
    float w_out  = a_outer * (1.0 - a_text) * (1.0 - a_inner);
    float w_plate= a_plate * (1.0 - a_text) * (1.0 - a_inner) * (1.0 - a_outer);
    float out_a  = saturate(w_text + w_in + w_out + w_plate);
    float3 out_rgb = (fill_rgb * w_text + outline_color * w_in +
                      outer_color * w_out + float3(0.0, 0.0, 0.0) * w_plate) /
                     max(out_a, 1e-5);
        return float4(out_rgb, saturate(out_a));
}
