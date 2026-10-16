# OBS 4K Cam Link: scaling and crop-zoom guide (v1.5.4)

Canvas: 1920x1080 @ 25 fps (PAL; status bar shows 25.00 / 25.00 FPS). Cam Link source: 3840x2160 @ 25.

## Why sources suddenly look 2x / 4x bigger
OBS places a source at 100% (1 source pixel = 1 canvas pixel). A 3840x2160 source on a 1920x1080 canvas
is 2x wider and 2x taller (4x the area), so you only see its top-left quarter
(see Image Files/PNG/OBS Main Settings (No Zoom In).png). Nothing is zoomed in the camera.

## Step A - restore the old framing (do this on EVERY camera item, including each [CLONE])
1. Select the item -> Ctrl+F (Fit to Screen). It becomes 1920x1080 at scale 0.5. Same framing as the old 1080p source,
   but with 4x the pixels behind it.
2. Right-click the item -> Scale Filtering -> Lanczos. This is stored per scene item, so repeat for each clone.

## Step B - zoom by cropping (lossless up to 2x)
1. Select the item -> Ctrl+E (Edit Transform).
2. Position X 0, Y 0. Alignment: top left.
3. Bounding Box Type: **Scale to inner bounds**, Bounds 1920 x 1080. OBS now rescales the cropped picture to fill the canvas,
   so only the crop numbers control the zoom.
4. Crop values are in SOURCE pixels (of the 3840x2160 frame).
   For zoom factor z: crop_left + crop_right = 3840 - 3840/z ; crop_top + crop_bottom = 2160 - 2160/z
   (keep the 16:9 ratio, otherwise the picture is stretched).

| Zoom z | Visible area (source px) | Total horiz. crop | Total vert. crop | Centered per side (L/R, T/B) |
|--------|--------------------------|-------------------|------------------|------------------------------|
| 1.0    | 3840 x 2160              | 0                 | 0                | 0 / 0                        |
| 1.2    | 3200 x 1800              | 640               | 360              | 320 / 180                    |
| 1.5    | 2560 x 1440              | 1280              | 720              | 640 / 360                    |
| 2.0    | 1920 x 1080              | 1920              | 1080             | 960 / 540 (1:1 pixels)       |
Up to 2.0x every canvas pixel still comes from a real source pixel: sharp. Above 2.0x OBS has to upscale (soft).
(Camera Clear Image Zoom/optical zoom is separate; optical zoom keeps even more detail.)

## OBS 32 wording (v1.5.1 correction)
This OBS (32.1.2) has no "Scale to inner bounds" entry; the bounds dropdown shows **Cover** (it scales until the bounds are filled and,
with "Crop Bounds" ticked, trims the overflow). For a crop that is exactly 16:9 Cover behaves the same as scale-to-inner, so use:
Position 0,0 / Bounds type **Cover** / Bounds 1920 x 1080 / Crop Bounds ticked. Crop fields then set the zoom.
(Screenshots: OBS Edit Transform - Crop To 0 Changes Zoom Out.png, OBS Edit Transform - No Scale To Inner Bounds Option.png.)
- Crop 0/0/0/0 with Cover = whole 4K frame fitted to the canvas = the widest ("zoomed out") view. That is correct, not a bug.
- More crop = more zoom. Left+Right must stay under 3840 and Top+Bottom under 2160. The black screen in the second screenshot was
  Left/Right 3840 each and Top/Bottom 2160 each (everything cropped away). Use Reset, then type small numbers.

## Correction: LED-edge framing
My v1.5.0 estimate (about 1.2x) used the wrong baseline. The full, uncropped 4K frame is far wider: in the screenshot the blue LED is about
26% of the frame width from the left edge and the red LED about 33% from the right edge, so the LEDs are only about 40% of the width apart
(roughly 1555 of 3840 source px). Putting both LEDs at the edges needs about **2.4x** (visible area about 1600 x 900).
2.4x is slightly above the lossless 2.0x limit (1600 x 900 source px stretched to 1920 x 1080 = 1.2x upscale, mild softness).
Best result: use 1.2x of OPTICAL zoom on the lens (about 16 -> 19-20mm, W/T lever) and then crop about 2.0x (1:1 pixels).

