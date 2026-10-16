# Sony ZV-E10 as a streaming webcam: a tested setup guide

A shareable summary of a real setup that fixed the usual ZV-E10 streaming problems: zoom resetting, soft or "480p looking" zoom in OBS,
stuttering 4K, overheating on long streams, dim or noisy picture and a washed-out colour profile.

**Tested on:** Sony ZV-E10 (PAL region), E PZ 16-50mm f/3.5-5.6 OSS, Elgato Cam Link 4K, OBS 32.1.2 (Windows 10, RTX 4060),
camera powered over USB-C, micro-HDMI to the Cam Link, one Elgato Key Light plus two RGB floor lamps.
Menu names are from the ZV-E10 (not the ZV-E10 II). Your room will differ, so use the *method* (measure, then adjust), not just the numbers.

## 1. Connections and power
- HDMI: micro-HDMI cable from the camera to the Cam Link 4K, Cam Link in a USB 3.0 port (any rear port is fine; it is a 5 Gbps device).
- Power: USB-C cable from the camera to a wall adapter (not a PC port). MENU -> Setup -> USB Power Supply = On. Camera shows "charging".
  If the adapter has several ports, keep the others empty, as some adapters share the power budget.
- Do not use the battery for long streams.

## 2. Heat (long streams, 2-24 hours)
- MENU -> Setup -> Power Setting Option -> **Auto Power OFF Temp. = High** (Sony says High needs the camera on a tripod, not in your hand).
- Flip the LCD out to the side (90 degrees or more) so the body can dissipate heat.
- Power Save Start Time = Off. Network -> **Airplane Mode = On** (less radio heat).
- A small USB fan pointed at the camera body made the orange temperature icon on the live view disappear about 10 minutes after it was switched on.
- Setup -> HDMI Settings -> HDMI Info. Display = **Off** so no menus appear in OBS.

## 3. Zoom resetting when the camera turns off
The E PZ 16-50 is a power-zoom lens: it returns to 16mm every time the camera powers off, and there is no in-camera memory for it.
- Fix used: **keep the camera on** between streams (it is USB powered).
- Better fix: use **16mm and zoom by cropping in OBS** (section 6), so a power-off changes nothing.
- A lens with a manual zoom ring (or a prime) also removes the problem.
- MENU -> Camera Settings2 -> Zoom Range = ClearImage Zoom if you want extra zoom in the camera (about 1.5x in 4K), but cropping in OBS is simpler.

## 4. Output: true 4K to the Cam Link
- MENU -> Setup -> **4K Output Select = HDMI Only (25p)**. This needs the PAL region (25 fps). It does not record to the card, which is expected.
- Proxy Recording = Off.
- In OBS the video capture device: Resolution/FPS Type = Custom, **3840 x 2160, 25 fps**. Buffering = Disable (lowest delay). Prefer NV12 if offered.
  Leave hardware decoding off.
- Match the OBS canvas FPS to the camera: 25 (or 50). A 30 or 60 fps canvas shows 25 fps video with uneven repeated frames (judder).

## 5. Exposure: set it by hand
Auto exposure on a webcam setup drifts and adds noise. Settings that worked (indoors, one key light):
- MENU -> Camera Settings2 -> Movie1 -> **Shoot Mode = Manual Exposure**.
- **Shutter 1/50** at 25 fps (twice the frame time). Turn the rear control wheel. Aperture on the control dial. If the aperture is stuck (it was stuck at F5.6),
  check Camera Settings2 -> Custom Operation1 -> Dial/Wheel Setup and Dial/Wheel Lock = Unlock.
- **Aperture wide open (F3.5 at 16mm)**: that is about 1.4 stops more light than F5.6.
- **ISO fixed**: press ISO on the rear wheel, then turn the wheel. 250 was too dark here (47% of the picture almost black); **500** matched the reference look.
  Higher ISO is cleaner than it sounds on this sensor, but more light is always better than more ISO.
- **SteadyShot (movie) = Off** on a tripod (Camera Settings2 -> Movie3).
- Check face brightness on the **forehead** in OBS, not the whole frame: a forehead luma (0-255) of about 130-160 looked right. Frame luma around 60 with
  a dark room is normal.
- Auto Slow Shutter has no effect in Manual Exposure.

