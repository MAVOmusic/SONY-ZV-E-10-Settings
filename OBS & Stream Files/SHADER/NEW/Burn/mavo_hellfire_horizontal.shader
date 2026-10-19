// MAVO Hellfire HORIZONTAL (PC) - looks 3/25 Burn + 4/25 Burn With Embers combined (v1.16.0)
// Why a new shader instead of tuning the two originals:
// - OLD/burn.shader multiplies the picture by a red burn-gradient
//   noise: at the user's settings it is a flat red wash with grey
//   smoke highlights. There are no flames in it at all.
// - OLD/embers.effect adds nice orange sparks, but only sparks.
// This one is a single .shader (no texture files, no .effect) with
// four procedural layers over the camera picture:
//   1. Warm hell tint rising from the bottom edge.
//   2. FIRE WAVES: a flame front along the bottom whose height is
//      fbm noise scrolling upward, colour-ramped deep red -> orange
//      -> yellow -> white core. This is the missing realistic fire.
//   3. SMOKE/FOG: slow fbm drifting sideways and up, strongest in
//      the upper half, laid softly over the picture.
//   4. EMBERS: hash-grid particles rising with sway and twinkle.
//      They FLARE (whiter/brighter) where the picture has a strong
//      edge (your silhouette, the bass outline, CD frames) - a
//      per-pixel shader has no depth, so edge proximity is how it
//      fakes "sparking on contact" with the subject.
// GPU note: 4-octave fbm + 9-cell ember lookup per pixel. It runs on
// the 4K source like every look; if OBS Stats shows GPU pressure,
// this is the first look to drop on the vertical clone (use the
// _vertical file, which lowers Smoke/Ember cost via density, or
// disable it on vertical entirely).
// Defaults below = Horizontal. Vertical file: Flame Height 0.30,
// Ember Density 0.9, Smoke Density 0.30 (tighter crop, subject bigger).

uniform float flame_height<
    string label = "Fire: flame height (fraction of screen from the bottom)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.8;
    float step = 0.01;
> = 0.35;

uniform float flame_speed<
    string label = "Fire: speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 3.0;
    float step = 0.05;
> = 1.0;

uniform float smoke_density<
    string label = "Smoke/fog density (0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.35;

uniform float ember_density<
    string label = "Embers density (0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.5;
    float step = 0.05;
> = 0.8;

uniform float hell_tint<
    string label = "Hell tint (warm wash from the bottom, 0 = off)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.05;
> = 0.25;

float hash21(float2 p)
{
    p = frac(p * float2(234.34, 435.345));
    p += dot(p, p + 34.23);
    return frac(p.x * p.y);
}

float vnoise(float2 p)
{
    float2 i = floor(p);
    float2 f = frac(p);
    f = f * f * (3.0 - 2.0 * f);
    float a = hash21(i);
    float b = hash21(i + float2(1.0, 0.0));
    float c = hash21(i + float2(0.0, 1.0));
    float d = hash21(i + float2(1.0, 1.0));
    return lerp(lerp(a, b, f.x), lerp(c, d, f.x), f.y);
}

float fbm(float2 p)
{
    float v = 0.0;
    float w = 0.5;
    for (int i = 0; i < 4; i++)
    {
        v += vnoise(p) * w;
        p *= 2.03;
        w *= 0.5;
    }
    return v;
}

float3 flame_ramp(float x)
{
    // 0 = invisible, 0.4 = deep red, 0.7 = orange, 0.9 = yellow, 1 = white core
    float3 c = lerp(float3(0.35, 0.02, 0.0), float3(0.9, 0.15, 0.01), smoothstep(0.15, 0.5, x));
    c = lerp(c, float3(1.0, 0.45, 0.05), smoothstep(0.5, 0.75, x));
    c = lerp(c, float3(1.0, 0.85, 0.35), smoothstep(0.75, 0.92, x));
    c = lerp(c, float3(1.0, 1.0, 0.9), smoothstep(0.92, 1.0, x));
    return c;
}

