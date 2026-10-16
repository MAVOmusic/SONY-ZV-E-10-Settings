# AI HANDOFF CONTEXT BLOCK — SONY ZV-E10 STREAMING SETUP
================================================================================
MANDATORY FIRST STEP FOR THE RECEIVING AI:
Before doing ANYTHING else, answer this question in your first reply:
"Do you have vision/image-understanding capabilities (can you actually SEE and
analyze the contents of images, not just filenames/metadata)?"
- If YES: continue with this context block and verify by describing at least one
  of the stored images' visible contents before proceeding.
- If NO: STOP. Do not continue. Tell the user you lack vision and that the
  previous AI also lacked vision, which may have led to image-led steps being
  unverified. Ask the user to either provide a vision-capable AI or describe the
  images in text.
We do not continue if the AI has no vision capability.
================================================================================

RESTORATION NOTE (session branch arena/23e07129-sony-zv-e-10-settings)
- The v1.1.0-v1.3.0 text files were restored from the user's pasted text; the
  earlier local-only commits (70711b2, 59d8675, de9b1e0, 48fa5d5) never reached
  the remote, so history was not recreated 1:1.
- Vision check done in this session: Chainbrain.png and ZV E-10 Front.jpg were
  opened and described correctly (Chainbrain = Twitch stream screenshot, bearded
  man, black cap, headphones, plaid flannel, blue flame-top guitar, game shelves;
  Front = ZV-E10 with E PZ 16-50mm f/3.5-5.6 OSS on a tripod head, blue backdrop,
  USB-C cable in right side port).
- Only the 7 original images (4 PNG + Front/Back/Side JPG) exist in the repo.
  The Step 1/Step 3 photos referenced below are NOT in the repo yet and need to
  be re-added by the user (markdown cannot carry binary files). Until then,
  those checklist items are based on the user's word, not verified photos.

REPOSITORY
- Repo: MAVOmusic/SONY-ZV-E-10-Settings
- Branch created by previous AI: arena/aec5010f-sony-zv-e-10-settings
- Completed work was merged to main via PR #1 (first commit). Subsequent commits
  (v1.1.0, v1.2.0, v1.3.0) are LOCAL ONLY on the arena branch because the
  session closed after PR merge. The previous AI created its own branch; there is
  NO need for multiple branches to cover spaces — continue on main or the existing
  arena branch, do not create extra branches.
- Current local version: 1.3.0 (VERSION.txt). Changelog: CHANGELOG.md.

FOLDER STRUCTURE (file-format organized)
- Text Files/ (TXT, MD, LOG, CSV, JSON, YAML, TOML)
- Image Files/ (JPG, JPEG, PNG, GIF, WEBP, BMP, SVG)
- Settings Files/ (INI, CONF, CFG, JSON, YAML, TOML, XML, ENV)
- Programming Files/ (PY, CMD, PS1, BAT, SH, JS, TS, HTML, CSS)
- Audio Files/, Video Files/, Document Files/, Archive Files/, Database Files/,
  OBS & Stream Files/
- Root docs: README.md, CONTEXT.md, SETUP_CHECKLIST.md, CHANGELOG.md, VERSION.txt,
  AI_HANDOFF_CONTEXT.md

STORED IMAGES (in Image Files/)
PNG:
- Image Files/PNG/Chainbrain.png (1922x1079) — TARGET LOOK REFERENCE
- Image Files/PNG/Mavo (Camera Zoom In 1).png (1920x1080) — problem sample
- Image Files/PNG/Mavo (Camera Zoom In 2).png (1919x1076) — problem sample
- Image Files/PNG/Mavo (OBS Zoom In).png (1918x1078) — problem sample
JPG:
- Image Files/JPG/ZV E-10 Front.jpg, Back.jpg, Side.jpg — hardware photos
- Image Files/JPG/ZV E-10 Panel Out.jpg — LCD flipped out (Step 1A)  [VERIFIED v1.3.3]
- Image Files/JPG/ZV E-10 Power Temp-High.jpg — Auto Power OFF Temp HIGH (Step 1B)  [NOT IN REPO YET]
- Image Files/JPG/ZV E-10 USB-C Connected 1.jpg, 2.jpg — USB-C PD power (Step 1C)  [NOT IN REPO YET]
- Image Files/JPG/Cam Link 4K Connected.jpg, Cam Link 4K Model.jpg — Cam Link on 10G red port  [Connected: VERIFIED (likely left 10G port); Model: serial REDACTED]
- Image Files/JPG/USB 10G Ports.jpg — port identification  [VERIFIED v1.3.3]
- Image Files/JPG/Alternative USB-s On Extender.jpg — extender USB slots (not recommended for power)  [NOT IN REPO YET]
- Image Files/JPG/Connector Alternative I've Found.jpg, ...Specs.jpg — alternative connector  [NOT IN REPO YET]
- Image Files/JPG/ZV E-10 Menu Burnt Into Screen.jpg — LCD image retention photo (UNVERIFIED)  [NOT IN REPO YET]

EXCLUDED (security) — NOT stored in git:
- DxDiag.txt, Msinfo32 - System Summary.PNG, System - About.PNG, Task Manager - Performance.PNG
  Reason: contain machine name, machine ID, serials, usernames, paths. Sanitized specs
  were extracted into CONTEXT.md instead. Do NOT commit these even if user re-uploads;
  store only sanitized facts.

