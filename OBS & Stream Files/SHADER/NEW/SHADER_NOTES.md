# Shader notes — learned, per shader (Step 8, from v1.11.0)

One section per shader, written after actually reading its code and
(when possible) simulating it on a real frame. The user's own 25 tuned
looks come first (with their settings + example image, fine-tuned one
by one); after those are done, the remaining files are reviewed one by
one here for music-stream use (song styles, moods, camera vs lyrics vs
vertical, GPU cost). Catalog of all files: `SHADER_CATALOG.md`.

Status legend: READY = analysed, waiting for the user's settings/image.
TUNING = their settings received, fine-tune in progress. FINAL = agreed.

---

## hsl_hsv_saturation.shader — READY (starting shader)

What it does (from the code): saturation-only control, twice over.
Every pixel is converted to HSL and to HSV; each saturation is remapped
as `s' = pow(s, 1/Gamma) * Gain` (Gain 0–5, Gamma 0.1–10, defaults 1/1),
converted back, and combined per the **Order** select:
1. *Parallel* (default): HSL-adjusted and HSV-adjusted results averaged.
2. *HSL first, then HSV*: the two remaps stack in sequence.
3. *HSV first, then HSL*: stacked the other way round.

Key behaviours to tune against:
- No clamping inside the shader: `s' > 1` produces out-of-range colours
  that OBS clips later — that's the blowout you see first on the RGB
  floor lamps, the red/blue room light and saturated CD covers.
- HSL saturation acts strongest on mid-tone colours (skin, CD wall);
  HSV saturation acts relative to brightness, so it hits the lamps and
  bright artwork hardest. Parallel mode is the gentlest per unit of
  Gain; the stacked orders roughly multiply the effect (same Gain
  numbers feel much stronger).
- Gamma < 1 lifts weak/greyish colours toward saturation (room gets
  colourful fast, skin can go orange); Gamma > 1 leaves weak colours
  alone and only pushes already-strong colours.
- It has no skin protection and no luma change, so on the camera clones
  the safe direction for a "rich" look is small parallel gains; for
  muted/faded song moods, gains < 1 in parallel are smooth.
- Alpha bug note: the final line returns alpha 1.0 despite the comment
  "preserving the original alpha" — fine on full-frame camera clones,
  do **not** put it on the Lyrics source (it would make the lyric strip
  opaque black-boxed).

Simulation on the user's own (pre-final-settings, cropped) frame —
HSL vs HSV vs Parallel at 0.5 / 1.6 / 2.5 — see
`Image Files/JPG/Shaders/hsl_hsv_saturation - Simulation.jpg`:
at 1.6 parallel the room/CD colours pop noticeably with skin still
acceptable; 2.5 parallel turns lamps and several covers nuclear and
skin sunburnt; 0.5 parallel is a usable faded/muted look.

Waiting for: the user's settings screenshot + example image for this
shader (where it's used: which clone/source, what mood/song it was
made for). Fine-tune then: compare their example against simulations,
propose per-order values, and record the FINAL values here and in
`current_settings.yaml`.
