# CONTEXT.md — Sony ZV-E10 Streaming Setup (current, v1.10.1)

Last updated: 2026-10-18 (v1.10.1). This file is the single current-state summary.
It supersedes `AI_HANDOFF_CONTEXT.md` (v1.3-era, kept for history only — do not
trust its settings, branch notes, or "vision check" instructions).
Update this file on EVERY settings change, together with `SETUP_CHECKLIST.md`,
`Settings Files/YAML/current_settings.yaml`, `CHANGELOG.md`, `VERSION.txt`
and `README.md`.

## Rig (fixed — do not re-litigate)

- Camera: Sony ZV-E10 (original, PAL) + Sony E PZ 16-50mm f/3.5-5.6 OSS kit lens.
- Capture: Elgato Cam Link 4K, rear USB port. Power: USB-C PD wall adapter
  (WW07-G3b-PD, USB-C port only, other ports empty). Camera kept switched ON
  between streams so the power-zoom never retracts/resets (no true standby
  exists while USB-powered/HDMI-connected; Power Save Start Time = Off,
  Power Save by Monitor = Does Not Link).
- Host: Windows 10, OBS 32.1.2 portable, RTX 4060, Ryzen 5 8500G, 128 GB RAM.
- Plugins: Aitum Multistream 1.0.7 (Twitch = main; Kick and Blaze use
  "Main Encoder"), Aitum Vertical 1.6.3, obs-shaderfilter 2.4.3.
- Light: Elgato Key Light (original, firmware 1.0.3), 4700K, **44%**.
  **Its stand is broken/taped and fixed in place — NEVER suggest moving it.**
  Two RGB floor lamps via phone app: left blue, right red, both 28%.
- Cooling: fan on the camera; orange temperature icon disappears ~10 min
  after the fan is on. LCD flipped out.

## Final camera settings (Steps 1–7, done/nearly)

| Item | Value |
|---|---|
| Shoot Mode (Movie) | Manual Exposure |
| Shutter / Aperture / ISO | 1/50 (25p PAL) / F3.5 (16mm) / 500 fixed |
| White Balance | C.Temp./Filter, 4700K (4300K tested — no better) |
| Picture Profile | **Off** (ZV-E10 has PP1–PP10 only; **no PP11/S-Cinetone**) |
| Creative Style | Standard, Contrast/Saturation/Sharpness 0/0/0 |
| DRO/Auto HDR | Off (measured: no visible difference vs On — see lessons) |
| SteadyShot (Movie) | Off |
| 4K Output Select | HDMI Only (25p) |
| Focus | Continuous AF, Wide; AF Transition Speed 4; AF Subj. Shift Sens. 1 |
| Other | Airplane Mode On; Auto Power OFF Temp = High; HDMI Info Display Off; Zoom Range = ClearImage Zoom |

## OBS (final)

- Canvas/output 1920x1080 @ 25 fps PAL. Cam Link source: Custom
  3840x2160 @ 25, Lanczos (on every clone), Buffering **Disable**.
- Crops: `OBS & Stream Files/SCENE/crop_presets.yaml` (clones
  `[CLONE] CLOSEUP CLEAN 2 2` before playing, `[CLONE] CLOSEUP CLEAN 2`
  during playing; vertical values also there).
- Streaming: NVENC H.264, CBR 8000 kbps, keyframe 2 s, preset P5, High
  Quality, Two Passes (Quarter Resolution), Look-ahead On, Adaptive
  Quantisation On, B-frames 2. Test stream (v1.9.4): no dropped frames/lag.
- Recording: MKV, NVENC H.264 CQP 18, P5 (same tuning as above).
  Aitum Vertical recording uses these main settings (its greyed "mp4"/6000
  is a placeholder). Vertical canvas: black-and-white filter is
  **intentional** (may become "no filter" by default in Step 8).
- Sharpening: `OBS & Stream Files/SHADER/edge_aware_sharpen.shader`
  (Amount 2.0, Threshold 0.01, Radius 2.0) — confirmed working v1.9.6;
  keep it **first** in the filter list on each clone.
- Lyrics (v1.10.0): Rocksmith lyric line is shown via Chroma Key
  (#000000, all 1, Contrast −4) + Colour Correction (Gamma −3,
  Contrast 4, Saturation 5, Hue 180, Multiply #FFFF00) = yellow but
  blobby. New `OBS & Stream Files/SHADER/lyrics_karaoke.shader` is
  written to replace that pair on the RAW lyrics source (soft
  brightness key + de-speckle, flat yellow, highlight colour for
  coloured source pixels, dark outline/glow, optional Bold) —
  coloured source pixels, dark outline/glow, optional Bold) —
  OBS test 1: shader works, sung word came out green (highlight split
  live). Problem: Rocksmith's **dim history line** was keyed out —
  user wants it kept. Fixed in shader v1.10.1 (Threshold 0.12,
  De-speckle 0.25, History Opacity 0.6); re-test pending. Also: keep
  Crop/Pad above the shader / tight scene crop — it keys any bright
  pixel (note highway included). Guide:
  `Text Files/MD/LYRICS_SHADER_GUIDE.md`. A shader cannot add
  word-timing or make a line linger after Rocksmith removes it;
  that still comes from Rocksmith.

