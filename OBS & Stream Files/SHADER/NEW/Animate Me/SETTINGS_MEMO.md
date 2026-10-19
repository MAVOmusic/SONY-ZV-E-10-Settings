# SETTINGS MEMO - Animate Me (shader look 2/25, v1.14.0)

Our files (defaults = tuned settings):
- Horizontal (PC): `mavo_manga_edges_horizontal.shader`
  Threshold 0.05, Softness 0.13, Line distance 2.0, Pre-blur 1.0, Edge colour white.
- Vertical (mobile): `mavo_manga_edges_vertical.shader`
  Threshold 0.065, Softness 0.15, Line distance 2.0, Pre-blur 1.0, Edge colour white
  (higher threshold because the vertical upscale enlarges noise too).

Original look (user): `SHADER/OLD/edge_detection.shader` at Sensitivity 0.05,
edge #FFFFFF, non-edge #00000000, everything else off - a hard binary Sobel.
Its noise comes from single-pixel gradients + the on/off threshold (and the
always-on Sharpen in front). Ours: pre-blur, 2 px gradient, soft ramp.
Simulation on the user's colour frame: edge coverage 21.5% (new) vs 29.8%
(old binary) - the manga story with ~1/4 less ink/speckle.

Use: white manga line-art on black for anime/retro/J-rock style songs,
intros and alerts. Keep the always-on Sharpen in front (the pre-blur is
designed for it). One knob in use: Threshold -0.01 = more lines,
+0.01 = cleaner. Status: user A/B test pending.
