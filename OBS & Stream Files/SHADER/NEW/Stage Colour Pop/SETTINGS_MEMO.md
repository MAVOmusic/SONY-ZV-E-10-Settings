# SETTINGS MEMO — MAVO Stage Colour Pop (FINAL as a look, v1.13.4)

TESTED (v1.13.4): works as intended - saturation +8.5% vs baseline,
no added highlight clipping, skin warmer but natural. FINAL as the
live look for colourful songs, ON TOP OF the always-on Sharpen.
NOT the default/'no filter' recording look: the default stays
Sharpen ONLY (clean master - saturation can be added in edit, never
removed). Examples: `Image Files/JPG/Shaders/Stage Colour Pop -
Horizontal/Vertical.jpg`.

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
