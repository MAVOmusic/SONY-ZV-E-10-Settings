# Shader notes — learned, per shader (Step 8, from v1.11.0)

One section per shader, written after actually reading its code and
(when possible) simulating it on a real frame. The user's own 25 tuned
looks come first (with their settings + example image, fine-tuned one
by one); after those are done, the remaining files are reviewed one by
one here for music-stream use (song styles, moods, camera vs lyrics vs
vertical, GPU cost). Catalog of all files: `../OLD/SHADER_CATALOG.md`. FOLDER RULE (v1.12.0): `SHADER/OLD/` = the user's uploaded library; `SHADER/NEW/<Look Name>/` = our shaders only, every look as TWO files `_horizontal` + `_vertical` with baked-in defaults, plus a SETTINGS_MEMO.md per look.

STANDING RULES (user, v1.11.1):
- Every look gets SEPARATE Horizontal (PC) and Vertical (mobile)
  settings - the vertical crop is tighter/upscaled and watched small,
  so it usually wants a little more lift/contrast/sharpen/denoise.
  A look is only FINAL when both presets are recorded.
- ALL of the user's existing looks were made BEFORE the 4K source and
  BEFORE the final camera/OBS settings, so every one must be
  re-validated at the final settings (brightness, noise floor and
  upscale all changed), even if its numbers are resolution-independent.

### 1/25 Black N White (user look, uses hsl_hsv_saturation) - TUNING
User settings (screenshots in `Image Files/JPG/Shaders/`):
Horizontal AND Vertical both: HSL Sat Gain 0, HSL Gamma 1, HSV Sat
Gain 0, HSV Gamma 1, Order Parallel. Measured on his examples: pure
desaturation (saturation 0.000), frame luma 53 (H) / 61 (V, brighter
because the vertical example's orange frame overlay lifts it).
Difference spotted: the vertical clone's dialog shows older slider
names ('HSL Saturation', Order as 1.00 number) - it is running an
older pasted copy of the shader; both clones should load the same
file from NEW/ so the two presets cannot drift apart.
Verdict: saturation 0 works and is honest B&W, but it is only a
desaturate (no tone shaping, no sharpening). Our edge_aware_sharpen
'TEST grayscale' was checked as an alternative and REJECTED: with the
switch on it returns plain luma and bypasses the sharpening entirely.
Proposed replacement: `mavo_black_and_white.shader` (Rec.709 luma,
denoise-before-sharpen, Tone Gamma, Contrast S-curve, alpha safe).
Simulated on the user's frame (file `Black And White - Simulation.jpg`
in Image Files/JPG/Shaders/): old way luma 53.8 / 26.2% near-black;
Horizontal preset (Gamma 0.92, Contrast 0.10, Denoise 0.15, Sharpen
2.0/Thr 0.01) -> 58.0 / 22.9%; Vertical preset (Gamma 0.88, Contrast
0.16, Denoise 0.25, Sharpen 2.5/Thr 0.012) -> 60.2 / 20.9% - face and
room lifted out of the crush with no extra grit. Test 1 (v1 presets, user's examples `Black And White New Shader
Example (Horizontal/Vertical).jpg`): NOT the best yet. Measured: face
skin-band median 71 (new) vs 98 (old) horizontal; near-black 31.5% vs
29.1% H and 43.8% vs 40.4% V (camera area); vertical Laplacian detail
2203 vs 863 (framing differs - hint only, but consistent with grit).
Diagnosis: the Contrast S-curve darkens every tone below its 0.5
pivot, the face lives at 0.3-0.4, so Contrast 0.10/0.16 ate the Gamma
lift; Vertical Sharpen 2.5 is too much for the tighter upscale.
Iteration 2 (shader defaults updated): H Gamma 0.85 / Contrast 0.05 /
Denoise 0.15 / Sharpen 2.0 / Thr 0.01; V Gamma 0.85 / Contrast 0.08 /
Denoise 0.30 / Sharpen 1.8 / Thr 0.015. Simulation: near-black
22.9% (v1) -> 15.4% (v2).
Test 2 (v2): WINS vs v1 and old - H luma 53.9 (v1 48.1, old 52.9),
near-black 24.0% (v1 31.5, old 29.1); V near-black 37.9% (v1 43.8,
old 40.4), detail 1700 (v1 gritty 2203). **FINAL v1.12.0**: files
`Black And White/mavo_black_and_white_horizontal.shader` and
`..._vertical.shader` + SETTINGS_MEMO.md in that folder; before/after
images are the only shader-1 images kept in Image Files/JPG/Shaders/.
Also created: **MAVO Stage Colour Pop** (recommended colour use of
hsl_hsv_saturation) in `Stage Colour Pop/` (H 1.25/1.15, V 1.35/1.25,
Parallel, alpha preserved) + its SETTINGS_MEMO.md.

Status legend: READY = analysed, waiting for the user's settings/image.
TUNING = their settings received, fine-tune in progress. FINAL = agreed.

---

## hsl_hsv_saturation.shader — in use as 1/25 Black N White (see above)

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
