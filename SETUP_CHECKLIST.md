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

## Step 4 — Exposure & Sharpness (Manual)
Baseline (v1.5.8 photo, all auto): 1/25, F3.5, Auto ISO 250 (A ISO 250), tripod scene icon shown, Key Light 4700K 48%.
Plan, in this order (movie mode, PAL, 4K 25p). Menu paths are from the Sony ZV-E10 help guide.
- [ ] Key Light up first (Elgato Control Center, brightness slider) - about 80-100% at 4700K, so there is light for 1/50
- [ ] Shoot Mode = Manual Exposure: MENU -> Camera Settings1 -> Shoot Mode (or Fn -> Shoot Mode)
- [ ] Shutter 1/50 (25p, PAL): control wheel in Manual Exposure (aperture is the control dial; swap in Camera Settings2 -> Dial/Wheel Setup)
- [ ] Aperture F3.5 (already the widest at 16mm)
- [ ] ISO fixed, start 400 (no Auto ISO): MENU -> Camera Settings1 -> ISO. Do not go over about 640; add light instead
- [ ] White Balance fixed: MENU -> Camera Settings1 -> White Balance -> Color Temp./Filter (K), start at 4700K to match the Key Light
- [ ] SteadyShot Off on the tripod: MENU -> Camera Settings2 -> SteadyShot (Active crops the 4K angle of view)
- Note: Auto Slow Shutter (Camera Settings2) is what drags the shutter to 1/25 in auto; it does not work in Manual Exposure or with a fixed ISO.

## Step 5 — Color Profile
- [ ] Option 1: Picture Profile OFF; Creative Style Standard/Neutral; Contrast 0, Sat +1, Sharp +1
- [ ] OR Option 2: Picture Profile PP11 (S-Cinetone)

## Step 6 — Lighting
- [ ] Increase key light; keep ISO 100-400; do not raise ISO for low light
