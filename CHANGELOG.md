# Changelog

## [1.9.8] - Vertical YT settings recorded (dormant), fullscreen frames measured vs Chainbrain
- Aitum Multistream > Vertical Canvas screenshot received and committed as JPG q88 (Image Files/JPG/Aitum Multistream - Vertical Canvas YT Settings.jpg): NVENC H.264, 25 Original, CBR 8000, keyframe 0 (auto), P5, High Quality, Two Passes Quarter, Look-ahead + AQ on, B-frames 2. User clarification: he does not stream from the vertical/YT outputs and vertical recording uses the main OBS horizontal settings - so this block is dormant, affects nothing, and its keyframe 0 needs no fix.
- First true fullscreen 1080p final-settings stream frames measured (Twitch, Kick, Twitch close-up; NOT committed - chat names/sponsor visible, measurements only in IMAGE_NOTES.md): detail energy Lap. var. 999-1147 vs Chainbrain 973 and old pre-final 689-792 - the sharpness/detail gap is closed. Twitch and Kick are virtually identical (Main Encoder confirmed). Remaining gap is face brightness (front-on skin median ~67-68 vs Chainbrain ~100, pose/cap shadow contribute; close-up 90) and 25 vs 60 fps - not bitrate. Step 7 like-for-like item ticked.

All notable changes to this repository are documented here.
Versioning: MAJOR.MINOR.PATCH. Bump on each completed setup step.

## [1.9.7] - PNG->JPG conversion, CONTEXT.md rewrite, frame comparison measured
- Repo size: all 31 PNGs in Image Files/PNG (53.6 MB) converted to JPG q88 in Image Files/JPG (8.6 MB total, same basenames), PNG originals deleted from the working tree. No git history rewrite, no force-push (.git stays 64 MB). References in IMAGE_NOTES.md / OBS_ZOOM_GUIDE.md updated; Image Files/PNG kept as empty folder.
- CONTEXT.md rewritten fully (was stale since ~v1.5): current rig, final settings, OBS, lessons/corrections, never-commit list, pending Step 8. AI_HANDOFF_CONTEXT.md marked superseded there.
- Frame comparison by measurement (Pillow/NumPy): Chainbrain reference luma 58.5, 24.3% near-black, Laplacian var. 973; old fullscreen Mavo frames luma 51-68, 24-32% near-black, Lap. var. 689-792 (pre-final settings). Final-settings OBS preview is at 56% scale, so not like-for-like; no true fullscreen 1080p final stream frame in repo yet - Step 7 item remains open. README Key Light corrected 48% -> 44%.

## [1.9.6] - Sharpen filter confirmed, Step 8 started
- User confirmed the black-and-white test (shader runs). Boost map: sharpening only on real edges, flat skin and shadows untouched. Close and far shots at 100%: natural detail, no halos or added noise. Step 7 sharpness item done.
- Step 8 (ShaderFilter retune) started: need the list of the 25+ filters and the shader files.

## [1.9.5] - Shader v2
- User test: edge_aware_sharpen loads without errors but no visible change (screenshots at 56% preview, Threshold 0.015, Radius 1). Cause: on a 4K source the per-pixel detail is far below the old threshold, and a 56% preview hides the effect. A proxy test on a soft 4K-like frame: old defaults +14% edges; Amount 2 / Threshold 0.01 / Radius 2 gives +57% with noise unchanged.
- Shader v2: new defaults and two test switches (black and white, boost map).
- '44Light' = Key Light 44% at 4700K (was 48%). Recording settings read: CQP 18 NVENC, applies to Aitum Vertical too.

## [1.9.4] - Test stream, sharpness
- User applied all OBS output/recording settings and streamed: no dropped frames, lag or crash.
- DRO retest: DRO On and Off give almost the same frame stats (43/40% vs 44/41%). My earlier claim that DRO Off darkened the room was wrong; framing, pose and lights changed between shots.
- Sharpness: the recording frame has about twice the fine-detail energy of the Twitch/Kick frames in the same shelf region (Laplacian variance 218 vs 106-126), but the stream screenshots are scaled player windows, so the number is only a hint.
- New `OBS & Stream Files/SHADER/edge_aware_sharpen.shader` (ShaderFilter): luma-only, noise threshold, shadow protect, halo limit. Numpy simulation: dark-area noise unchanged, edges +36%; built-in style sharpen: noise +28%. HLSL untested in OBS.
- Stream frames not committed (viewer chat names and sponsor panel visible); only measurements were recorded.

