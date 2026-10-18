# Lyrics karaoke shader — guide (v1.10.3, CONFIRMED FINAL)

## Final settings (user-tested and accepted, now the shader defaults)
Fill Solidity **4.0**, Backing Plate **0.4**, Threshold 0.12, Softness 0.5,
De-speckle 0.25, History Opacity 0.6, Outline 3 px black, Outer Border
2 px red. A fresh load of `lyrics_karaoke.shader` is the final look - no
tuning needed. Proof: `Image Files/JPG/Lyrics Corrected.jpg`.

## v1.10.2 — stronger borders (after OBS test 2)
Test 2: the history line stayed, but the middle of the line still blended
into the CD wall at small size. Causes: (1) the soft key left letter
centres semi-transparent, so the background showed *through* the letters;
(2) the dim-line tier thinned the outline again. Fixes: **Fill Solidity
(2.0)** pushes letter cores fully opaque; **Outline now 3 px at full
strength for every line**; a **red Outer Border (2 px)** rings the black
stroke (red approved by the user); a **Backing Plate (0.45)** darkens
the background immediately around the words. The old soft Glow slider
is gone - the plate replaces it. Confirm v1.10.2 is loaded by the new
sliders (Fill Solidity / Outer Border / Backing Plate). Still blending
over the brightest covers: Outline 4, Outer Border 3, Backing Plate 0.6.
For tiny Shorts text those three are the first knobs to turn up.

## v1.10.1 — keep the history line (after OBS test 1)
Test 1 verdict: the shader works and the sung word really does come out
in the Highlight colour — but Rocksmith shows the previous/next line
**dim**, and the v1.10.0 defaults (Threshold 0.25, De-speckle 0.5) deleted
that dim line entirely, so there was no history of the line on screen.
v1.10.1 changes: Threshold 0.12, Softness 0.5, De-speckle 0.25, and a new
**History Opacity (0.6)**: dim text is kept readable but secondary, with
a fainter outline; the bright main line stays solid. If the history line
still vanishes: Threshold 0.08 and/or History Opacity 0.75. Raise
Threshold only in 0.02 steps — every step also eats the history line.
Also seen in test 1: the Filters preview showed the shader painting the
whole Rocksmith frame (note highway) — it keys *any* bright pixel. Put a
**Crop/Pad filter above the shader** on the Lyrics source (or keep your
existing tight scene crop); never use the full game frame as the
visible output. One more limit, stated plainly: a per-pixel shader has
no access to previous frames, so it cannot make a line *linger after
Rocksmith removes it* — the history it keeps is the dim line Rocksmith
itself displays. If a timed hold/fade is what you want, say so; that
needs a different tool, not this shader.

## Why the old pair looks messy
The Rocksmith lyrics source was cleaned up with OBS **Chroma Key**
(Custom Colour `#000000`, Similarity 1, Smoothness 1, Spill Reduction 1,
Contrast −4.00) followed by **Colour Correction** (Gamma −3.00,
Contrast 4.00, Saturation 5.00, Hue Shift 180, Color Multiply `#FFFF00`).
Chroma Key at those settings only removes almost-pure black, so
anti-aliased letter edges and compression noise survive as
semi-transparent mush; the extreme gamma/contrast then crushes the
letter shapes into blobs (worst where anything bright overlaps the line).

## The shader
`OBS & Stream Files/SHADER/NEW/Karaoke/lyrics_karaoke.shader` (obs-shaderfilter)
replaces **both** filters. On the raw lyrics source (black background,
light text) it:

1. Keys on brightness with a soft threshold — faint noise drops out,
   letters become solid.
2. De-speckles (3×3 minimum mix) — isolated noise dots are deleted.
3. Paints the letters a flat colour (default karaoke yellow
   `1.0 / 0.85 / 0.0`). Source pixels that are strongly *coloured*
   (saturation above “Highlight split”) get the Highlight colour
   instead, so if the game colours the currently-sung syllable, that
   karaoke highlight survives; grey/white text is never affected.
4. Adds a solid dark outline and an optional soft glow so the line
   reads over the camera/CD wall, in fullscreen and in Shorts.
5. Optional Bold (letter dilation) for the small vertical canvas text.

Output is transparent where there is no text, so the source sits
directly over the camera scene.

## How to set it up (test it, keep the old pair disabled as backup)
1. On the lyrics source, **untick** (don't delete yet) Chroma Key,
   Colour Correction and Chroma Key 2.
2. Add → ShaderFilter → load `lyrics_karaoke.shader`. Keep the source
   crop tight around the lyric line — the shader keys *any* bright
   pixel, so note-highway graphics inside the crop would be painted too.
3. Defaults: Threshold 0.25, Softness 0.35, De-speckle 0.5, Bold 0,
   Outline 2 px, Glow 0.35, Highlight split 0.45.
4. Check at 100% preview, fullscreen and on the vertical canvas:
   - Letters thin/broken → Threshold 0.18, or Bold 1.
   - Grey haze around letters → Threshold 0.35.
   - Noise dots survive → De-speckle 0.75–1.0.
   - Everything turns Highlight colour → Highlight split 0.7–1.0
     (1.0 = highlight never used, all text one colour).
   - Text too small in Shorts → Bold 1–1.5 and Outline 3 on the
     vertical clone's copy of the filter.
5. Only delete the old Chroma Key / Colour Correction once a full song
   (quiet + loud/bright sections) looks right. `TEST: show cleaned key`
   shows white-on-black text only — handy to prove the key is clean.

## Honest limits
- A per-pixel shader cannot add sing-along timing (no bouncing ball,
  no word-by-word wipe). Line changes and any sung-word colour still
  come from Rocksmith — the shader preserves them, it can't create them.
- It must run on the **raw** source. Applied *after* the old filters it
  cannot recover letter shapes they already destroyed.
- Status: **not yet tested in OBS** (same as the sharpen shader was at
  first). The algorithm was validated by a NumPy/Pillow simulation on a
  synthetic noisy lyric line — see
  `Image Files/JPG/Lyrics Shader - Simulated Preview.jpg` (top: the old
  result; middle/bottom: simulated new result, incl. a green highlight
  word). First OBS test results should be recorded in
  `SETUP_CHECKLIST.md` Step 8 before this is called final.