### Focus (stops the picture "breathing")
Continuous AF with Wide area can refocus on the background or hunt when you move. In Camera Settings2 -> Movie2: **AF Transition Speed** lower (about 3-4; default 5-7 is fast)
and **AF Subj. Shift Sens.** lower (1-2 = locked on the subject; 5 = very responsive). Camera Settings1 -> AF1 holds Focus Mode and Face/Eye AF Set.
DRO/Auto HDR (Camera Settings1 -> Color/WB/Img. Processing1) changes shadows by scene; try Off if the brightness drifts.

## 6. Zoom by cropping in OBS (stays sharp up to 2x)
A 3840x2160 source on a 1920x1080 canvas looks like a massive zoom-in because OBS places it at 100%. It is not a camera zoom.
1. Select the source, press **Ctrl+F** (Fit to Screen). That is your normal wide view, with 4x the pixels behind it.
2. Right-click -> **Scale Filtering -> Lanczos** (stored per source/clone, repeat for each).
3. **Ctrl+E** (Edit Transform): Position 0,0; top-left alignment; Bounds type **Cover**; Bounds 1920x1080; **Crop Bounds** ticked.
4. Crop is in SOURCE pixels. Zoom z: Left+Right = 3840 - 3840/z ; Top+Bottom = 2160 - 2160/z. Trade Left/Right to move sideways, Top/Bottom to move up/down.
   2.0x is exactly 1:1 pixels (sharp); about 2.4x is only a mild 1.2x upscale.
5. Each clone ([CLONE] sources) needs its own crop and filtering.
- Vertical 9:16 canvas (1080x1920): same method with bounds 1080x1920. Window must be 9:16: Left+Right = 3840 - (2160 - Top - Bottom) * 9 / 16.
  A window narrower than 9:16 is upscaled; keep the upscale under about 1.3x.

## 7. Colour: picture profile
- **The ZV-E10 has only PP1-PP10. There is no PP11 / S-Cinetone** (that is on the ZV-E10 II).
- 11 screenshots of PP Off and PP1-PP10 compared at the same exposure: **Picture Profile Off with Creative Style Standard** (all 0) gave natural skin and a normal
  black level. PP3/PP4 lift the shadows (flat), PP5/PP6 (Cine) are flat, PP7-PP10 (S-Log2, S-Log3, HLG) are for colour grading and look washed out unless you grade them.
- MENU -> Camera Settings1 -> Color/WB/Img. Processing1 -> Picture Profile / White Balance.
- **White Balance: fixed Kelvin, matched to your light.** Elgato Key Light at 4700K -> camera 4700K. Do not leave it on Auto (colour shifts as you move).
  Testing 4300K gave no useful change here.

## 8. Lighting
- The face should be the brightest large area of the picture. Light on the face fixes dim, grainy video more than any camera setting.
- If the light cannot be moved, the options are: raise its brightness a little, add diffusion for a softer look, add a small second light or a white bounce card on the shadow side, a faster lens.
- Coloured room lights (LED strips/lamps) at a low brightness (here 28%) keep the white furniture neutral instead of tinted.
- Faster lens maths: light gain = (old f-number / new f-number) squared. F3.5 to F2.8 is about 0.6 stop; F3.5 to F1.4 is about 2.6 stops.

## 9. OBS encoder (NVIDIA GPU)
Settings -> Output -> Advanced: NVENC H.264, CBR, keyframe interval **2 s** (platforms expect this; "0 = auto" is not the same), preset **P5/P6** (P4 is fine if the GPU is busy),
tuning High Quality, **Look-ahead and Adaptive Quantisation on** (they help flat, dark areas look less blocky), B-frames 2.
At 25 fps even 6000-8000 kbps is a lot of data per frame, so the encoder is rarely the quality limit for a talking-head scene.
Check View -> Stats for dropped frames after changing anything.

## 10. Delay and sync
HDMI capture adds about 100-200 ms. Set OBS Buffering = Disable, then delay the microphone with Advanced Audio Properties -> Sync Offset until a clap
is in sync (record a clap and compare the spikes).

## 11. Things that did NOT help (so you can skip them)
- Recommending PP11 (does not exist on this model).
- Lowering white balance to 4300K for cooler skin (about the same, slightly worse).
- A Sharpen filter on top of 4K video (looked crunchy; removed).

## 12. Quick checklist before a long stream
1. Camera on (never power-cycled), orange temperature icon not showing, fan running.
2. Manual Exposure, 1/50, F3.5, ISO fixed, WB fixed, PP Off.
3. OBS: 3840x2160 @ 25 source, Buffering Disable, Lanczos on every clone, canvas 25/50 fps.
4. Check the OBS stats (View -> Stats) for skipped, missed and dropped frames after the first 10 minutes.