## [1.9.3] - Camera AF/DRO applied, vertical encoder read
- User applied AF Transition Speed 4, AF Subj. Shift Sens. 1 and DRO Off (photos verified). OBS shot with a cap: frame luma 44, 41% near-black (more crushed than before); face unchanged. Recommendation: DRO back On, or ISO 640 plus brighter lamps if DRO stays Off.
- Aitum Vertical streaming fields (NVENC H.264 6000 kbps, tuning Ultra Low Latency) are controlled from Aitum Multistream > Vertical Canvas; to be checked there. Added the new OBS screenshot (JPG).

## [1.9.2] - Recording, multistream and Chainbrain stats
- Recording tab: MKV using the stream encoder (NVENC H.264 CBR 8000 kbps). Recommended a separate CQP recording encoder.
- Aitum Multistream (Kick, Blaze) use the Main Encoder; Aitum Vertical records at 6000 kbps with the main settings. Both plugins have updates, to be done after the test stream.
- Chainbrain YouTube stats: 1080p60, AV1/Opus. Our source is 25 fps, so smoothness differs.
- Camera: AF Transition Speed 7 and AF Subj. Shift Sens. 5 (fast and responsive) found in the Movie2 menu photo; recommend slower, locked-on values. DRO location documented.
- The recording folder path is not recorded (it contains the Windows user name).

## [1.9.1] - OBS output settings reviewed
- OBS Video and Output (Streaming) screenshots read: 1080p25 canvas, NVENC H.264 CBR 8000 kbps, keyframe auto, P4, Look-ahead and Adaptive Quantisation off. Video settings are correct. Recommended: keyframe 2 s, P5/P6, Look-ahead and Adaptive Quantisation on (not applied yet).
- Multistream uses Aitum Multistream (Twitch main; Kick and Blaze clone it). The vertical view is Aitum Vertical (not the plain OBS dock).
- Finding: at 25 fps, 8000 kbps is about 3x the bits per frame of 6000 kbps at 60 fps, so bitrate is not the cause of the quality gap.

## [1.9.0] - Step 7 started, README and hand-over guide
- README rewritten (final settings table, file list, working rules: update the docs on every edit).
- New shareable guide `Text Files/MD/ZV-E10_STREAMING_GUIDE.md` (no personal data) for others with the same camera.
- Checklist: Step 7 (picture quality fine-tuning) and Step 8 (ShaderFilter retune) added. Step 3 FPS text fixed (25, not 30). f/2.8 zoom figure corrected (about 0.6 stop, not 1.3).
- User: temperature icon disappeared about 10 minutes after the fan; Vertical black-and-white is intentional.
- Chainbrain 2 screenshot reviewed, not committed (chat names). Bitrate guidance (Twitch about 6000 kbps CBR, YouTube higher) comes from third-party summaries, to be confirmed against the platform docs.

## [1.8.1] - LED lamps recorded
- Left and right LED floor lamps are controlled by a phone app (Bluetooth): both at 28%, left blue, right red. New OBS shot (ISO 500, PP Off, 4700K, lamps 28%): frame luma 50, forehead luma about 135 (sitting closer, slightly dimmer than the earlier 159); shelf neutral. Optional ISO 640 if the Key Light stays at 48%.

## [1.8.0] - Step 6 complete (lighting); correction
- CORRECTION: the v1.7.0 claim that the face was about 2 stops darker than Chainbrain came from measuring the wrong image region. Re-measured on the forehead: 159 (ISO 500, PP Off, 4700K) vs about 163 for Chainbrain, so ISO 500 is right and no extra light is needed. Wrong numbers removed from the notes.
- User photos of the Key Light setup: Elgato Key Light stand is taped and cannot move. Brightness stays at 48%. WB 4300K tested; no meaningful difference from 4700K.
- Photos and the Key Light device screenshot (serial number, IP) were NOT committed: they show a serial number, an IP address, personal folder names on the monitors and names on the whiteboard. Only firmware 1.0.3 and the model were recorded.
- Fan on the camera and Airplane Mode On recorded. Orange temperature icon still to be checked in a long run. Optional: lower the red LED strip, faster lens later. Added the 4300K screenshot (JPG).

