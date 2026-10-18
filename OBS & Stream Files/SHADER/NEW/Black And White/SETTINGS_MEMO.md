# SETTINGS MEMO — Black And White (shader look 1/25, FINAL v1.12.0)

Our files (defaults ARE the final settings — load and go):
- Horizontal (PC): `mavo_black_and_white_horizontal.shader`
- Vertical (mobile): `mavo_black_and_white_vertical.shader`

| Setting | Horizontal | Vertical |
|---|---|---|
| Tone Gamma | 0.85 | 0.85 |
| Contrast | 0.05 | 0.08 |
| Denoise | 0.15 | 0.30 |
| Sharpen Amount | 2.0 | 1.8 |
| Sharpen Threshold | 0.01 | 0.015 |
| Shadow Protect | 0.2 | 0.2 |

Why these: measured over three iterations. Old look (hsl_hsv_saturation
at Sat Gain 0 — kept in `SHADER/OLD`, do not delete) was clean but flat
and crushed (near-black 29% H / 40% V). v1 presets got darker on the
face (Contrast S-curve darkens below its 0.5 pivot; the face is at
0.3–0.4). Final: stronger Gamma lift, half the contrast, and LESS
sharpening on vertical (it is the bigger upscale; 2.5 measured gritty).
v2 results vs v1: frame luma 48.1 → 53.9, near-black 31.5% → 24.0%
horizontal; vertical near-black 43.8% → 37.9%, detail energy down from
gritty 2203 → 1700.

Use: on the camera clone for moody/ballad/retro songs and as the
vertical default look when wanted. Do NOT stack with
`Sharpen/edge_aware_sharpen.shader` — this shader already sharpens;
using both double-sharpens (use edge-aware alone on colour looks).
Filter order in OBS: this shader after the sharpen shader's slot,
i.e. simply don't enable both on the same clone.

Related: `../Stage Colour Pop/` is the recommended colour use of the
original hsl_hsv_saturation shader (its B&W use is superseded by this).
