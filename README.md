# SONY-ZV-E-10-Settings

A tested Sony ZV-E10 streaming setup (Cam Link 4K + OBS), written up step by step with photos and measurements.
Rig: ZV-E10 (PAL) + E PZ 16-50mm, Elgato Cam Link 4K, USB-C power, OBS 32.1.2 on Windows 10, Elgato Key Light plus RGB floor lamps.

**Current version:** see `VERSION.txt`. **Status:** Steps 1-6 done; Step 7 (quality fine-tuning) nearly done, Step 8 (ShaderFilter retune) started. Vertical YouTube outputs in Aitum Multistream are dormant (not streamed from; vertical recording uses the main horizontal settings). All screenshots are JPG (q88) since v1.9.7 — `Image Files/PNG/` is empty; do not commit large PNGs. Sharpening: `OBS & Stream Files/SHADER/NEW/Sharpen/edge_aware_sharpen.shader`. Lyrics: `OBS & Stream Files/SHADER/NEW/Karaoke/lyrics_karaoke_horizontal.shader (+ _vertical)` (karaoke-yellow Rocksmith lyrics, replaces the Chroma Key + Colour Correction pair; guide in `Text Files/MD/LYRICS_SHADER_GUIDE.md`, OBS test pending).

## Final settings in one place
| Area | Setting |
|---|---|
| Heat | Auto Power OFF Temp High, LCD flipped out, Airplane Mode On, fan on the camera (orange temperature icon gone about 10 min after the fan) |
| Zoom | 16mm + crop in OBS; camera kept on so the lens never resets |
| Output | 4K Output Select = HDMI Only (25p), Cam Link source 3840x2160 @ 25 fps, Lanczos, Buffering Disable |
| Exposure | Manual Exposure, 1/50, F3.5, ISO 500 |
| Colour | Picture Profile Off, Creative Style Standard (0/0/0), WB 4700K |
| Light | Elgato Key Light 4700K 44% (fixed position — NEVER move it), LED lamps 28% (left blue, right red) |
| OBS crops | see `OBS & Stream Files/SCENE/crop_presets.yaml` |
| Vertical | Aitum Vertical; black-and-white filter on purpose (main look); may change to no filter by default |
| Streaming | OBS 1080p25, NVENC H.264 CBR 8000 kbps; Aitum Multistream to Twitch (main), Kick, Blaze |

## Files
- `Text Files/MD/ZV-E10_STREAMING_GUIDE.md` - **hand-over guide** for anyone with the same camera (no personal data).
- `SETUP_CHECKLIST.md` - step-by-step list with what was verified and how.
- `CONTEXT.md` - sanitized system facts and the original problem statement.
- `Text Files/MD/OBS_ZOOM_GUIDE.md` - OBS 4K scaling, crop maths and vertical canvas.
- `Text Files/MD/IMAGE_NOTES.md` - what each image shows and the measurements taken from it.
- `Settings Files/YAML/current_settings.yaml` - settings snapshots per step.
- `OBS & Stream Files/SCENE/crop_presets.yaml` - OBS Edit Transform crops.
- `CHANGELOG.md`, `VERSION.txt` - history. `Image Files/` - menus, screenshots, hardware photos, Picture Profile tests.
- Other folders are the file-format folders (kept for future files).

## Working rules for this repo
1. Never commit system-info files (DxDiag, Msinfo, About), serial numbers, IP addresses, or screenshots with personal content. Record only sanitized facts.
2. After every edit that changes a setting: update `SETUP_CHECKLIST.md`, `current_settings.yaml`, `CHANGELOG.md`, `VERSION.txt` and this README, then commit and push.
3. Put new files in the matching format folder.