## [1.7.0] - Step 5 complete (colour profile)
- Tested Picture Profile Off and PP1-PP10 at ISO 500 (11 screenshots, stored as JPG). No PP11 on the original ZV-E10 (earlier advice was wrong; fixed).
- Decision: Picture Profile Off, Creative Style Standard. Matches the Chainbrain black level; PP3-PP6 are flatter, PP7-PP10 are log/HLG.
- ISO 500: frame luma 60 vs Chainbrain 59. (The face-brightness claim originally written here was wrong, see 1.8.0.)

## [1.6.0] - Step 4 complete (exposure)
- User fixed the aperture to F3.5, ISO 250, WB 4700K, shutter 1/50, SteadyShot Off, Manual Exposure; fan on the camera, Airplane Mode On. Monitor Brightness is greyed out.
- Measured the OBS screenshot: clean at ISO 250 but face about 1 stop under (luma 75/255; 47% of pixels near black). Recommended ISO 500 (max 640). Step 4 ticked; final ISO is confirmed in Step 5 screenshots.
- Step 6 lighting rule relaxed from ISO 100-400 to ISO 250-640 at F3.5. Screenshot added.

## [1.5.10] - Step 4: white balance done, aperture still stuck
- User set WB 4700K and ISO 640, Key Light 48%, and removed a Sharpen filter from the main OBS source. OBS result looks natural and brighter.
- Aperture still F5.6 (photos: ISO 400 MM -0.7, ISO 640 MM -0.3). Dial/Wheel Setup = wheel Tv / dial Av read from the menu photos; fixes recorded in the checklist.
- Noticed an orange temperature icon on the camera live view; added a thermal warning to the checklist. Added 3 images.

## [1.5.9] - Step 4 progress, camera menus reviewed
- User added Image Files/Menus (32 photos, no EXIF/GPS, no serial numbers; all viewed). Movie Shoot Mode = Manual Exposure, 1/50, ISO 400, Movie SteadyShot Off, 4K Output Select = HDMI Only(25p) confirmed.
- Found: aperture is F5.6 (MM -1.0), not F3.5 - about 1.4 stops lost, the likely reason the image got dark. White Balance still Auto.
- Ticked the 4K Output Select item in Step 3 and four Step 4 items; Step 4 still open (aperture, white balance). Key Light to stay low (user eye comfort).

## [1.5.8] - Step 4 started: baseline and plan
- Camera screen photo (all auto): 1/25, F3.5, Auto ISO 250. The 1/25 shutter at 25p is Auto Slow Shutter (long exposure, motion blur, noisy-looking dark areas).
- Key Light currently 4700K 48% (user). Step 4 checklist rewritten with menu paths and an order. Nothing ticked yet. Elgato Control Center screenshot not committed (device name).

## [1.5.7] - Vertical crop accepted
- User-tuned vertical crop L800 R1270 T660 B50 checked: matches the Shorts reference (headphones 28% of width, glasses centred). Exact 9:16 equivalent L1277 R1747 T660 B50.
- Quality check: 1.32x upscale (816 px -> 1080 px), acceptable for phones; grain is the bigger issue (Step 4/6). Added screenshot.

## [1.5.6] - Vertical crop measured against the Shorts reference
- User result L1020 R1605 T250 B0 looked wider than the Short. Measured glasses/face width and position against the YouTube Shorts frame: about 1.15x tighter needed.
- New vertical crop L1145 R1761 T465 B34 (exact 9:16, 934x1661). Corrected the earlier claim that the Short could not be matched (it was based on a leaning pose).
- Added the screenshot of the user's result.

## [1.5.5] - Vertical canvas setup
- Diagnosed the Vertical clone: 3840x2160 with 3840x2160 bounds and no crop shows only the top-left corner of the 4K frame; Fit to Screen uses the 1920x1080 canvas.
- Added vertical Edit Transform recipe (bounds 1080x1920, Cover, Crop Bounds, crop L1020 R1605 T0 B0) to OBS_ZOOM_GUIDE.md and crop_presets.yaml.
- Added 2 screenshots (vertical Edit Transform, YouTube Shorts target look). Values are untested starting points.

