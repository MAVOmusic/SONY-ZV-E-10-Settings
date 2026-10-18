# Sony ZV-E10 Streaming Setup Checklist

Tick each step as completed. Update VERSION.txt and CHANGELOG.md when a setup is completed.

## Step 1 — Thermal & Power Management (24h operation)
_Update v1.3.5: camera USB-C now on the WW07-G3b-PD adapter's USB-C port, shows charging. Region confirmed PAL (25p/50p)._
- [x] Flip LCD screen out 90-180 degrees from body (done; photo verified v1.3.3: LCD swung out ~90 degrees to the side; Image Files/JPG/ZV E-10 Panel Out.jpg)
- [x] Menu -> Setup (Yellow Toolbox) -> Power Option -> Auto Power OFF Temp. -> HIGH (photo verified v1.3.4: menu shows Auto Power OFF Temp. = High; Image Files/JPG/ZV E-10 Power Temp-High.jpg)
- [x] USB-C cable to dedicated USB-C PD wall adapter (not motherboard port) (photos verified v1.3.4: black USB-C cable in the side port, adapter on surge strip; alt connector WW07-G3b-PD is PD 20W max - USB-C + USB-A share 5V 3A, so keep its other ports empty; Image Files/JPG/ZV E-10 USB-C Connected 1/2.jpg)

## Step 2 — Zoom Memory & Quality
- [x] Keep camera switched ON (USB-C PD powered) between streams; do not power it off (no true standby exists while USB/HDMI connected) - agreed with user v1.4.0
- [x] MENU -> Camera Settings2 -> Zoom Range -> ClearImage Zoom (photo verified v1.4.0: Zoom Range = ClearImage Zoom; about 1.5x in 4K, 2x in HD)
- [ ] (Optional, deferred) Upgrade to manual zoom lens (Sigma 18-50 f/2.8 / Tamron 17-70 f/2.8) - user plans to price on Amazon UK later
_Step 2 core items complete in v1.4.0._

## Step 3 — OBS & Cam Link 4K
- [x] Cam Link 4K plugged into REAR 10G (red) port (upgraded from 5G blue) — photo viewed v1.3.3: Cam Link sits next to the right 10G port, most likely in the hidden left 10G port; Image Files/JPG/Cam Link 4K Connected.jpg / USB 10G Ports.jpg. Note: Cam Link 4K is USB 3.0 (5 Gbps), so 10G gives no extra speed - rear 5G/10G are equally fine
- [x] Menu -> Setup -> HDMI Settings -> HDMI Info. Display -> OFF (photo verified v1.4.0; HDMI Resolution Auto, TC Output Off, CTRL FOR HDMI On)
- [x] (user-reported v1.5.0; screenshots show 4K source at 100% scale and 25.00/25.00 FPS; Lanczos set) OBS source: Custom, 3840x2160, FPS = 25 (PAL, match the camera; no 60 on 4K)
- [x] Menu -> Setup (Setup2) -> 4K Output Select -> HDMI Only(25p) (photo verified v1.5.9: Setup2 shows HDMI Only(25p); File Format and Record Setting are greyed out in Movie1, which is expected because HDMI Only does not record to the card). Proxy Recording = Off (Movie2)

## Step 4 — Exposure & Sharpness (Manual) - DONE v1.6.0 (final ISO to be confirmed by the user)
Baseline (v1.5.8 photo, all auto): 1/25, F3.5, Auto ISO 250, Key Light 4700K 48%.
- [x] Movie Shoot Mode = Manual Exposure (MENU -> Camera Settings2 -> Movie1 -> Shoot Mode; the still 'Shoot Mode' in Camera Settings1 stays Intelligent Auto, irrelevant)
- [x] Shutter 1/50 (25p PAL) - photo v1.5.8/1.5.9
- [x] Aperture F3.5 (user-reported v1.6.0; consistent with the screenshot: ISO 250 at F3.5 looks like ISO 640 at F5.6 did)
- [x] ISO fixed (MENU -> Camera Settings1 -> Exposure -> ISO). At ISO 250 the OBS screenshot was dim (frame mean luma 37, 47% near-black); ISO 500 gives frame luma 60 and a forehead luma of about 159, matching Chainbrain (frame 59, face about 163). ISO 500 is the final value. (CORRECTION v1.8.0: the earlier face luma numbers were measured on the wrong image region.)
- [x] White Balance 4700K (user-reported; MENU -> Camera Settings1 -> Color/WB/Img. Processing1 -> White Balance -> K)
- [x] Movie SteadyShot Off (MENU -> Camera Settings2 -> Movie3 -> SteadyShot)
- [x] OBS main source Sharpen filter removed (user)
- Key Light 4700K 48% (eye comfort); keep or lower.
- Dial/Wheel Setup (Camera Settings2 -> Custom Operation1): wheel Tv / dial Av; the aperture was stuck at F5.6 until fixed by the user.
- Note: Auto Slow Shutter is On (Movie2) but has no effect in Manual Exposure.

