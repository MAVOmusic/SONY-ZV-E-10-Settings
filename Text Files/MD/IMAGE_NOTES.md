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
- **OBS Cam Link 4K Settings 1.png**: Cam Link driver "Video Proc Amp" dialog: Brightness 0, Contrast 128, Hue 0, Saturation 128 (all defaults, Auto unticked); other controls greyed out.
- **OBS Cam Link 4K Settings 2.png**: OBS Video Capture Device properties: Resolution/FPS Type = **Device Default** (Resolution and FPS greyed, FPS "Match Output FPS"), Video Format Any, Colour Space Default, Colour Range Default, Buffering Auto-Detect, Flip Vertically off, Apply rotation data on.
- **OBS Cam Link 4K Settings 3.png**: lower part of the same dialog: Use hardware decoding off, Audio Output Mode = Capture audio only, custom audio device off.

## Take-aways for the checklist
- Target look = sharp, low-noise, evenly lit: supports Step 4 (low ISO, manual exposure) and Step 6 (more key light).
- The softness/noise in the problem samples is consistent with OBS crop-zoom and low light
  (see CONTEXT.md Issue A and Step F). This is a visual impression, not a measurement.
