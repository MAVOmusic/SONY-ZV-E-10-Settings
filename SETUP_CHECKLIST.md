# Sony ZV-E10 Streaming Setup Checklist

Tick each step as completed. Update VERSION.txt and CHANGELOG.md when a setup is completed.

## Step 1 — Thermal & Power Management (24h operation)
- [x] Flip LCD screen out 90-180 degrees from body (done; photo verified v1.3.3: LCD swung out ~90 degrees to the side; Image Files/JPG/ZV E-10 Panel Out.jpg)
- [x] Menu -> Setup (Yellow Toolbox) -> Power Option -> Auto Power OFF Temp. -> HIGH (photo verified v1.3.4: menu shows Auto Power OFF Temp. = High; Image Files/JPG/ZV E-10 Power Temp-High.jpg)
- [x] USB-C cable to dedicated USB-C PD wall adapter (not motherboard port) (photos verified v1.3.4: black USB-C cable in the side port, adapter on surge strip; alt connector WW07-G3b-PD is PD 20W max - USB-C + USB-A share 5V 3A, so keep its other ports empty; Image Files/JPG/ZV E-10 USB-C Connected 1/2.jpg)

## Step 2 — Zoom Memory & Quality
- [ ] Keep camera powered via USB-C PD; use standby, not full power-down
- [ ] Menu -> Movie -> Zoom -> Zoom Setting -> Clear Image Zoom -> ON
- [ ] (Optional) Upgrade to manual zoom lens (Sigma 18-50 f/2.8 / Tamron 17-70 f/2.8)

## Step 3 — OBS & Cam Link 4K
- [x] Cam Link 4K plugged into REAR 10G (red) port (upgraded from 5G blue) — photo viewed v1.3.3: Cam Link sits next to the right 10G port, most likely in the hidden left 10G port; Image Files/JPG/Cam Link 4K Connected.jpg / USB 10G Ports.jpg. Note: Cam Link 4K is USB 3.0 (5 Gbps), so 10G gives no extra speed - rear 5G/10G are equally fine
- [ ] Menu -> Setup -> HDMI Settings -> HDMI Info Display -> OFF
- [ ] OBS source: Custom, 3840x2160 or 1920x1080, FPS = 30 (match camera; no 60 on 4K)

## Step 4 — Exposure & Sharpness (Manual)
- [ ] Mode dial Movie, Exposure Mode M
- [ ] Shutter 1/60 (30fps) or 1/120 (60fps)
- [ ] Aperture lowest (f/3.5 wide / f/5.6 tele)
- [ ] ISO locked 100-400 (no Auto ISO)
- [ ] White Balance locked (e.g. 5500K), AWB off

## Step 5 — Color Profile
- [ ] Option 1: Picture Profile OFF; Creative Style Standard/Neutral; Contrast 0, Sat +1, Sharp +1
- [ ] OR Option 2: Picture Profile PP11 (S-Cinetone)

## Step 6 — Lighting
- [ ] Increase key light; keep ISO 100-400; do not raise ISO for low light
