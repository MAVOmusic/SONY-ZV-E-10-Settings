# Reference Image Notes (visually checked, session 2026-10-16)

Descriptions below come from actually viewing the files. Image-to-filename mapping follows the
order the user attached them (Chainbrain, Camera Zoom In 1, Camera Zoom In 2, OBS Zoom In); the
repo copies are byte-identical (same MD5) to the re-uploaded files.

## Image Files/PNG/Chainbrain.png (1922x1079) - TARGET LOOK
- Twitch VOD screenshot: bearded man, black cap, over-ear headphones, plaid flannel, blue guitar.
- Wide framing, subject about 1/3 of frame; room (guitars, game shelves) stays readable.
- Sharp face and texture, clean low-noise shadows, neutral-to-warm skin tones, natural contrast.

## Image Files/PNG/Mavo (Camera Zoom In 1).png (1920x1080) - problem sample
- Bass-playing shot, subject mid-frame in front of a CD wall, with stream overlays (goals, request list).
- Face and beard look soft/smeared with blocky noise; strong red/orange rim light colours one side.

## Image Files/PNG/Mavo (Camera Zoom In 2).png (1919x1076) - problem sample
- Tighter, side-on crop (head turned), same CD wall, overlays unchanged.
- Skin and beard detail is soft and blocky; red/magenta cast on face and glasses from the rim light.

## Image Files/PNG/Mavo (OBS Zoom In).png (1918x1078) - problem sample
- Front-on, cap/headphones/glasses close to camera, overlays unchanged.
- Face is soft and low in detail, with dark shadows crushed and noisy.

## Image Files/PNG/Task Manager - Performance.png (1075x816)
- Task Manager GPU page: RTX 4060 at 46% 3D, 51 C, driver 32.0.15.6094 (2024-08-14). No identifiers.

## Hardware photos (viewed in v1.3.3)
- **Panel Out.jpg**: ZV-E10 on a tripod, lens facing left, LCD swung out ~90 degrees to the side of the body (screen reflects a hand-drawn sign), braided USB-C cable in the side port with the port cover open. Confirms Step 1A (LCD out) and a cable-powered camera.
- **Back.jpg**: rear of the camera, LCD closed against the body and dark. Lots of dust/lint on the screen. A faint darker reddish rounded area on the left of the screen may be a reflection or retention; cannot tell from this photo (dedicated burnt-screen photo still missing).
- **Side.jpg**: power-zoom lever (W/T), E-mount marking, USB-C cable in the open side port.
- **Front.jpg**: lens E PZ 16-50mm f/3.5-5.6 OSS, 40.5mm filter thread, USB-C in the side port.
- **USB 10G Ports.jpg**: MSI rear I/O. Two red USB 10G ports (side by side) both empty here, a USB-C 20G port empty, USB 2.0 ports (two pairs) with cables plugged in, a cable in the USB 5G port above the 10G pair, ethernet LED lit.
- **Cam Link 4K Connected.jpg**: the Cam Link dongle (HDMI cable at the bottom left) points at the rear panel between the USB 5G port (holding another cable) and the visible right red 10G port, which is empty. The dongle hides the left 10G port, so it is most likely plugged into the LEFT red 10G port. Moderate confidence: the plug itself is not visible. USB 2.0 ports below carry other cables.
- **Cam Link 4K Model.jpg**: label shows model 20GAM9901 (Corsair Memory BV, made in Taiwan), USB-A 3.0 plug with blue tongues, HDMI IN on the other end. The serial number is blacked out in the committed copy.
- Cam Link 4K is USB 3.0 / 5 Gbps, so the faster 10G port gives no speed gain; what matters is avoiding USB 2.0 ports and shared hubs.

## Take-aways for the checklist
- Target look = sharp, low-noise, evenly lit: supports Step 4 (low ISO, manual exposure) and Step 6 (more key light).
- The softness/noise in the problem samples is consistent with OBS crop-zoom and low light
  (see CONTEXT.md Issue A and Step F). This is a visual impression, not a measurement.