SYSTEM SPECS (sanitized, from DxDiag)
- OS: Windows 10 Home 64-bit (build 19045)
- CPU: AMD Ryzen 5 8500G (12 threads, ~3.6GHz) + Radeon 740M iGPU
- RAM: 128 GB
- GPU: NVIDIA GeForce RTX 4060 (8 GB), driver 32.0.15.6094 (2024-08-14)
- Display: 1920x1080 @60Hz (DVI, monitor GA241) via RTX 4060
- Storage: ~3.8 TB array (C:) + 2x ~1.9 TB Seagate (E:, F:)
- USB controllers: AMD (1022) + ASMedia 3.0 (1B21:1142) + AMD USB4 router
- Capture: Elgato Cam Link 4K (USB VID 0FD9 / PID 0066), no driver issues
- Peripherals: Stream Deck XL, FootSwitch, Razer Ornata V3 X / DeathAdder Essential
- DxDiag: no problems on display/sound/input tabs

HARDWARE RIG
- Camera: Sony ZV-E10 (APS-C 24.2MP, E-mount)
- Lens: Sony E PZ 16-50mm f/3.5-5.6 OSS (power zoom)
- Capture: Elgato Cam Link 4K (USB 3.0)
- Power: USB-C PD
- Host: high-spec PC (above) running OBS Studio

DIAGNOSED ISSUES
A. Lens zoom resets to 16mm on power off (PZ motor retracts; Memory Recall stores exposure only, not zoom). OBS crop zoom loses resolution (~960x540 from 1080p).
B. 4K stutter: 4K capped at 30fps (don't force 60); USB bandwidth saturation on front hubs/2.0.
C. Thermal throttling: LCD stowed flat traps heat; default "Standard" thermal threshold too low.

MASTER CONFIG (see CONTEXT.md for full)
A. Thermal/Power: LCD flipped out 90-180°; Auto Power OFF Temp -> HIGH; USB-C PD wall adapter (not motherboard port).
B. Zoom/Quality: keep camera on/standby; Clear Image Zoom ON; optional manual lens (Sigma 18-50 f/2.8 / Tamron 17-70 f/2.8).
C. OBS/Cam Link: rear motherboard USB 3.0/3.1 port (blue/red); HDMI Info Display OFF; source Custom, 3840x2160 or 1920x1080, 30 FPS for 4K.
D. Exposure (Manual M): shutter 1/60 @30fps or 1/120 @60fps; aperture lowest (f/3.5 wide / f/5.6 tele); ISO locked 100-400 (no Auto ISO); WB locked (e.g. 5500K), AWB off.
E. Color: Option 1 Standard Vivid (PP OFF, Creative Style Standard/Neutral, Contrast 0, Sat +1, Sharp +1) OR Option 2 PP11 S-Cinetone.
F. Lighting: raise key light; keep ISO 100-400; never raise ISO for low light.

SETUP CHECKLIST STATUS (SETUP_CHECKLIST.md)
Step 1 — Thermal & Power: COMPLETE (v1.3.0)
  [x] LCD flipped out (photo: ZV E-10 Panel Out.jpg)
  [x] Auto Power OFF Temp -> HIGH (photo: ZV E-10 Power Temp-High.jpg)
  [x] USB-C PD power (photos: ZV E-10 USB-C Connected 1/2.jpg; alt connector found)
Step 2 — Zoom & Quality: NOT STARTED
  [ ] keep camera on/standby; Clear Image Zoom ON; optional manual lens
Step 3 — OBS & Cam Link 4K: PARTIAL
  [x] Cam Link on rear 10G (red) port (upgraded from 5G blue) (photos: Cam Link 4K Connected.jpg, USB 10G Ports.jpg)
  [ ] HDMI Info Display -> OFF
  [ ] OBS source Custom, 3840x2160 or 1920x1080, 30 FPS for 4K
Step 4 — Exposure & Sharpness: NOT STARTED
Step 5 — Color Profile: NOT STARTED
Step 6 — Lighting: NOT STARTED

OPEN ISSUES / UNVERIFIED
- LCD "burnt menu" image retention reported after Step 1 test run; previous AI could NOT view
  the photo. Status unknown: faint ghost (likely temporary retention) vs solid frozen screen.
  Needs vision-capable verification. Photo: Image Files/JPG/ZV E-10 Menu Burnt Into Screen.jpg
  (not yet in repo; user must re-upload).
- Alternative USB-C connector vs Samsung Super Fast Charger: wattage/specs not recorded
  (previous AI could not read the specs photo). User to provide wattage in text.
- Cam Link on 10G red port: photo viewed (v1.3.3). Consistent with the LEFT red 10G port (hidden behind the dongle); right 10G port empty; 5G port holds another cable. Moderate confidence - see Text Files/MD/IMAGE_NOTES.md.

PREVIOUS AI LIMITATIONS (important)
- The previous AI had NO vision capability. All image-based conclusions were unverified
  and based on filenames/text. Treat any image-dependent step as unverified until a
  vision-capable AI confirms. Do not trust the previous AI's image-derived claims.

INSTRUCTIONS FOR NEXT AI
1. First answer the vision-capability question (mandatory).
2. If vision-capable, inspect the stored images and verify the unverified items above.
3. Continue ticking steps 2-6 with the user, one at a time, updating VERSION.txt and
   CHANGELOG.md after each completed setup, and committing locally.
4. Do not create extra branches; work on main or the existing arena branch.
5. Do not commit sensitive system-info files (DxDiag, Msinfo/System/TaskManager screenshots).
6. Keep the file-format folder structure; add new files into the correct format subfolder.
