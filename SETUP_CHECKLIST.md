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
- [x] (user-reported v1.5.0; screenshots show 4K source at 100% scale and 25.00/25.00 FPS; Lanczos set) OBS source: Custom, 3840x2160 or 1920x1080, FPS = 30 (match camera; no 60 on 4K)
- [x] Menu -> Setup (Setup2) -> 4K Output Select -> HDMI Only(25p) (photo verified v1.5.9: Setup2 shows HDMI Only(25p); File Format and Record Setting are greyed out in Movie1, which is expected because HDMI Only does not record to the card). Proxy Recording = Off (Movie2)

## Step 4 — Exposure & Sharpness (Manual)
Baseline (v1.5.8 photo, all auto): 1/25, F3.5, Auto ISO 250, Key Light 4700K 48%.
Menu photos (Image Files/Menus, v1.5.9). Menu paths are from the Sony ZV-E10 help guide and the user's photos.
- [x] Movie Shoot Mode = Manual Exposure (verified: MENU -> Camera Settings2 -> Movie1 -> Shoot Mode; the Camera Settings1 'Shoot Mode' with the still-camera icon is the STILL mode and stays Intelligent Auto, that is fine)
- [x] Shutter 1/50 (main screen photo)
- [ ] Aperture F3.5 - photos still show F5.6 (MM -0.7 at ISO 400, MM -0.3 at ISO 640). F5.6 costs about 1.4 stops vs F3.5. User's dial only changed ISO. Dial/Wheel Setup (Camera Settings2 -> Custom Operation1, page 8/9) = wheel Tv, dial Av; Dial/Wheel Lock = Unlock. Fixes to try: leave ISO-select state (centre button), turn the TOP ridged dial for aperture, or switch Dial/Wheel Setup to 'F/no. SS'
- [x] ISO fixed 400 (verified: Camera Settings1 -> Exposure -> ISO = ISO 400; Exposure Comp greyed, Metering Multi)
- [x] White Balance 4700K (user-reported v1.5.10; Camera Settings1 -> Color/WB/Img. Processing1 -> White Balance -> K). Image now looks natural
- [x] Movie SteadyShot = Off (verified: Camera Settings2 -> Movie3 -> SteadyShot Off; SteadyShot Settings greyed)
- Key Light now 48% (user, Control Center); keep it there or lower, get the brightness from F3.5 and ISO 400-640 instead
- OBS: a Sharpen filter was on the main source and was turned off by the user (v1.5.10); sharpening amplifies grain.
- WARNING: an orange thermometer-style temperature icon is on the live view in both new photos (camera is warm, orange = recording/streaming time is limited). See thermal notes in Step 6.
- Note: Auto Slow Shutter is On (Movie2) but it does not work in Manual Exposure.

## Step 5 — Color Profile
- [ ] Option 1: Picture Profile OFF; Creative Style Standard/Neutral; Contrast 0, Sat +1, Sharp +1
- [ ] OR Option 2: Picture Profile PP11 (S-Cinetone)

## Step 6 — Lighting
- [ ] Increase key light; keep ISO 100-400; do not raise ISO for low light
