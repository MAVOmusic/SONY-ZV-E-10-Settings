# SONY ZV-E10 STREAMING CONFIGURATION & DIAGNOSTIC CONTEXT BLOCK V1.0
================================================================================
Document Type: AI Context Transfer & Technical Knowledge Base
Target System: Sony ZV-E10 + Elgato Cam Link 4K + OBS Studio
Stream Duration Requirement: 2 Hours to 24 Hours continuous operation
Last Updated: Current Session
================================================================================

1. HARDWARE INFRASTRUCTURE & SPECIFICATIONS
--------------------------------------------------------------------------------
- Camera Body: Sony ZV-E10 (APS-C 24.2 Megapixel Sensor, E-mount)
- Equipped Lens: Sony E PZ 16-50mm f/3.5-5.6 OSS (Power Zoom Kit Lens)
- Capture Card: Elgato Cam Link 4K (USB 3.0 interface)
- Power Supply: Continuous USB-C Power Delivery (PD) connection
- Host System: Windows 10 Home 64-bit (build 19045), OBS Studio
- CPU: AMD Ryzen 5 8500G w/ Radeon 740M Graphics (12 threads, ~3.6GHz)
- RAM: 128 GB (131072 MB) - ample headroom for OBS + 4K capture
- GPU: NVIDIA GeForce RTX 4060 (8 GB dedicated) driver 32.0.15.6094 (2024-08-14)
- Secondary GPU: AMD Radeon 740M (integrated, used for display/compute)
- Display: 1920x1080 @60Hz (DVI, monitor GA241) via RTX 4060
- Storage: ~3.8 TB NVMe/RAID array (C:) + 2x ~1.9 TB Seagate expansion (E:, F:)
- USB Controllers: AMD (1022:15BB/15BD) + ASMedia 3.0 (1B21:1142) + AMD USB4 Host Router
- Capture device: Elgato Cam Link 4K (USB VID 0FD9 / PID 0066) detected, no driver issues
- Cam Link connection: rear 10G (red) port (upgraded from 5G blue); photos in Image Files/JPG/
- Peripherals: Stream Deck XL, FootSwitch, Razer Ornata V3 X / DeathAdder Essential
- DxDiag: no problems reported on display/sound/input tabs
- System: CyberPowerPC "GamingPC" prebuilt, MSI PRO X870-P WIFI (MS-7E47) board,
  BIOS AMI 1.A40 (2025-03-11), UEFI, Secure Boot on; Windows 10 Home 22H2 (build 19045.6466)
- Storage detail: 3.64 TB SSD AMD-RAID Array 1 (C:), Disk 1 USB (E:/F:)
- GPU detail: RTX 4060 8 GB + Radeon 740M 2 GB iGPU; ~51 C / 46% 3D load seen in
  Task Manager (Image Files/PNG/Task Manager - Performance.png)

2. DIAGNOSED ISSUES & ROOT CAUSES
--------------------------------------------------------------------------------
[ISSUE A: Lens Zoom Resets Position on Power Off]
- Root Cause: Sony 16-50mm PZ is a motor-driven power zoom lens. The hardware
  mechanism automatically retracts the lens barrel to 16mm when powered down.
  Camera Memory Recall (1,2,3) stores software exposure data only, NOT the physical
  stepper motor zoom state.
- Secondary Issue (OBS Zooming Quality Loss): Cropping/zooming in OBS scales down
  a 1080p rasterization (e.g., a 50% crop drops resolution to ~960x540), causing
  severe pixelation, softness, and a "480p" appearance.

[ISSUE B: 4K Video Stuttering / Lag in OBS]
- Root Causes:
  1. Refresh/Frame Rate Mismatch: The ZV-E10 caps 4K HDMI output at 30fps. If OBS
     source properties are set to 60fps or "Match Output FPS" configured incorrectly,
     frame dropping occurs.
  2. USB Bandwidth Saturation: Connecting the Cam Link 4K to front-panel USB ports,
     unpowered hubs, or USB 2.0 controllers causes frame buffering and lag.

