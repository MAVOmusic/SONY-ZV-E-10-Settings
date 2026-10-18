# SETTINGS MEMO — MAVO Stage Colour Pop (recommended hsl_hsv_saturation use, v1.12.0)

Recommended fitting use of `hsl_hsv_saturation.shader` for music
streams now that Black And White has its own dedicated shader.

Our files (defaults baked in, based on the OLD/hsl_hsv_saturation code,
alpha bug fixed):
- Horizontal (PC): `mavo_stage_colour_pop_horizontal.shader`
  HSL Sat Gain 1.25, HSL Gamma 0.95, HSV Sat Gain 1.15, HSV Gamma 1.0,
  Order = Parallel.
- Vertical (mobile): `mavo_stage_colour_pop_vertical.shader`
  HSL Sat Gain 1.35, HSL Gamma 0.95, HSV Sat Gain 1.25, HSV Gamma 1.0,
  Order = Parallel (phone screens + tighter crop get a touch more).

Why: gentle parallel lift = CD wall and the blue/red lamps pop, no
brightness change, skin stays safe at these gains (see the
hsl simulation measurements in `../SHADER_NOTES.md`: 1.6 parallel was
already strong; 2.5 blows lamps/skin out — stay near 1.25–1.35).

Use: colour looks for normal/party/pop-rock songs. Off for ballads
(use Black And White) and never stacked with another saturation
control (OBS Colour Correction saturation) — double lift clips the
lamps first. Not FINAL until the user A/B tests it on a song; the
numbers above are the recommended starting point, recorded as agreed.