## Step 5 — Color Profile - DONE v1.7.0
Result of 11 screenshots (ISO 500, F3.5, 1/50, WB 4700K; Image Files/JPG/Picture Profile Tests). The ZV-E10 has only PP1-PP10, no PP11 / S-Cinetone (Sony help guide; PP11 is on the ZV-E10 II).
- [x] Picture Profile OFF, Creative Style Standard (kept, Contrast 0, Saturation 0, Sharpness 0). Menu: MENU -> Camera Settings1 -> Color/WB/Img. Processing1 -> Picture Profile = Off
- Why: PP Off keeps the same black level as the Chainbrain reference (28% near-black pixels in both), good contrast and colour. PP3/PP4 lift the shadows (5% black) and look flatter; PP5/PP6 (Cine1/Cine2) are flat (1% black); PP7-PP10 are S-Log2/S-Log3/HLG for grading, they look washed out in OBS. PP1/PP2 are slightly darker than Off.
- [x] WB cooler 4300K tried by the user in Step 6: no useful change, 4700K kept

## Step 6 — Lighting - DONE v1.8.0
- [x] Key Light = Elgato Key Light (original), firmware 1.0.3, 4700K 48% -> user kept the brightness at 48% (eye comfort); stand is taped and cannot be moved. No extra light needed: forehead luma 159 vs Chainbrain about 163 at ISO 500, F3.5, 1/50
- [x] WB: 4300K tested by the user, 4700K measured basically the same (forehead B/R 0.60 vs 0.63); either is fine, 4700K matches the light
- [x] Thermal (user): fan on the camera tripod, Airplane Mode On (Network1). Monitor Brightness is greyed out. Orange temperature icon seen in the v1.5.10 photos; user: it disappeared about 10 minutes after the fan was turned on (v1.9.0). Keep watching it on long streams; tell me if it turns red
- [x] LED floor lamps (left blue, right red; phone app, Bluetooth) both at 28%. At 28% the shelf is neutral enough (shelf B/R 0.82); no change needed. Colours/brightness can be tuned in the app
- [ ] (optional, later) Faster lens for more light and no zoom reset: Sigma 16mm f/1.4 (about 2.6 stops more light, same 16mm view, same crops) or an f/2.8 zoom (only about 0.6 stop; corrected in v1.9.0)