## [1.5.4] - 16mm crops aligned; latency advice
- User-tuned 16mm crops accepted (LEDs at both edges): before 1010/1250/1130/95, during 1010/1250/1032/210. Exact 16:9 equivalents recorded.
- Added latency section (Buffering Disable, NV12, audio Sync Offset) and 4 screenshots.

## [1.5.3] - 16mm vs 18mm comparison
- Tested 16mm crops at 18mm: too tight. Added 18mm crop numbers and the clone mapping (2 2 = before playing, 2 = during playing).
- Documented sharpness maths and repeatability trade-off; recommendation: 16mm + crop. Noted visible noise in dark areas (exposure, Step 4/6).
- Added 4 screenshots (18mm, cropped and uncropped).

## [1.5.2] - First crop result + per-clone presets
- Tested crop 980/1260/1110/150: LEDs at both edges, horizontal framing matches old VOD target.
- Added suggested vertical tweaks for the "before songs" and "playing songs" clones; stored in OBS & Stream Files/SCENE/crop_presets.yaml.
- Added screenshots: uncropped, cropped, old VOD target frames (before songs / playing songs).

## [1.5.1] - OBS crop troubleshooting
- Edit Transform screenshots added. OBS 32 shows bounds type "Cover" (no "Scale to inner bounds"); Cover works for 16:9 crops.
- Explained crop 0 = full zoomed-out frame, and why crop 3840/2160 gives a black screen.
- Corrected the LED-edge estimate: needs about 2.4x not 1.2x; recommend about 1.2x lens zoom plus about 2.0x crop. Added crop numbers and a vertical-canvas starting point.

## [1.5.0] - Step 3 complete (OBS side): 4K source at 25 fps
- OBS Cam Link source now 4K (appears at 100% = 2x size on the 1080p canvas); OBS FPS 25; Lanczos set (user reported, screenshots added).
- Added Text Files/MD/OBS_ZOOM_GUIDE.md: Fit to Screen, Scale-to-inner-bounds crop zoom, crop formula and starting values.
- Added OBS main window screenshots (default 4K size and positioned) to Image Files/PNG/.
- To do: per-item Fit to Screen/crop on clones, tune crop for LED-edge framing, confirm camera File Format = 4K and 4K Output Select = HDMI Only(25p).

## [1.4.0] - Step 2 complete; Step 3 HDMI item done
- Verified by photo: Zoom Range = ClearImage Zoom (Camera Settings2, Zoom page 6/9). Step 2 ticked (optional lens deferred).
- Verified by photo: HDMI Info. Display = Off. Step 3 HDMI item ticked.
- Recorded current state: File Format = XAVC S HD, 4K Output Select = Memory Card+HDMI, HDMI Resolution = Auto.
- Recorded OBS Cam Link source: Device Default, Colour Space/Range Default, Buffering Auto-Detect, hardware decoding off, audio = capture audio only; driver Video Proc Amp all defaults.
- Added settings screenshots (OBS x3, camera menus x4) and Settings Files/YAML/current_settings.yaml.
- Still to do in Step 3: OBS source to Custom 3840x2160 @ 25 fps (PAL) with camera in 4K, HDMI Only(25p).

## [1.3.5] - Step 2 started: corrections after checking Sony's help guide
- Corrected menu path: Clear Image Zoom lives under "Zoom Range" (MENU -> Camera Settings2 -> Zoom Range), not "Zoom Setting".
- Corrected "standby" advice: no true standby on ZV-E10 while USB-powered/HDMI-connected (Power Save is disabled). Advice is now: leave the camera ON.
- Clear Image Zoom limits recorded: about 1.5x in 4K, about 2x in HD.
- Recorded user confirmations: camera on WW07 20W PD adapter, region PAL (25p/50p). Shutter guidance for PAL added.