float4 mainImage(VertData v_in) : TARGET
{
    float4 src = image.Sample(textureSampler, v_in.uv);
    float3 col = src.rgb;
    float t = elapsed_time;
    float aspect = uv_size.x / max(uv_size.y, 1.0);
    float2 p = float2(v_in.uv.x * aspect, v_in.uv.y); // aspect-correct space
    float from_bottom = 1.0 - v_in.uv.y; // 0 at bottom edge of the picture

    // 1. Hell tint from the bottom
    float tint_mask = pow(saturate(1.0 - v_in.uv.y), 2.0) * hell_tint;
    col = lerp(col, col * float3(1.25, 0.55, 0.3) + float3(0.12, 0.01, 0.0), tint_mask);

    // 2. Fire waves along the bottom. The flame-front height varies
    // strongly across x (pow curve) so tongues separate with gaps
    // between them instead of one solid sheet; tips fade out so the
    // scene shows through between tongues; the white core lives only
    // at the very base.
    float front = fbm(float2(p.x * 6.0, from_bottom * 3.0 - t * (0.7 * flame_speed)));
    float front2 = fbm(float2(p.x * 14.0 + 40.0, from_bottom * 6.0 - t * (1.3 * flame_speed)));
    float tongue = saturate(front * 0.7 + front2 * 0.45);
    float h = max(flame_height * pow(tongue, 1.5) * 1.70, 0.001);
    float ratio = from_bottom / h; // 0 at the floor, 1 at the tongue tip
    float d = h - from_bottom;
    float flame = smoothstep(0.0, 0.08, d) * (0.55 + 0.45 * saturate(1.0 - ratio)) * (0.60 + 0.65 * front2);
    float core = smoothstep(0.10, 0.0, from_bottom) * smoothstep(0.0, 0.05, d);
    float flicker = 0.85 + 0.15 * vnoise(float2(t * 3.0, p.x * 8.0));
    float3 fire_col = flame_ramp(saturate((1.0 - ratio) * 0.95 + core * 0.5)) * (0.75 + 0.7 * core) * flicker;
    col = lerp(col, fire_col, saturate(flame * 0.90));
    col += fire_col * core * 0.5; // base glow spills onto the scene

    // 3. Smoke / fog drifting up and sideways, denser up high
    float smoke = fbm(p * 3.0 + float2(t * 0.05, -t * 0.11));
    float smoke_mask = smoke_density * smoothstep(0.35, 0.85, smoke) * (0.35 + 0.65 * v_in.uv.y);
    float3 smoke_col = float3(0.16, 0.13, 0.12) + smoke * 0.10;
    col = lerp(col, smoke_col, saturate(smoke_mask) * 0.55);

    // 4. Embers rising, flaring near picture edges ("contact" sparks)
    float lum_c = dot(src.rgb, float3(0.299, 0.587, 0.114));
    float lum_r = dot(image.Sample(textureSampler, v_in.uv + float2(uv_pixel_interval.x * 2.0, 0.0)).rgb, float3(0.299, 0.587, 0.114));
    float lum_u = dot(image.Sample(textureSampler, v_in.uv - float2(0.0, uv_pixel_interval.y * 2.0)).rgb, float3(0.299, 0.587, 0.114));
    float edge = saturate((abs(lum_r - lum_c) + abs(lum_u - lum_c)) * 6.0);

    float2 gp = float2(v_in.uv.x * 46.0, v_in.uv.y * 46.0);
    float2 id = floor(gp);
    float3 embers = float3(0.0, 0.0, 0.0);
    for (int ix = -1; ix <= 1; ix++)
    {
        for (int iy = -1; iy <= 1; iy++)
        {
            float2 cid = id + float2((float)ix, (float)iy);
            float rnd = hash21(cid);
            float rnd2 = hash21(cid + 17.31);
            float rnd3 = hash21(cid + 41.77);
            float speed = 0.05 + 0.11 * rnd2;
            float life = frac(rnd + t * speed);              // 0 bottom -> 1 top of its travel
            float2 centre = cid + float2(
                0.5 + 0.32 * sin(t * (0.6 + rnd3) + rnd * 40.0 + life * 5.0),
                frac(life) * 1.0);
            // particle travels inside its own cell column as life rises: wrap vertically
            centre.y = cid.y + frac(rnd2 + t * speed);
            float2 dv = (gp - centre) * float2(1.6, 3.2);    // stretched sparks like the original
            float dist = length(dv);
            float twinkle = 0.55 + 0.45 * sin(t * (6.0 + rnd3 * 9.0) + rnd * 80.0);
            float fade = smoothstep(0.0, 0.15, life) * (1.0 - smoothstep(0.7, 1.0, life));
            float on = step(rnd3, ember_density * 0.62);      // density gate
            float spark = (1.0 - smoothstep(0.0, 0.55, dist)) * twinkle * fade * on;
            float contact = 1.0 + edge * 2.2;                 // flare on subject edges
            embers += (float3(1.0, 0.38, 0.04) * spark * 1.4 + float3(1.0, 0.75, 0.35) * spark * spark * 1.2) * contact;
        }
    }
    col += embers;
    col += float3(1.0, 0.45, 0.08) * saturate(flame) * 0.15; // ambient firelight

    return float4(saturate(col), src.a);
}
