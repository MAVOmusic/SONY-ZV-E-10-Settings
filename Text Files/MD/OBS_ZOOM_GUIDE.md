# OBS 4K Cam Link: scaling and crop-zoom guide (v1.5.0)

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

## Starting point for the "LED lights at the edges" framing (from the 2026-10-16 screenshot)
In the positioned full-frame view the blue LED strip sat about 75 px from the left edge and the red one about 85 px from the
right edge of a 890 px wide preview (about 4.3 source px per preview px), so roughly z = 1.2.
Try: crop left 310, right 350, top 110, bottom 265 (horizontal total 660, vertical total 375). Adjust left/right until each LED is
at the edge, then keep (left+right)/3840 and (top+bottom)/2160 equal. Move the picture up/down by trading top and bottom crop.
This is an estimate read off a screenshot, fine-tune by eye.

## Clones
[CLONE] sources follow the master Cam Link source size (now 4K), so each clone needs its own Fit to Screen / crop / Lanczos.
Vertical canvas (9:16): same idea, but the crop box must have a 9:16 shape; check source pixels still >= canvas pixels.