## [1.3.4] - Power, menu and retention photos verified (batch 4); all photos in
- Added and viewed: Power Temp-High, USB-C Connected 1/2, Connector Alternative (+ Specs), Alternative USB-s On Extender, Menu Burnt Into Screen.
- Verified Auto Power OFF Temp. = High on the camera menu (Step 1 item 2).
- Alt connector WW07-G3b-PD: PD 20W max; serial number on label redacted in the committed copy.
- Burnt-in menu photo: faint ghost behind a live view that still updates = image retention, not frozen.
- CORRECTION to v1.3.3 notes: the braided cable in Panel Out/Front/Side is the micro-HDMI lead, not USB-C. USB-C power is the black cable in USB-C Connected 1.
- Noted camera shows 1/50 and Auto ISO 320 (PAL region likely; Step 4 needs ISO lock).

## [1.3.3] - Hardware photos verified (batch 3)
- Added and viewed: Cam Link 4K Connected, Cam Link 4K Model, USB 10G Ports, ZV E-10 Panel Out.
- Back/Front/Side already in repo (byte-identical to re-uploads).
- Cam Link Model photo: serial number blacked out before commit (model 20GAM9901 left visible).
- Panel Out confirms LCD flipped out and USB-C cable connected; Cam Link on rear USB, see IMAGE_NOTES.md.

## [1.3.2] - Reference images verified
- Re-uploaded Chainbrain + 3 Mavo problem samples confirmed byte-identical to repo copies; viewed all four.
- Added Text Files/MD/IMAGE_NOTES.md with verified visual descriptions.

## [1.3.1] - System info re-verified
- Re-read DxDiag, System Information, Settings > About and Task Manager screenshots (kept local only).
- Added sanitized facts to CONTEXT.md: board/BIOS, Windows 22H2 build, storage, GPU detail, WER crash log summary.
- Added Task Manager GPU screenshot (no identifiers) to Image Files/PNG/.
- Added .gitignore rules blocking DxDiag, Msinfo32 and System - About files.
- Withheld from git: DxDiag.txt (machine name + Machine ID), Msinfo32 and About screenshots
  (machine name, username, Device ID, Product ID).

## [1.3.0] - Step 1 complete
- Step 1 fully ticked: LCD out, Auto Power OFF Temp HIGH, USB-C PD power.
- Added setup photos for power/thermal (ZV E-10 Power Temp-High, USB-C Connected 1/2, Panel Out).
- Noted alternative USB-C connector found (may beat Samsung fast charger); photos/specs saved.

## [1.2.0] - Connection & thermal progress
- Cam Link 4K moved to rear 10G (red) port (upgraded from 5G blue); photos added.
- LCD panel flipped out for thermal dissipation (Step 1 partial).
- Added setup photos: Cam Link 4K Connected/Model, USB 10G Ports, ZV E-10 Panel Out.
- Checklist updated: Step 1 LCD out ticked; Step 3 port ticked.

## [1.1.0] - Host system info integrated
- Read DxDiag (sanitized): added host system specs (CPU/RAM/GPU/USB controllers/display) to CONTEXT.md.
- Confirmed Cam Link 4K enumerated, no driver/display/sound issues.
- Noted USB hub topology: avoid front-panel Generic USB Hubs (05E3:0610/0608); use rear AMD/ASMedia USB 3.0 ports.
- DxDiag/images were NOT committed (kept in /tmp only) for security.

## [1.0.0] - Initial
- Stored Sony ZV-E10 streaming configuration & diagnostic context block (V1.0) as CONTEXT.md.
- Created file-format folder structure (Text/Image/Settings/Programming + extras) with per-format subfolders.
- Imported reference images: Chainbrain.png (target look), Mavo zoom/OBS samples, ZV-E10 hardware photos.
- Established baseline troubleshooting priority: frame rate & USB -> thermal -> exposure/lighting.

## Pending setup steps (tick as completed)
- [ ] A. Thermal & power: flip LCD out, Auto Power OFF Temp HIGH, USB-C PD wall adapter
- [ ] B. Zoom memory: keep camera on/standby, enable Clear Image Zoom, consider manual zoom lens
- [ ] C. OBS & Cam Link 4K: rear USB 3.0 port, HDMI Info Display OFF, 30 FPS custom source
- [ ] D. Exposure: Movie mode M, shutter 1/60 @30fps, aperture lowest, ISO 100-400 locked, WB locked
- [ ] E. Color profile: Standard Vivid (Sat +1, Sharp +1) or PP11 S-Cinetone
- [ ] F. Lighting: raise key light, keep ISO low
