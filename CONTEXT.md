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
- Host System: High-spec PC running OBS Studio

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

--- B. RESOLVING ZOOM MEMORY & QUALITY DEGRADATION ---
1. Hardware Workaround (Zero-Cost):
   - Leave camera powered on via USB-C PD; use standby rather than full power-down
     to preserve power-zoom physical positions between streams.
2. Menu Quality Fix (Clear Image Zoom):
   - Menu -> Movie -> Zoom -> Zoom Setting -> Clear Image Zoom -> ON
   - Benefits: Leverages the full 24.2MP sensor array before 1080p/4K downsampling,
     providing up to 2x digital zoom with virtually zero optical quality loss.
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
