# Reference Image Notes (visually checked, session 2026-10-16)

Descriptions below come from actually viewing the files. Image-to-filename mapping follows the
order the user attached them (Chainbrain, Camera Zoom In 1, Camera Zoom In 2, OBS Zoom In); the
repo copies are byte-identical (same MD5) to the re-uploaded files.

## Image Files/JPG/Chainbrain.jpg (1922x1079) - TARGET LOOK
- Twitch VOD screenshot: bearded man, black cap, over-ear headphones, plaid flannel, blue guitar.
- Wide framing, subject about 1/3 of frame; room (guitars, game shelves) stays readable.
- Sharp face and texture, clean low-noise shadows, neutral-to-warm skin tones, natural contrast.

## Image Files/JPG/Mavo (Camera Zoom In 1).jpg (1920x1080) - problem sample
- Bass-playing shot, subject mid-frame in front of a CD wall, with stream overlays (goals, request list).
- Face and beard look soft/smeared with blocky noise; strong red/orange rim light colours one side.

## Image Files/JPG/Mavo (Camera Zoom In 2).jpg (1919x1076) - problem sample
- Tighter, side-on crop (head turned), same CD wall, overlays unchanged.
- Skin and beard detail is soft and blocky; red/magenta cast on face and glasses from the rim light.

## Image Files/JPG/Mavo (OBS Zoom In).jpg (1918x1078) - problem sample
- Front-on, cap/headphones/glasses close to camera, overlays unchanged.
- Face is soft and low in detail, with dark shadows crushed and noisy.

## Image Files/JPG/Task Manager - Performance.jpg (1075x816)
- Task Manager GPU page: RTX 4060 at 46% 3D, 51 C, driver 32.0.15.6094 (2024-08-14). No identifiers.

## Hardware photos (viewed in v1.3.3)
- **Panel Out.jpg**: ZV-E10 on a tripod, lens facing left, LCD swung out ~90 degrees to the side of the body (screen reflects a hand-drawn sign), a braided grey cable with a metal plug in the side port (port cover open). CORRECTION (v1.3.4): this braided cable is the 4K micro-HDMI lead to the Cam Link, not the USB-C power cable (seen in the USB-C Connected photos). Confirms Step 1A (LCD out) only.
- **Back.jpg**: rear of the camera, LCD closed against the body and dark. Lots of dust/lint on the screen. A faint darker reddish rounded area on the left of the screen may be a reflection or retention; cannot tell from this photo (dedicated burnt-screen photo still missing).
- **Side.jpg**: power-zoom lever (W/T), E-mount marking, side port cover open with the braided HDMI lead plugged in (earlier note said USB-C; corrected v1.3.4).
- **Front.jpg**: lens E PZ 16-50mm f/3.5-5.6 OSS, 40.5mm filter thread, side port holds the braided HDMI lead (grey metal plug).
- **USB 10G Ports.jpg**: MSI rear I/O. Two red USB 10G ports (side by side) both empty here, a USB-C 20G port empty, USB 2.0 ports (two pairs) with cables plugged in, a cable in the USB 5G port above the 10G pair, ethernet LED lit.
- **Cam Link 4K Connected.jpg**: the Cam Link dongle (HDMI cable at the bottom left) points at the rear panel between the USB 5G port (holding another cable) and the visible right red 10G port, which is empty. The dongle hides the left 10G port, so it is most likely plugged into the LEFT red 10G port. Moderate confidence: the plug itself is not visible. USB 2.0 ports below carry other cables.
- **Cam Link 4K Model.jpg**: label shows model 20GAM9901 (Corsair Memory BV, made in Taiwan), USB-A 3.0 plug with blue tongues, HDMI IN on the other end. The serial number is blacked out in the committed copy.
- Cam Link 4K is USB 3.0 / 5 Gbps, so the faster 10G port gives no speed gain; what matters is avoiding USB 2.0 ports and shared hubs.

## Power / menu / retention photos (viewed in v1.3.4)
- **Power Temp-High.jpg**: LCD menu "Power Setting Option" page 1: Power Save Start Time = Off, Power Save by Monitor = Does Not Link, **Auto Power OFF Temp. = High**. Verified.
- **USB-C Connected 1.jpg**: side-angle of the camera, menu again showing Auto Power OFF Temp. High. Two cables in the side ports: top = thick black USB-C power cable, below = braided 4K micro-HDMI lead. Verified.
- **USB-C Connected 2.jpg**: black surge-protector strip with several adapters/PSUs (green LEDs on). A black adapter with a thin black USB-C cable in its front sits on the middle socket (looks like the phone fast charger). Its wattage is not readable in the photo.
- **Connector Alternative I've Found.jpg**: white UK plug-in adapter: 1x USB-C labelled PD/20W, 2x USB-A QC3.0, pass-through 13A socket.
- **...Found - Specs.jpg**: label: model WW07-G3b-PD, USB-C output 5V 3A / 9V 2.22A / 12V 1.67A (15W / 20W / 20W), USB-A same, **USB-C + USB-A together max 5V 3A**. Manufacturer LENCENT, BS 1363. Serial number blacked out in the committed copy.
- **Alternative USB-s On Extender.jpg**: wall-mounted white extension strip with 4 USB-A ports (one has a white cable), a PSU in one of its mains sockets. USB-A only, no PD - not suitable for powering the camera.
- **Menu Burnt Into Screen.jpg**: camera LCD (flipped out) running live view (1/50, F3.5, Auto ISO 320, 0:00 timecode) with a faint, semi-transparent ghost of the "Power Setting Option" menu text (Power Save Start Time / Power Save by Monitor "Does Not Link" / Auto Power OFF Temp.) showing through the live image. The live image and overlays update normally, so this is a faint ghost (image retention), not a frozen screen. Likely temporary on an LCD, but it could persist if static menus stay on for hours.
- **Shutter 1/50 and Auto ISO**: current exposure is Auto ISO (the "A" before ISO 320) and 1/50 s. 1/50 is the 180-degree value for 25 fps, which suggests the camera is on PAL (25p/50p), normal for the UK. Check NTSC/PAL Selector before Step 3/4: on PAL, "30 fps" is really 25 fps and the shutter rule is 1/50 (25p) or 1/100 (50p).

