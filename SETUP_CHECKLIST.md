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
- [ ] (optional) WB cooler 4300-4500K: skin is a bit warmer/redder than Chainbrain (B/R 0.62 vs 0.70), partly red LED spill

## Step 6 — Lighting - DONE v1.8.0
- [x] Key Light = Elgato Key Light (original), firmware 1.0.3, 4700K 48% -> user kept the brightness at 48% (eye comfort); stand is taped and cannot be moved. No extra light needed: forehead luma 159 vs Chainbrain about 163 at ISO 500, F3.5, 1/50
- [x] WB: 4300K tested by the user, 4700K measured basically the same (forehead B/R 0.60 vs 0.63); either is fine, 4700K matches the light
- [x] Thermal (user): fan on the camera tripod, Airplane Mode On (Network1). Monitor Brightness is greyed out. Orange temperature icon seen in the v1.5.10 photos; result after the fan still unconfirmed - watch it during the first long stream
- [x] LED floor lamps (left blue, right red; phone app, Bluetooth) both at 28%. At 28% the shelf is neutral enough (shelf B/R 0.82); no change needed. Colours/brightness can be tuned in the app
- [ ] (optional, later) Faster lens for more light and no zoom reset: Sigma 16mm f/1.4 (about 2.6 stops more light, same 16mm view, same crops) or an f/2.8 zoom (about 1.3 stops)