## Step 7 - Picture quality fine-tuning (IN PROGRESS, started v1.9.0)
Goal: close the "Chainbrain video looks cleaner" gap. The Vertical canvas keeps the black-and-white filter on purpose (user, v1.9.0).
- [x] Heat: orange temperature icon gone about 10 minutes after the fan (user)
- [x] Like-for-like check (v1.9.8): true fullscreen 1080p Twitch/Kick/close-up frames measured vs Chainbrain (frames NOT committed - chat/sponsor visible; numbers in IMAGE_NOTES.md). Detail Lap. var. 999-1147 vs Chainbrain 973 (old pre-final 689-792): sharpness gap closed. Twitch = Kick (Main Encoder). Remaining: face brightness (~0.6 stop front-on, pose/cap contribute) and 25 vs 60 fps, not bitrate. Still nice-to-have: a 100% (1:1) screenshot of the full 4K source (OBS preview at 100%)
- [x] OBS Settings -> Video (screenshot v1.9.1): base 1920x1080, output 1920x1080, 25 PAL; downscale filter n/a because the resolutions match. Correct, no change
- [x] OBS Settings -> Output -> Streaming (screenshot v1.9.1): NVENC H.264, CBR 8000 kbps, keyframe 0 (auto), P4 Medium, High Quality tuning, Two Passes (Quarter Res), profile high, B-frames 2, Look-ahead OFF, Adaptive Quantisation OFF, Rescale Output off. 8000 kbps at 25 fps is generous (about 320 kbit per frame vs about 100 for 6000 kbps at 60 fps), so bitrate is not the limit.
- [ ] Recommended change (not applied yet): Keyframe interval 2 s; Preset P5 (or P6); Look-ahead ON; Adaptive Quantisation ON; Multipass Full Resolution optional. Check GPU load and dropped frames after (revert to P4 if the GPU struggles)
- [x] Output -> Recording (screenshot v1.9.2): Standard, MKV, video encoder = (Use stream encoder) = same NVENC H.264 CBR 8000 kbps, AAC, audio track 1 only, file into a dated folder on the Desktop. Works, but a separate recording encoder is better for YouTube (and allows Pause)
- [ ] Recommended (not applied): Recording video encoder = NVIDIA NVENC H.264, Rate Control CQP about 18, preset P5, keep MKV (remux to MP4 for editing)
- [x] Aitum Multistream 1.0.7 (v1.9.2): Kick and Blaze both use 'Main Encoder', so they get the same picture as Twitch and no extra GPU load; the OBS Output changes apply to all three
- [x] Aitum Vertical 1.6.3 Recording tab (v1.9.2): 6000 kbps, start/stop with main recording, 'Use main OBS settings' ticked (stream encoder). Not seen yet: Vertical Streaming tab (resolution, FPS, bitrate). Optional: raise the vertical recording bitrate to 8000
- [x] Aitum Multistream > Vertical Canvas screenshot received (v1.9.8, JPG in Image Files/JPG): YouTube outputs (BASS/Diablo II) = NVENC H.264, 25 Original, CBR 8000, keyframe 0 (auto), P5, High Quality, Two Passes Quarter, Look-ahead + AQ on, B-frames 2. DORMANT per user: he does not stream from these outputs and vertical recording uses the main OBS horizontal settings, so no change (incl. keyframe) is needed. Earlier Aitum Vertical > Streaming fields (v1.9.3, 6000/Ultra Low Latency) are likewise not in use
- [ ] Do not update Aitum (Multistream 1.0.8 and Vertical 1.6.6 are available) before the test stream, so the comparison stays clean
- [x] Chainbrain frame rate (YouTube Stats for nerds, v1.9.2): 1920x1080 @ 60 fps, AV1 (av01) video, Opus audio. His video is 60 fps; ours is 25 fps, so motion smoothness is a real difference. Our 4K source is limited to 25p
- [ ] OBS camera source: Buffering Disable, NV12 if offered, Lanczos on every clone incl. the vertical one
- [ ] OBS Stats dock: skipped / missed / dropped frames after 10 minutes
- [x] Camera menus read from the existing photos (v1.9.2): Focus Mode Continuous AF and Focus Area Wide (Camera Settings1 -> AF1, page 4/11); AF Transition Speed 7 (Fast) and AF Subj. Shift Sens. 5 (Responsive) (Camera Settings2 -> Movie2); DRO/Auto HDR = D-Range Optimizer (Camera Settings1 -> Color/WB/Img. Processing1, page 8/11; level not visible); Soft Skin Effect Off
- [x] Applied by the user (photos v1.9.3): AF Transition Speed 4, AF Subj. Shift Sens. 1 (Locked on); DRO/Auto HDR = Off; White Balance = C.Temp./Filter. Watch the next stream for focus hunting
- [x] DRO On retest (v1.9.4, OBS shot 'DRO On 44Light'): frame luma 43, 40% near-black = same as DRO Off (44/41). DRO makes almost no visible difference in these shots; the darkening I blamed on DRO was wrong (pose, framing and lights changed). Keep Off (nothing changes mid-stream) or On, user choice. Cheeks now about 71-80 luma vs about 93 before: face is dimmer in this shot (lights or pose). Earlier note: DRO Off test result (OBS screenshot v1.9.3): frame luma 44 and 41% near-black (before: 50/36% with DRO on and lamps 28%; original PP Off shot 59/30%; Chainbrain 59/28%). Cheek luma about 93, basically unchanged. DRO Off makes the room darker and more crushed, the face does not change -> recommended: DRO back On (D-Range Optimizer, Auto), or keep Off with ISO 640 and lamps 35-40%
- [x] Test stream done (user, v1.9.4): all OBS output/recording settings applied (keyframe 2 s, P5, Look-ahead, Adaptive Quantisation, recording encoder), no dropped frames, no lag, no crash. Frames received: close-up, Kick, Twitch (1080p) and MKV long/Shorts
- [x] Key Light was lowered to 44% (4700K) for the 'DRO On 44Light' shot (was 48%): about -0.1 stop, so it does not explain the whole dimmer face (v1.9.5)
- [x] Recording (screenshot v1.9.5): MKV, NVENC H.264, CQP 18, P5, High Quality, Two Passes Quarter, Look-ahead and AQ on, B-frames 2, keyframe 0 (auto). Aitum Vertical recording uses the main OBS settings (its greyed 'mp4' is only a placeholder; files are MKV)
- [x] Sharpness v2 WORKS (v1.9.6): black-and-white test passed, boost map shows boost only on edges (glasses, beard, text, CD covers) and flat skin/hoodie stay grey; close and far results at 100% show natural skin detail, no visible halos or added noise. Defaults Amount 2.0 / Threshold 0.01 / Radius 2.0 kept. Tuning: more bite = Amount 2.5-3 and Threshold 0.008; gritty skin or shadow noise = Threshold 0.015. Earlier note: Sharpness v2 (v1.9.5): the first test showed no visible change. Reasons: on a 4K source the per-pixel detail is tiny (threshold 0.03 removed it) and the preview was at 56%. Shader updated: defaults Amount 2.0, Threshold 0.01, Radius 2.0, plus TEST grayscale and boost-map switches. Test at 100% preview
- [ ] (history) Sharpness: Sharpen filter adds noise. New filter `OBS & Stream Files/SHADER/edge_aware_sharpen.shader` (threshold + shadow protect), to be tested by the user in ShaderFilter on each clone. Also need same-size fullscreen 1080p stream screenshots (current ones are scaled player windows) for a fair stream-vs-recording comparison
- [ ] Light: optional diffusion over the Key Light panel (smoother skin); ISO 640 if the face looks dim
- [ ] Optional: local recording at CQP/high bitrate for YouTube; faster lens later