## Camera menu + OBS settings photos (viewed in v1.4.0)
- **ZV E-10 Zoom Range.jpg**: MENU > Camera Settings2 tab (page "Zoom" 6/9): Zoom Range = **ClearImage Zoom**, plus Zoom Lever Speed, Custom Key Z. Speed, Remote Zoom Speed. Step 2 setting is on.
- **ZV E-10 File Format.jpg**: File Format list; **XAVC S HD** is the selected option (XAVC S 4K not selected).
- **ZV E-10 4K Output Select.jpg**: options **Memory Card+HDMI** (selected) and **HDMI Only(25p)** (25p option appears because the camera is on PAL).
- **ZV E-10 HDMI Settings.jpg**: HDMI Resolution = Auto, **HDMI Info. Display = Off**, TC Output = Off, REC Control greyed, CTRL FOR HDMI = On.
- **OBS Cam Link 4K Settings 1.jpg**: Cam Link driver "Video Proc Amp" dialog: Brightness 0, Contrast 128, Hue 0, Saturation 128 (all defaults, Auto unticked); other controls greyed out.
- **OBS Cam Link 4K Settings 2.jpg**: OBS Video Capture Device properties: Resolution/FPS Type = **Device Default** (Resolution and FPS greyed, FPS "Match Output FPS"), Video Format Any, Colour Space Default, Colour Range Default, Buffering Auto-Detect, Flip Vertically off, Apply rotation data on.
- **OBS Cam Link 4K Settings 3.jpg**: lower part of the same dialog: Use hardware decoding off, Audio Output Mode = Capture audio only, custom audio device off.

## Take-aways for the checklist
- Target look = sharp, low-noise, evenly lit: supports Step 4 (low ISO, manual exposure) and Step 6 (more key light).
- The softness/noise in the problem samples is consistent with OBS crop-zoom and low light
  (see CONTEXT.md Issue A and Step F). This is a visual impression, not a measurement.

## Image Files/Menus/ (32 JPG, added by the user, reviewed v1.5.9)
Photos of every ZV-E10 menu page in Movie mode with HDMI connected. No EXIF, no serial numbers or network names visible (Network and Setup5 pages show only
menu items). Values read from them are in Settings Files/YAML/current_settings.yaml (camera_menus_verified_v1_5_9). Key ones: Main Menu After Edits
(1/50, F5.6, MM -1.0, ISO 400), Movie1 (Shoot Mode Manual Exposure), Movie3 (SteadyShot Off), Setup2 (4K Output Select HDMI Only(25p)),
Color-WB-Img. Processing1 (White Balance Auto, Picture Profile Off, Creative Style Standard).

## Image Files/JPG/Picture Profile Tests/ (11 JPG, v1.7.0)
OBS screenshots of the same scene at ISO 500, F3.5, 1/50, WB 4700K with Picture Profile Off and PP1-PP10 (converted from PNG, q88, to save repo size).
Measured on the main preview (luma 0-255): Off 60 (28% near-black), PP1 57, PP2 55, PP3 71 (5%), PP4 71 (5%), PP5 70 (1%), PP6 68 (1%), PP7 44, PP8 60, PP9 61, PP10 62.
Face luma numbers in the first version of this note were measured on the wrong region and were removed (v1.8.0). Chainbrain reference: whole frame luma 59 (28% near-black), face luma about 163. With the right region, PP Off at ISO 500 has forehead luma about 159.

## Frame comparison by measurement (v1.9.7, Pillow/NumPy in /tmp/venv)

All files below are the JPG (q88) copies made in v1.9.7. Method: luma
(Rec.709) mean, % pixels <16 (near-black), Laplacian variance (detail-energy
proxy — higher = more fine detail, but also more noise; only comparable at
the same scale), face patches on forehead/cheeks. Global numbers are NOT
like-for-like across different rooms/overlays; use them as orders of magnitude.