## Key findings / lessons (corrected — earlier wrong claims removed)

- No PP11/S-Cinetone on this camera. PP Off + Standard matches the
  reference black level; PP3–PP6 are flatter, PP7–PP10 are log/HLG.
- Measure brightness on the **forehead/cheeks, same pose**. The v1.7-era
  "face 2 stops darker than Chainbrain" claim was a wrong-region
  measurement; corrected: PP Off @ ISO 500 forehead ≈159 vs Chainbrain ≈163.
- DRO On vs Off: frame luma 43/40% near-black vs 44/41% — no visible
  difference. Earlier "DRO Off darkens the room" was wrong (pose/framing/
  lamps had changed). Face-brightness claims must be re-checked the same way.
- Chainbrain reference is 1080p**60** AV1/Opus on YouTube; our source is
  25 fps — motion smoothness differs, and that is not fixable at 4K/25p.
- Bitrate is not the limit: 8000 kbps @ 25 fps ≈ 3x the bits/frame of
  6000 kbps @ 60 fps.
- 4300K WB was no better than 4700K; Key Light was lowered 48% → 44%
  (v1.9.5, ≈ −0.1 stop — does not explain dimmer faces in single shots).
- Zoom: cropping a 1080p raster is what caused the old "480p" softness;
  cropping the 4K source is lossless to 2.0x, mild (1.2x upscale) at 2.4x.
- Repo size: screenshots are stored as JPG q88. The 11 Picture Profile
  PNGs became 2.7 MB total that way; in v1.9.7 the remaining 31 PNGs
  (53.6 MB) became 8.6 MB of JPG in `Image Files/JPG/`. Do not commit
  new large PNG screenshots — convert first. (.git history is unchanged;
  no history rewrite / force-push ever.)

## Files

- `README.md` — summary + final-settings table. `SETUP_CHECKLIST.md` —
  Steps 1–7 done or nearly; Step 8 (shader retune) started, waiting for
  the user's shader files + example pictures.
- `Text Files/MD/ZV-E10_STREAMING_GUIDE.md` — hand-over guide for others
  (no personal data). `OBS_ZOOM_GUIDE.md` — crop maths. `IMAGE_NOTES.md`
  — per-image descriptions/measurements.
- `Settings Files/YAML/current_settings.yaml` — per-version snapshots
  (append-only; old blocks are history, the last block is current).
- `Image Files/{Menus,JPG,JPG/Picture Profile Tests}` — menu photos,
  hardware/OBS screenshots (all JPG since v1.9.7), PP tests.
  `Image Files/PNG/` is now empty (kept via .gitkeep for structure).

## Never commit

DxDiag.txt, Msinfo32/About screenshots, Key Light photos and device
screenshot (serial/IP), Elgato Control Center screenshot, stream frames
showing chat names or sponsors, anything with the Windows username or
recording path. Record only sanitized facts. (Existing committed frames
pre-date this rule / were checked; new frames must be checked first.)

## Frame comparison (v1.9.7, measured — see IMAGE_NOTES.md)

v1.9.8 update: true fullscreen 1080p final-settings frames (Twitch,
Kick, Twitch close-up) were received and measured — NOT committed (chat
names + sponsor panel visible). Detail energy 999-1147 vs Chainbrain
973 (old pre-final frames: 689-792): the sharpness gap is closed.
Twitch ≈ Kick (Main Encoder confirmed). Remaining gap: face brightness
(front-on skin median ~67-68 vs Chainbrain ~100; pose/cap shadow
contribute) and 25 vs 60 fps — not bitrate. Also v1.9.8: the Aitum
Multistream Vertical Canvas YouTube encoder block (8000 CBR, keyframe
0, P5 — screenshot committed as JPG) is **dormant**: the user does not
stream from it and vertical recording uses the main horizontal settings.

## Pending

- User will add shader files (`OBS & Stream Files/SHADER/`) and example
  pictures → then Step 8: best-look settings per filter at the new
  exposure, filter list + where each is used, default (none vs B&W),
  GPU cost at 4K source size.
- Still open: optional Key Light diffusion / ISO 640 if the dimmer
  front-on face is to be lifted; OBS Stats after 10 min; plugin updates
  after a clean test stream. (Done v1.9.8: like-for-like fullscreen
  frame check; Aitum Multistream > Vertical Canvas screenshot.)