[ISSUE C: Thermal Throttling / Overheating Risk during 2-24 Hour Streams]
- Root Causes:
  1. Swiveled LCD Screen Stowed Flat: The rear metal chassis behind the LCD is
     the primary heat sink. Leaving the LCD closed traps thermal energy.
  2. Default Thermal Threshold: Default firmware setting ("Standard") shuts down
     the camera at low heat thresholds to prevent thermal discomfort when handheld.

3. MASTER CONFIGURATION & STEP-BY-STEP SOLUTIONS
--------------------------------------------------------------------------------

--- A. THERMAL & POWER MANAGEMENT (For 24-Hour Continuous Operation) ---
1. Physical Setup: Always flip out the LCD screen 90 to 180 degrees away from the
   camera body to maximize thermal dissipation.
2. Firmware Thermal Threshold:
   - Menu -> Setup (Yellow Toolbox) -> Power Option -> Auto Power OFF Temp. -> HIGH
3. Power Routing: Ensure USB-C cable connects to a dedicated USB-C Wall Adapter
   supporting Power Delivery (PD) rather than an unpowered motherboard USB port.
   - Note: User found an alternative USB-C connector/adapter that may perform better
     than the ultra-fast Samsung phone charger; photos/specs in Image Files/JPG/
     (Connector Alternative I've Found*.jpg, Alternative USB-s On Extender.jpg).
   - Alternative adapter spec (from label, v1.3.4): model WW07-G3b-PD, USB-C PD up to 20W
     (5V 3A / 9V 2.22A / 12V 1.67A); USB-C + USB-A together max 5V 3A. Keep its USB-A ports unused.
   - The 4-port USB-A wall extender is USB-A only (no PD) - do not use it to power the camera.
   - Samsung fast charger wattage: unknown (not readable in photos).
   - Region: camera confirmed on PAL by user (v1.3.5): 4K is 25p, shutter 1/50 @25p or 1/100 @50p.
   - Power now (v1.3.5): camera USB-C cable is on the WW07-G3b-PD adapter's USB-C port; camera shows charging.

--- B. RESOLVING ZOOM MEMORY & QUALITY DEGRADATION ---
1. Hardware Workaround (Zero-Cost) [corrected v1.3.5]:
   - Leave the camera switched ON (powered by USB-C PD) between streams instead of powering
     it off, so the power-zoom lens stays where it is. There is NO true "standby" on the
     ZV-E10 while USB-powered / HDMI-connected: Sony's Power Save (screen-off) mode is
     disabled when powered via USB, connected to a TV/HDMI device, or during USB Streaming.
     Keep Power Save Start Time = Off and Power Save by Monitor = Does Not Link (as set).
   - User has left it on for 24h+ by accident: warm, not hot (with LCD out + Temp High).
   - If power is lost (adapter/surge strip/cable), the camera turns off and the lens retracts.
2. Menu Quality Fix (Clear Image Zoom) [corrected v1.3.5]:
   - ZV-E10 (original firmware) path: MENU -> Camera Settings2 -> Zoom Range -> Clear Image Zoom.
     (Newer menus: MENU -> Shooting -> Zoom -> Zoom Range.) It is called "Zoom Range", not "Zoom Setting".
   - Per Sony specs: Clear Image Zoom is about 1.5x in 4K movies and about 2x in HD movies
     (unavailable at 120p). It only applies beyond the lens's optical range (past 50mm on the kit lens).
   - Default is "Optical zoom only". Do not choose "Digital Zoom" (worse quality).
3. Long-Term Recommended Lens Upgrade:
   - Transition to a manual zoom lens (e.g., Sigma 18-50mm f/2.8 DC DN or
     Tamron 17-70mm f/2.8). Manual zoom rings hold physical position permanently
     regardless of camera power state.

--- C. OBS & CAM LINK 4K OPTIMIZATION ---
1. Physical Connection: Plug Cam Link 4K directly into a rear Motherboard USB 3.0/3.1
   port (Blue/Red port). Avoid front case headers or external hubs.
2. Clean HDMI Output (Hide On-Screen Display):
   - Menu -> Setup (Yellow Toolbox) -> HDMI Settings -> HDMI Info Display -> OFF
3. OBS Source Properties (Cam Link 4K):
   - Resolution/FPS Type: Custom
   - Resolution: 3840x2160 (for 4K) or 1920x1080 (for 1080p)
   - FPS: Match Camera Output (Set OBS source explicitly to 30 FPS for 4K output;
     do NOT force 60 FPS on 4K feed).

--- D. CAMERA EXPOSURE & SHARPNESS CONTROL (Manual Mode) ---
Set Camera Mode Dial to Movie Mode -> Exposure Mode: Manual (M)

1. Shutter Speed (180-Degree Rule):
   - Streaming at 30 FPS -> Set Shutter Speed to 1/60
   - Streaming at 60 FPS -> Set Shutter Speed to 1/120
2. Aperture: Set to lowest numerical value (f/3.5 wide end, f/5.6 telephoto end).
3. ISO: Lock manually between ISO 100 and ISO 400. NEVER use Auto ISO (prevents
   sensor noise and grain which destroys picture crispness).
4. White Balance: Lock manually (e.g., 5500K for daylight LEDs). Disable AWB.

--- E. COLOR PROFILES & CREATIVE LOOKS ---
Option 1: Standard Vivid (No Post-Processing Required)
  - Picture Profile: OFF
  - Creative Style / Look: Standard or Neutral
  - Adjustments: Contrast 0, Saturation +1, Sharpness +1
Option 2: Cinematic Out-of-Camera (S-Cinetone)
  - Menu -> Picture Profile -> Select PP11 (S-Cinetone)
  - Delivers optimized skin tones and highlight roll-off without LUT grading.

--- F. LIGHTING CONTROL ---
- Never compensate for low room light with camera ISO.
- Increase physical Key Light illumination on the subject, keep camera ISO at 100-400.
  A well-lit 1080p image at ISO 100 will visually outperform an unlit 4K image at ISO 3200.

5. HOST SYSTEM NOTES (from DxDiag, sanitized)
--------------------------------------------------------------------------------
- Cam Link 4K is enumerated as a USB Video Device with no problems. Currently on a
  REAR 10G (red) port (upgraded from 5G blue) on the AMD/ASMedia controller -
  good. Avoid front-panel Generic USB Hubs (05E3:0610/0608, USB 2.0-class).
- Display pipeline runs 1920x1080@60Hz on DVI. If streaming 1080p60, set camera
  to 1080p60 and OBS source to 60 FPS; if streaming 4K, camera+source must be 30 FPS.
- 128 GB RAM + RTX 4060 means OBS x264/NVENC encoding and 4K preview are not
  CPU/GPU bound; USB bandwidth and frame-rate matching remain the real limits.
- No thermal or driver issues reported by DxDiag.
- DxDiag crash/hang log (Windows Error Reporting) shows only explorer.exe crashes,
  Rocksmith2014.exe hangs, CapCut and installer (setup.exe) entries - no OBS, Cam Link
  or camera-related faults.
- Cam Link 4K uses the generic Microsoft "USB Video Device" (usbvideo) driver; no
  Elgato driver needed.
- Keyboard/mouse sit on USB 3.0 root hubs via Generic USB Hubs; keep the Cam Link on its
  own rear port, not shared with those hubs.

4. INSTRUCTIONS FOR SUBSEQUENT AI INSTANCES
--------------------------------------------------------------------------------
1. Maintain this context as established baseline reality for the user's rig.
2. Treat hardware limitations of the Sony 16-50mm PZ lens as non-negotiable physical constraints.
3. Priority progression for future troubleshooting:
   Step 1: Frame rate matching & USB bandwidth.
   Step 2: Thermal management (Screen flip out + Auto Power OFF Temp HIGH).
   Step 3: Lighting and exposure optimization (ISO lock, Shutter speed lock).

5. REFERENCE IMAGES
--------------------------------------------------------------------------------
- Target look reference: Image Files/PNG/Chainbrain.png
- Problem samples: Image Files/PNG/Mavo (Camera Zoom In 1).png,
  Image Files/PNG/Mavo (Camera Zoom In 2).png,
  Image Files/PNG/Mavo (OBS Zoom In).png
- Hardware photos: Image Files/JPG/ZV E-10 Front.jpg,
  Image Files/JPG/ZV E-10 Back.jpg, Image Files/JPG/ZV E-10 Side.jpg