## Maintenance (v1.9.7)
- [x] Repo size: 31 PNG screenshots (53.6 MB) converted to JPG q88 (8.6 MB) in Image Files/JPG, PNG originals deleted (working tree only, no history rewrite). Working tree now ~21 MB (plus 64 MB .git history)
- [x] CONTEXT.md rewritten fully (stale since ~v1.5); AI_HANDOFF_CONTEXT.md is superseded history
- [x] Frame comparison measured (see Text Files/MD/IMAGE_NOTES.md v1.9.7): old fullscreen Mavo frames have 25-40% less detail energy than Chainbrain; NO true fullscreen 1080p final-settings stream frame in repo yet, so the Step 7 like-for-like item below stays open

## Step 8 - ShaderFilter retune (STARTED v1.9.6, waiting for the filter list)
25+ ShaderFilter looks were made for the old look. After Step 7 is final, re-check each against the new black level, brightness and colour.
- [x] Lyrics look identified (v1.10.0, screenshots JPG in Image Files/JPG): Rocksmith lyrics source uses Chroma Key (#000000, Similarity/Smoothness/Spill 1, Contrast -4) + Colour Correction (Gamma -3, Contrast 4, Saturation 5, Hue Shift 180, Multiply #FFFF00) (+ a disabled Chroma Key 2). Result is blobby/semi-transparent because black-only keying + extreme gamma/contrast crush the anti-aliased letters
- [x] New `OBS & Stream Files/SHADER/lyrics_karaoke.shader` written (v1.10.0) to REPLACE that pair on the raw lyrics source: soft brightness key + de-speckle, flat yellow text, Highlight colour for coloured source pixels (game sung-syllable highlight), dark outline + glow, optional Bold for Shorts. Simulation preview: Image Files/JPG/Lyrics Shader - Simulated Preview.jpg; guide: Text Files/MD/LYRICS_SHADER_GUIDE.md
- [x] USER TEST 1 in OBS (v1.10.0, screenshots JPG: Lyrics Shader In Action / Lyrics Shader Settings): shader loads and runs; highlight split confirmed live - sung word "look" rendered green, rest yellow. Two problems: (1) Rocksmith's DIM previous/next line was deleted by Threshold 0.25/De-speckle 0.5 - user wants that history line kept; (2) shader was running on the full game frame (Filters preview shows the note highway painted) - it keys any bright pixel, so Crop/Pad must sit above it / tight scene crop kept
- [x] Fixed in lyrics_karaoke.shader v1.10.1: Threshold 0.12, Softness 0.5, De-speckle 0.25, new History Opacity 0.6 (dim line kept, fainter outline; History Opacity 0 = old delete behaviour). Simulation preview regenerated (dim history line visible). Guide updated with the crop warning
- [ ] USER TEST 2: reload the shader file in the filter (or restart OBS), confirm History Opacity slider exists (proves v1.10.1 loaded), sing a full song: main line solid + history line present but secondary, at 100%/fullscreen/vertical. Tune only Threshold in 0.02 steps / History Opacity. A shader cannot make a line linger after Rocksmith removes it (no previous-frame access) - tell the agent if that temporal hold is what you meant, it needs a different tool
- [ ] List all filters and where each is used (horizontal clone, vertical clone, which song type)
- [ ] Decide the default (no filter by default, or black-and-white)
- [ ] Retune each filter at the final exposure; test on YouTube-style output
- [ ] Check GPU cost (shaders run at the source size: 4K source costs more than 1080p)