Crop-only starting point for 2.4x (visible 1600 x 900), estimated from the screenshot and centred between the LEDs, head lower-centre:
Left 980, Right 1260, Top 1110, Bottom 150 (horizontal total 2240, vertical total 1260). Move the picture sideways by trading Left against Right,
up/down by trading Top against Bottom (keep each pair's total the same). After using the lens zoom, redo the numbers with z about 2.0
(Left+Right 1920, Top+Bottom 1080) and re-centre.

## Result of the first try (v1.5.2)
Crop 980 / 1260 / 1110 / 150 on the new camera position puts the blue LED on the left edge and the red LED on the right edge, head slightly
left of centre. Horizontal framing matches the old VOD target almost exactly (clock about 11% across, M letter about 91%). Only the vertical
position differs, and the two old VOD frames differ from each other because each clone has its own framing:
- Before songs (head close-up): clock about 17.6% down the frame vs 22% now -> window down about 43 source px: Top 1150, Bottom 110 (Left 980, Right 1260).
- While playing songs (bass visible, about 2% wider): clock about 30% down -> window up about 69 px and slightly wider:
  Left 964, Right 1244, Top 1032, Bottom 210 (visible 1632 x 918).
Saved in OBS & Stream Files/SCENE/crop_presets.yaml. Each clone has its own Edit Transform, so enter these separately.
Check sharpness at 100% preview zoom, not the 56% window. For the best sharpness add about 1.2x optical zoom on the lens and crop about 2.0x instead.

## 16mm + crop vs 18mm + smaller crop (v1.5.3)
Clone mapping: "[CLONE] CLOSEUP CLEAN 2 2" = before playing (colour); "[CLONE] CLOSEUP CLEAN 2" = during playing (black and white).
User zoomed the lens to 18mm and reused the 16mm crops: too tight, both LEDs fell out of frame (18mm is about 1.1x bigger than 16mm,
so the crop zoom must drop from 2.4x to about 2.18x).
- Sharpness maths: 16mm needs a 1600 x 900 source slice stretched to 1080p (1.2x upscale). 18mm needs about 1760 x 990 (1.09x upscale).
  20mm would be about 1:1. So optical zoom is slightly sharper, but only by roughly 10-20% resolution.
- Repeatability: the PZ lens rests at 16mm and has no click stops, so 16mm + crop is exactly repeatable after any power-off; 18mm is not.
- Visible in the screenshots: grain and blotchy colour noise in the dark areas, which is a bigger quality limit than the 1.2x upscale.
  That is an exposure/lighting issue (Auto ISO, Steps 4 and 6).
- Recommendation: use 16mm + crop (presets in OBS & Stream Files/SCENE/crop_presets.yaml), compare at 1:1 using a windowed preview projector,
  and only switch to 18mm if the difference is clearly visible.

## Final 16mm crops (v1.5.4) and a note on the numbers
User-tuned: before playing 1010 / 1250 / 1130 / 95, during playing 1010 / 1250 / 1032 / 210. Both LEDs sit at the frame edges; head position matches the
old VOD frames. The visible windows are 1580 x 935 and 1580 x 918, slightly less wide than 16:9 (1580 x 889). With Cover the extra height is trimmed
equally top and bottom, so the picture really shown is Top 1153 / Bottom 118 and Top 1047 / Bottom 225. Nothing is stretched. Optional: type the
equivalent numbers so the fields match what you see.

## Delay / latency (v1.5.4)
Some lag on fast movement is normal for an HDMI capture chain (camera HDMI out, Cam Link, USB, OBS). Typical total is roughly 100-200 ms; 25 fps also adds 40 ms per frame.
- Source properties: set **Buffering** from Auto-Detect to **Disable** (lowest latency).
- Prefer a video format of NV12 if the dropdown offers it (less USB data than YUY2); leave hardware decoding off for this device.
- Do not fight the delay, match to it: delay the microphone/Rocksmith audio with Advanced Audio Properties -> Sync Offset until a clap is in sync.
  Measure by recording a clap on camera and comparing the video and sound spikes in the recording.
- 50 fps (1080p50, camera HD, no 4K crop) would feel more responsive but loses the 4K headroom for lossless zoom.

## Vertical (9:16) canvas, starting idea
A full-height 9:16 slice of the 4K frame is 1215 x 2160 source px and downsizes to 1080 x 1920 (sharp). Starting values centred on the head
(about 41% across the frame): Left 966, Right 1659, Top 0, Bottom 0. Needs the vertical canvas to be 1080 x 1920 (not yet confirmed) and its own
copy of the camera source with its own crop.

## Clones
[CLONE] sources follow the master Cam Link source size (now 4K), so each clone needs its own Fit to Screen / crop / Lanczos.
Vertical canvas (9:16): same idea, but the crop box must have a 9:16 shape; check source pixels still >= canvas pixels.

## Vertical canvas: setup for `[CLONE] Upload Cam` (v1.5.5)
Why it looks wrong now: the item is 3840x2160 with Cover bounds 3840x2160 and no crop, so it sits 1:1 on a 1080x1920 canvas and only the
top-left 1080x1920 of the 4K frame (door, hanger) is visible. Fit to Screen sizes it to 1920x1080 (the main canvas), so type the bounds by hand.
The dock preview is 9:16 (1080x1920 assumed; confirm in Settings -> Video, Vertical canvas).

Edit Transform (Ctrl+E) for the item in the Vertical scene:
- Position 0 / 0, Alignment top-left. Size fields are read-only results, leave them.
- Bounds type Cover, Bounds Width 1080, Height 1920, Crop Bounds ticked.
- Crop (source px), start values at 16mm: Left 1020, Right 1605, Top 0, Bottom 0 (visible 1215x2160, exactly 9:16, scale 0.889 = downscale, sharp).
- The window must be 9:16: Left+Right = 3840 - (Height * 9/16), where Height = 2160 - Top - Bottom.
- Slide sideways by trading Left against Right (same total 2625). Left 1020 puts the left LED strip (about x1023 in the source) right on the edge;
  raise Left to about 1070 and lower Right to 1555 if it shows as a bright stripe.
- Optional tighter version: Top 250, Bottom 0, Left 1020, Right 1746 (visible 1074x1910).

CORRECTION (v1.5.6): the "head is 39% of the width" estimate above came from a frame where you were leaning at the camera, and the claim that
the Short could not be matched was wrong. Measured on a seated frame, see below.

### Measured against the YouTube Shorts reference (v1.5.6)
User tried L1020 R1605 T250 B0 (1215x1910 window, a little wider than 9:16, so Cover trims about 70 px each side: real picture L1090 R1676).
- Glasses width: 14.7% of the frame now, 16.5% in the Short; face (cheek to cheek) 16.3% now, 19.2% in the Short. Zoom needed is about 1.15x.
- Glasses centre in the Short: 52% across, 47% down. Now: 51% across, 52% down (already centred sideways).
- Result for 1.15x: visible 934x1661 (exact 9:16), left 1145, top 465 -> **Left 1145, Right 1761, Top 465, Bottom 34**.
  Upscale from source is about 1.16x, like the horizontal clones, so still acceptable with Lanczos.
- Posture changes how it looks: leaning forward makes the head larger than in the sitting frame, so judge in your playing pose.
- Fine tuning: head too high/low -> trade Top against Bottom (keep sum 499); head left/right -> trade Left against Right (keep sum 2906).
  Zoom in or out -> keep the 9:16 rule: Left+Right = 3840 - (2160 - Top - Bottom) * 9 / 16.
