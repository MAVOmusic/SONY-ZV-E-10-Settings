# Burn + Embers -> MAVO Hellfire (looks 3/25 + 4/25, combined)

Status: BUILT v1.16.0, awaiting user's OBS test (not FINAL yet).

## Why the two originals were replaced by one shader
- `OLD/burn.shader` (user settings: Speed 0.63, Gradient Adjust 0.85,
  Dissolve 2.0, Animated OFF, Apply to Channel ON, Apply Smoke ON,
  Smoke H 0.30 / V 0.17, Iterations 15) multiplies the picture by a
  red burn-gradient noise through `burngradient_small.png` (kept in
  OLD/ next to it). Result: a flat dark-red wash, subject nearly
  silhouetted, smoke barely visible, and NO flames anywhere in it.
- `OLD/embers.effect` (Animation Speed 1.50, Movement H 5 / V 10,
  Speed Percent 5, Layers 15, Luma Min ~0, Luma Min Smooth 0.15,
  Alpha 99.9, Apply to Alpha Layer ON) is a full .effect with its own
  technique - it can never be a plain obs-shaderfilter .shader, and
  it only adds sparks + orange smoke.
- User's brief: "add fire waves to burn or sparks so it can make burn
  in general look good, or combined with embers a nice hell +
  smoke/fog effect combo." So: ONE combined shader.

## The replacement
`mavo_hellfire_horizontal.shader` / `mavo_hellfire_vertical.shader`
(single .shader each, no texture files). Four procedural layers:
1. Hell tint - warm wash rising from the bottom (slider, subtle).
2. Fire waves - flame front along the bottom edge; front height is
   fbm noise scrolling upward with a pow curve so tongues separate
   with gaps, tips fade, white-hot core only at the base, plus
   vertical streak erosion and flicker. (The missing realistic fire.)
3. Smoke/fog - slow fbm drifting sideways+up, denser up high.
4. Embers - hash-grid particles rising with sway/twinkle. They FLARE
   brighter/whiter where the picture has a strong edge (silhouette,
   bass outline) - a per-pixel shader has no depth or collision, so
   edge proximity fakes "sparking on contact". True contact sparks
   are impossible in this plugin; this is the honest approximation.

Presets - Horizontal: Flame Height 0.35, Flame Speed 1.0, Smoke
0.35, Embers 0.8, Hell Tint 0.25. Vertical: 0.30 / 1.0 / 0.30 /
0.9 / 0.25. Standalone Sharpen stays ON first as always (policy).

Simulation still (Python port on the Stage Colour Pop frame) =
`Image Files/JPG/Shaders/Hellfire - Simulation.jpg`: fire line at
the base, orange tongues/glow rising behind the subject, sparse
small embers. Motion (scrolling front, flicker, rising sparks) is
the real test - judge it in OBS, not from the still.

GPU note: 3x fbm (4 octaves) + 9-cell ember lookup per pixel on the
4K source. Watch OBS Stats; if GPU pressure appears, this is the
first look to drop from the vertical clone.

## Test checklist for the user
1. Copy BOTH files over the local copies, add/reload the filter.
2. Confirm sliders appear: Fire flame height / Fire speed /
   Smoke/fog density / Embers density / Hell tint.
3. Send one H and one V frame. Then tune: Flame Height (tongue
   reach), Embers (density), Smoke (density) - one number each.
