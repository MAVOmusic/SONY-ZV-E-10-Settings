# Changelog

All notable changes to this repository are documented here.
Versioning: MAJOR.MINOR.PATCH. Bump on each completed setup step.

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
