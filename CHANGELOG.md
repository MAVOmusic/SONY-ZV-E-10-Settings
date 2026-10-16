# Changelog

All notable changes to this repository are documented here.
Versioning: MAJOR.MINOR.PATCH. Bump on each completed setup step.

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