| Frame | Size | Luma | Near-black | Lap. var. |
|---|---|---|---|---|
| Chainbrain.jpg (reference, Twitch VOD frame) | 1922x1079 | 58.5 | 24.3% | 973 |
| Mavo (OBS Zoom In).jpg (old, pre-final) | 1918x1078 | 51.1 | 32.0% | 689 |
| Mavo (Camera Zoom In 1).jpg (old) | 1920x1080 | 67.7 | 26.7% | 792 |
| Mavo (Camera Zoom In 2).jpg (old) | 1919x1076 | 64.5 | 23.7% | 755 |
| Final PP Off OBS preview crop (proxy, not a stream frame) | 1090x590 | 58.6 | 26.1% | 481* |

*Preview crop is shown at 56% in OBS, so its Laplacian is downscaled and
not comparable to the fullscreen rows — do not conclude "final is softer".

Face patches (same-pose caveat applies; poses differ, so treat as hints):
Chainbrain cheek luma ~138; final PP Off cheek ~89-95, forehead ~135
(this session's patches) — vs the trusted earlier forehead measurement
of ~159 (PP Off, ISO 500) vs Chainbrain ~163 recorded in v1.8.0. The
difference is patch placement/pose, which is exactly why the rule is
"forehead/cheeks, same pose". Old Mavo (OBS Zoom In) face patches were
far darker (~21-42) — that frame is pre-final (OBS crop-zoom, auto era).

Conclusions: (1) the old fullscreen frames have ~25-40% less detail energy
and (OBS Zoom) more crushed blacks than the reference — consistent with
the diagnosed crop-zoom/low-light cause, now fixed in settings; (2) no
true fullscreen 1080p final-settings stream frame exists in the repo yet,
so a final like-for-like verdict is still pending (Step 7 item stays open);
(3) remaining known reference gaps are frame rate (60 vs 25) and codec
(AV1 vs H.264), not bitrate.

## Fullscreen stream frames vs Chainbrain (v1.9.8, measured, frames NOT committed)

Three true fullscreen frames received 2026-10-18 (Twitch front-on,
Kick front-on, Twitch close-up/profile). They show chat names and a
sponsor panel, so per the never-commit rule only measurements are
recorded here; the PNGs were not added to the repo.

| Frame | Size | Luma | Near-black | Lap. var. | Skin median / top-quartile luma |
|---|---|---|---|---|---|
| Chainbrain.jpg (reference) | 1922x1079 | 58.5 | 24.3% | 973 | ~100 / ~175 |
| New Twitch (front, playing) | 1920x1080 | 44.6 | 38.0% | 1147 | 68 / 112 |
| New Kick (front, playing) | 1915x1080 | 44.3 | 37.8% | 1095 | 67 / 113 |
| New Twitch close-up (profile) | 1919x1078 | 48.4 | 30.7% | 999 | 90 / 120 |
| Old Mavo fullscreen (pre-final, for contrast) | ~1920x1080 | 51-68 | 24-32% | 689-792 | — |

Method as v1.9.7 (Rec.709 luma, Laplacian variance). Skin = skin-mask
pixels (R>G>B, R-B>20, luma 40-220) in the subject box; median is the
robust face-brightness figure, top quartile approximates lit forehead.

Findings:
1. **Detail/sharpness gap is closed.** New frames' detail energy
   (999-1147) matches/exceeds Chainbrain (973) and is ~40-60% above the
   old pre-final frames (689-792). Caveat: overlays/game highway add
   edges; mid-shelf-only detail is 850-921 (Twitch/Kick) — still in the
   reference's range for a different room. No encoder change justified.
2. **Twitch ≈ Kick.** Near-identical luma, skin and detail confirm Kick
   via "Main Encoder" delivers the same picture; platform is not a factor.
3. **Remaining gap is face brightness, not sharpness/bitrate.** Front-on
   skin median ~67-68 vs Chainbrain ~100 (~0.6 stop; cap shadow and pose
   contribute — the closer profile frame reads 90). Whole frames are
   also darker/more contrasty (near-black 38% vs 24%), but rooms,
   clothing and overlays differ, so that row is indicative only.
   Already-pending options (ISO 640, Key Light diffusion) address this;
   raising bitrate would not.
4. Unchanged known gaps: 25 fps vs reference 60 fps, H.264 vs AV1.

## Aitum Multistream > Vertical Canvas — YouTube outputs (v1.9.8)

Screenshot received (committed as JPG q88: `Image Files/JPG/Aitum
Multistream - Vertical Canvas YT Settings.jpg`; the BASS output's
Advanced Settings shown): NVENC H.264, FPS "25 Original", Rescale
Output off, CBR 8000 kbps, keyframe 0 s (auto), P5 Slow (Good Quality),
High Quality tuning, Two Passes (Quarter Resolution), profile high,
Look-ahead on, Adaptive Quantisation on, B-frames 2.
**User clarification (v1.9.8): he does not stream from the vertical/YT
outputs, and Aitum Vertical recording uses the main OBS horizontal
settings.** So this encoder block is dormant: it does not affect the
Twitch/Kick horizontal streams or the vertical recordings, its
keyframe 0 (vs main 2 s) needs no fix, and no settings change follows.
