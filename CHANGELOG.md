# Changelog

## [1.13.4] - Stage Colour Pop tested: FINAL as a look, NOT the default ('no filter') recording look
- User test frames (committed: Image Files/JPG/Shaders/Stage Colour Pop - Horizontal/Vertical.jpg). Measured vs the final-settings colour baseline stream frame (poses/framings differ - saturation rows are the guide): mean saturation 0.409 vs 0.377 (+8.5% relative), saturated-pixel p90 0.882 vs 0.788, highlight clipping UNCHANGED (0.86% both - lamps were already at clip in the baseline, Pop adds no blowout), skin saturation 0.60 vs 0.51 (warmer, still natural in frame). The face remains dim (skin luma ~57) - that is the known exposure/face-light item, NOT something a saturation shader can or should fix.
- VERDICT on the user's question: Pop is not 'better than just Sharpen' - they do different jobs and stack (Sharpen = detail, Pop = colour). As the default 'no filter' recording look: NO - default stays Sharpen ONLY, because the recording is the clean master for YouTube/edits (saturation baked in cannot be removed, but can always be added in edit). Pop is FINAL as the live colourful-songs look on top of Sharpen. If a punchier party variant is ever wanted, raise both gains by ~0.1 - do not exceed the 1.6-parallel simulation point.

## [1.13.3] - Wide-scroll lyrics variant DROPPED; size budget checked
- User test: the wide-scroll shader loads now but just moves the whole strip back and forth - not acceptable. Idea skipped by user decision; lyrics_karaoke_vertical_wide_scroll.shader removed from the repo. Plain lyrics_karaoke_vertical.shader stays FINAL; bigger Shorts lyrics await the future CDLC-extraction idea only.
- SIZE BUDGET (user limit 128 MB): branch tree 26.3 MB / 381 tracked files; repo working tree 28 MB; .git 82 MB (81.5 MB of blobs across ALL history - the deleted pre-v1.9.7 PNGs still live in old commits; no history rewrite per repo rule). Biggest single tracked file 1.26 MB. Guardrails kept: screenshots only as JPG q88, no PNG/raw uploads committed, frames with chat/sponsors never committed. Watch item: .git grows ~0.3 MB per committed JPG - re-check size at each version.

## [1.13.2] - REAL fix for wide-scroll shader: naked prose lines, not (only) elapsed_time
- The v1.13.1 fix was incomplete (user: 'same error'). Root cause actually found by mapping the parser's error lines through the plugin template (51 lines): the generated header text after the first // line was NOT commented - lines 2-12 were bare English prose in the code, so the parser failed at the first uniforms. The duplicate elapsed_time declaration would also have been wrong (wrapper declares it), so both fixes stand. All other NEW shaders were scanned: no other naked-prose lines, and no other file redeclares a wrapper uniform. LESSON recorded: multi-line replacement text inserted after a // marker must have // on EVERY line.

## [1.13.1] - Fix: wide-scroll lyrics shader failed to parse (duplicate elapsed_time)
- The user's screenshot showed obs-shaderfilter errors (Expected 'name'/'type') before the shader even loaded. Cause found in the plugin source: the wrapper template already declares uniform float elapsed_time (plus elapsed_time_start/show/active/enable and random/uniform params), so the re-declaration added in v1.13.0 broke its effect parser. Removed; documented in the file. RULE for all future shaders: never declare elapsed_time (or the other wrapper uniforms) in a .shader file - just use them.

## [1.13.0] - Sharpen policy DECIDED: always ON. All user settings burned into defaults
- User's new setup tested: standalone Sharpen (edge_aware, 2.0/0.01/Radius 2.0/Shadow 0.2/Max 0.12 - screenshot read) ON both clones + B&W internal sharpen 0. Measured vs previous FINAL (internal sharpen only; framings differ, crops used): detail energy +53% horizontal (687->1048), +34% vertical (1698->2284), highlights still ~0% blown, no grit visible. VERDICT: new setup is better - POLICY LOCKED: Sharpen always ON first on both clones for all 25 looks; looks with internal sharpen set theirs to 0. New frames NOT committed (chat names/sponsor in them); before/after images rebuilt from safe camera-only crops.
- All settings the user sent are now baked into the repo files as defaults: Sharpen split into edge_aware_sharpen_horizontal/vertical.shader (same values); B&W files' internal Sharpen Amount now 0.0 (thresholds kept); lyrics files got his exact colours #FFFF01 / #33FF59 / #FF1414 and Text Opacity 0.95 (vertical Bold/Outer restored to his 0.00/2.00 - his lyrics settings are shared, not per-view). Settings screenshots are OBS UI only and were read, not committed (his upload workflow keeps them in OBS).
- Larger lyrics on Shorts: a true auto-fit is impossible in a per-pixel shader (it cannot measure line length) and would need the timed vocals extracted from CDLC files (already synced inside them; a batch converter is a possible future project). Optional test variant created instead: Karaoke/lyrics_karaoke_vertical_wide_scroll.shader (zoom 1.30 + slow ping-pong scroll so long lines travel instead of overflowing; short lines drift a little too - the unavoidable trade-off). Plain _vertical remains FINAL if the drift annoys.

## [1.12.1] - Lyrics upload checked (OBS does NOT save into .shader), sharpen policy decision opened
- User uploaded his on-disk lyrics_karaoke.shader twice (edc0f26, 6e992ff) to test whether OBS writes his slider values into the file. IT DOES NOT: his copy still carried the stale file defaults Fill Solidity 2.0 / Backing Plate 0.45; his confirmed 4.0 / 0.4 live only in his OBS filter settings. Nothing else differed (all other sliders at file defaults). Repo copy restored to the tuned defaults and split per the folder rule into Karaoke/lyrics_karaoke_horizontal.shader (4.0/0.4) and lyrics_karaoke_vertical.shader (same + Bold 1, Outer Border 3); the single file is removed.
- SHARPEN CLARIFICATION (user): the standalone Sharpen (edge_aware) is NOT on the Black And White / Stage Colour Pop sources - all their settings and result pictures were made without it. IMPORTANT NUANCE: the B&W results were still made with the B&W shader's own internal sharpen sliders at their defaults (2.0 H / 1.8 V) - 'no standalone Sharpen' is not 'no sharpening at all' (user to confirm he did not zero those sliders).
- DECISION OPENED (applies to all 25 looks): either (A) edge_aware Sharpen ALWAYS ON, first on both clones, as the constant baseline every look is tuned on top of - then the B&W internal sharpen goes to 0 to avoid double-sharpening; or (B) no global sharpen anywhere. Agent recommendation: (A), because the sharpen was the confirmed fix for the 4K->1080 detail gap (v1.9.6-1.9.8), tuning stays comparable between looks, and Stage Colour Pop has no detail control of its own. User offered a test pack; decision after it: B&W Horizontal+Vertical with standalone Sharpen ON (and internal sharpen 0), plus Stage Colour Pop with Sharpen ON.

## [1.12.0] - Black N White FINAL (v2 wins), shader folders reorganised, Stage Colour Pop created
- Comparison v2 vs v1 (user's test-2 frames): horizontal luma 53.9 vs 48.1, near-black 24.0% vs 31.5%; vertical near-black 37.9% vs 43.8% and detail energy down 2203->1700 (less grit). v2 is the best of the three - look 1/25 Black N White is FINAL. Face-band rows remain framing-limited (vertical face boxes not like-for-like), recorded honestly in the memo.
- NEW STRUCTURE (user rule, applies from now on): SHADER/OLD = all 163 user-uploaded shaders + textures + catalog (renamed from NEW). SHADER/NEW/<Look Name>/ = our shaders only, one folder per look, and EVERY look ships TWO files, _horizontal and _vertical, with their own baked-in defaults. Black And White/ (mavo_black_and_white_horizontal/vertical.shader + SETTINGS_MEMO.md), Sharpen/ (edge_aware_sharpen.shader), Karaoke/ (lyrics_karaoke.shader). All doc paths updated.
- hsl_hsv_saturation's recommended music-stream use created as 'MAVO Stage Colour Pop' (NEW/Stage Colour Pop/, horizontal+vertical, HSL 1.25/HSV 1.15 H and 1.35/1.25 V, Parallel, alpha bug fixed) + its SETTINGS_MEMO.md; starting-point recommendation, user A/B still welcome.
- Before/after images: Black And White - Before After (Horizontal/Vertical).jpg are now the only shader-1 images in Image Files/JPG/Shaders/ - all other uploaded/test/simulation images for shader 1 were removed from the repo as the user asked (they remain in git history).

## [1.11.2] - Black N White preset iteration 2 (measured from user's test)
- User tested mavo_black_and_white v1 presets (examples committed: Black And White New Shader Example (Horizontal/Vertical).jpg). MEASURED VERDICT - not yet the best: face skin-band median 71 vs 98 (old saturation-0) horizontal and near-black rose 29.1%->31.5% (H) / 40.4%->43.8% (V camera area): the Contrast S-curve darkens tones below its 0.5 pivot and the face sits at 0.3-0.4, eating the Gamma lift. Vertical detail energy ~2.5x the old (863->2203 Laplacian var, different framing caveat) suggests Sharpen 2.5 grits the tighter vertical upscale. Framing differs between the old/new examples, so face-band and near-black are the trusted rows, whole-frame luma is not like-for-like.
- Shader v1.11.2 presets: Horizontal Gamma 0.85 / Contrast 0.05 / Denoise 0.15 / Sharpen 2.0 (new defaults); Vertical Gamma 0.85 / Contrast 0.08 / Denoise 0.30 / Sharpen 1.8 / Threshold 0.015. Simulation check: near-black 22.9% (v1) -> 15.4% (v2) on the reference frame. Status TUNING, one more user test needed before FINAL.

## [1.11.1] - Shader #1 of 25: Black N White (hsl_hsv_saturation) reviewed, dedicated B&W shader proposed
- User's look: 'Black N White' on the camera clone = hsl_hsv_saturation with HSL/HSV Sat Gain 0, Gammas 1, Order Parallel - identical on horizontal and vertical (measured: examples are fully desaturated, sat 0.000; luma 53 horizontal / 61 vertical). The 4 screenshots are committed as JPG in Image Files/JPG/Shaders/. Noted: the vertical clone shows different slider names ('HSL Saturation', Order as a number) - it holds an older copy of the shader text; both should load the same repo file.
- Standing rule recorded (user): EVERY look needs separate Horizontal (PC) and Vertical (mobile) settings, and ALL his existing looks were made pre-4K / pre-final camera settings, so each must be re-validated at the final settings before it is called FINAL, even saturation-type ones (tone/noise/upscale changed).
- New OBS & Stream Files/SHADER/NEW/mavo_black_and_white.shader proposed as the better B&W: Rec.709 luma + 3x3 denoise before edge-aware sharpening + Tone Gamma + Contrast S-curve, alpha preserved. Simulated (Black And White - Simulation.jpg): Horizontal preset (gamma .92/contrast .10/denoise .15/sharpen 2.0) lifts luma 53.8->58.0 and cuts near-black 26.2%->22.9% vs saturation-0; Vertical preset (gamma .88/.16/.25/2.5, for the tighter mobile crop) -> 60.2 / 20.9%. Our edge_aware_sharpen TEST grayscale is NOT better (plain luma, sharpening bypassed when the switch is on) - that idea was checked and rejected. Status: waiting for user's OBS test of the two presets; old Black N White stays as backup.

## [1.11.0] - Shader library imported into SHADER/NEW, catalogued, hsl_hsv_saturation ready
- The user's 163 files arrived as his own GitHub commits (cb88ea9 'First 100 Shaders', c783ccf 'Rest of the Shader files') into SHADER/ - this commit moves them all into OBS & Stream Files/SHADER/NEW/ as the canonical copies (they match his installed plugin). Checked against the official exeldro/obs-shaderfilter repo: identical after line-ending normalisation except 11 files (ascii, corner_pin, cut_rect_per_corner, rounded_rect, rounded_rect2, rounded_rect_per_corner, rounded_rect_per_side, rounded_stroke, rounded_stroke_gradient, zoom, zoom_blur_transition) - his versions kept. One upstream-only extra added (glitch-periodic.shader) + upstream textures/ that some shaders reference. Our edge_aware_sharpen.shader + lyrics_karaoke.shader moved into NEW/ too.
- NEW/SHADER_CATALOG.md: all 166 files catalogued (type .shader/.effect, first-pass category, settings list, warnings - .effect needs 'Use Effect File' ticked, transitions kept but flagged as not source filters). NEW/SHADER_NOTES.md started: hsl_hsv_saturation analysed from code + simulated on the user's frame (Image Files/JPG/Shaders/hsl_hsv_saturation - Simulation.jpg). Agreed order: user's 25 tuned looks first (starting with hsl_hsv_saturation), then a one-by-one review of the rest for music-stream moods/styles.

## [1.10.3] - Lyrics shader CONFIRMED FINAL (user-tested)
- User OBS test 3 with own tuning: Fill Solidity 4.0 and Backing Plate 0.4 - "works... best we can do". Result screenshot committed (Image Files/JPG/Lyrics Corrected.jpg, 296x27 strip: solid text, red outer border readable over the whole line, sung word 'tell' green, dim part still legible). These two values are now the shader defaults, so the file loads as the final look. Lyrics shader item closed; remaining Step 8 work is the other 25+ look filters.

## [1.10.2] - Lyrics shader v3: solid fill, black + red borders, backing plate
- User test of v1.10.1 (Lyrics better.jpg, 273x26 strip): history line now stays, but the middle of the line still blends into the CD wall and is unreadable at that size - letter centres were semi-transparent (soft key) so the background showed through, and the history tier thinned the outline again. User approved a red border if needed.
- lyrics_karaoke.shader v1.10.2: new Fill Solidity (2.0) makes letter cores fully opaque; Outline default 3 px and no longer reduced for dim lines; new RED Outer Border (2 px) outside the black stroke; new Backing Plate (0.45) darkens the background right around the words; soft Glow slider removed (replaced by the plate). For Shorts-size text: Outline 4 / Outer Border 3. Simulation regenerated at the user's real 273 px width to check small-size readability. OBS re-test pending.

## [1.10.1] - Lyrics shader v2: keep the dim history line
- User OBS test of v1.10.0 (screenshots committed as JPG: Lyrics Shader In Action / Lyrics Shader Settings): the shader works in OBS and the highlight split works for real - the sung word "look" came out green, the rest yellow. BUT Rocksmith's dim previous/next line was keyed out (Threshold 0.25 + De-speckle 0.5), so there was no history of the line on screen, which the user wants kept. Also the Filters preview showed the shader painting the whole game frame (note highway) because it keys any bright pixel.
- lyrics_karaoke.shader v1.10.1: Threshold default 0.12, Softness 0.5, De-speckle 0.25, new History Opacity (0.6) - dim lines are kept readable but secondary, with a fainter outline; main line stays solid. Guide updated; simulation preview regenerated with a dim history line. Crop warning added: put Crop/Pad above the shader or keep the tight scene crop, never use the full game frame as visible output. Still pending: user re-test. Note: a per-pixel shader cannot make a line linger after Rocksmith removes it (no previous-frame access); the history it can keep is the dim line Rocksmith itself shows.

## [1.10.0] - Karaoke lyrics shader (Step 8, awaiting OBS test)
- New `OBS & Stream Files/SHADER/lyrics_karaoke.shader` replaces the Chroma Key (#000000, all sliders 1, Contrast -4) + Colour Correction (Gamma -3, Contrast 4, Saturation 5, Hue Shift 180, Multiply #FFFF00) pair on the Rocksmith lyrics source, whose extreme settings crushed anti-aliased letters into semi-transparent blobs. The shader keys on brightness with a soft threshold + de-speckle, paints flat yellow text, keeps a Highlight colour for strongly coloured source pixels (e.g. a game-coloured sung syllable), and adds dark outline + optional glow/bold for fullscreen and Shorts readability. Guide: Text Files/MD/LYRICS_SHADER_GUIDE.md.
- Validated by NumPy/Pillow simulation on a synthetic noisy lyric line (Image Files/JPG/Lyrics Shader - Simulated Preview.jpg); NOT yet tested in OBS - user test pending, old filters to be disabled (not deleted) as backup. User's three lyrics screenshots committed as JPG q88 (Lyrics Chroma Key / Lyrics Color Correction / Lyrics Results).

## [1.9.8] - Vertical YT settings recorded (dormant), fullscreen frames measured vs Chainbrain
- Aitum Multistream > Vertical Canvas screenshot received and committed as JPG q88 (Image Files/JPG/Aitum Multistream - Vertical Canvas YT Settings.jpg): NVENC H.264, 25 Original, CBR 8000, keyframe 0 (auto), P5, High Quality, Two Passes Quarter, Look-ahead + AQ on, B-frames 2. User clarification: he does not stream from the vertical/YT outputs and vertical recording uses the main OBS horizontal settings - so this block is dormant, affects nothing, and its keyframe 0 needs no fix.
- First true fullscreen 1080p final-settings stream frames measured (Twitch, Kick, Twitch close-up; NOT committed - chat names/sponsor visible, measurements only in IMAGE_NOTES.md): detail energy Lap. var. 999-1147 vs Chainbrain 973 and old pre-final 689-792 - the sharpness/detail gap is closed. Twitch and Kick are virtually identical (Main Encoder confirmed). Remaining gap is face brightness (front-on skin median ~67-68 vs Chainbrain ~100, pose/cap shadow contribute; close-up 90) and 25 vs 60 fps - not bitrate. Step 7 like-for-like item ticked.

All notable changes to this repository are documented here.
Versioning: MAJOR.MINOR.PATCH. Bump on each completed setup step.

## [1.9.7] - PNG->JPG conversion, CONTEXT.md rewrite, frame comparison measured
- Repo size: all 31 PNGs in Image Files/PNG (53.6 MB) converted to JPG q88 in Image Files/JPG (8.6 MB total, same basenames), PNG originals deleted from the working tree. No git history rewrite, no force-push (.git stays 64 MB). References in IMAGE_NOTES.md / OBS_ZOOM_GUIDE.md updated; Image Files/PNG kept as empty folder.
- CONTEXT.md rewritten fully (was stale since ~v1.5): current rig, final settings, OBS, lessons/corrections, never-commit list, pending Step 8. AI_HANDOFF_CONTEXT.md marked superseded there.
- Frame comparison by measurement (Pillow/NumPy): Chainbrain reference luma 58.5, 24.3% near-black, Laplacian var. 973; old fullscreen Mavo frames luma 51-68, 24-32% near-black, Lap. var. 689-792 (pre-final settings). Final-settings OBS preview is at 56% scale, so not like-for-like; no true fullscreen 1080p final stream frame in repo yet - Step 7 item remains open. README Key Light corrected 48% -> 44%.

## [1.9.6] - Sharpen filter confirmed, Step 8 started
- User confirmed the black-and-white test (shader runs). Boost map: sharpening only on real edges, flat skin and shadows untouched. Close and far shots at 100%: natural detail, no halos or added noise. Step 7 sharpness item done.
- Step 8 (ShaderFilter retune) started: need the list of the 25+ filters and the shader files.

## [1.9.5] - Shader v2
- User test: edge_aware_sharpen loads without errors but no visible change (screenshots at 56% preview, Threshold 0.015, Radius 1). Cause: on a 4K source the per-pixel detail is far below the old threshold, and a 56% preview hides the effect. A proxy test on a soft 4K-like frame: old defaults +14% edges; Amount 2 / Threshold 0.01 / Radius 2 gives +57% with noise unchanged.
- Shader v2: new defaults and two test switches (black and white, boost map).
- '44Light' = Key Light 44% at 4700K (was 48%). Recording settings read: CQP 18 NVENC, applies to Aitum Vertical too.

## [1.9.4] - Test stream, sharpness
- User applied all OBS output/recording settings and streamed: no dropped frames, lag or crash.
- DRO retest: DRO On and Off give almost the same frame stats (43/40% vs 44/41%). My earlier claim that DRO Off darkened the room was wrong; framing, pose and lights changed between shots.
- Sharpness: the recording frame has about twice the fine-detail energy of the Twitch/Kick frames in the same shelf region (Laplacian variance 218 vs 106-126), but the stream screenshots are scaled player windows, so the number is only a hint.
- New `OBS & Stream Files/SHADER/edge_aware_sharpen.shader` (ShaderFilter): luma-only, noise threshold, shadow protect, halo limit. Numpy simulation: dark-area noise unchanged, edges +36%; built-in style sharpen: noise +28%. HLSL untested in OBS.
- Stream frames not committed (viewer chat names and sponsor panel visible); only measurements were recorded.

## [1.9.3] - Camera AF/DRO applied, vertical encoder read
- User applied AF Transition Speed 4, AF Subj. Shift Sens. 1 and DRO Off (photos verified). OBS shot with a cap: frame luma 44, 41% near-black (more crushed than before); face unchanged. Recommendation: DRO back On, or ISO 640 plus brighter lamps if DRO stays Off.
- Aitum Vertical streaming fields (NVENC H.264 6000 kbps, tuning Ultra Low Latency) are controlled from Aitum Multistream > Vertical Canvas; to be checked there. Added the new OBS screenshot (JPG).

## [1.9.2] - Recording, multistream and Chainbrain stats
- Recording tab: MKV using the stream encoder (NVENC H.264 CBR 8000 kbps). Recommended a separate CQP recording encoder.
- Aitum Multistream (Kick, Blaze) use the Main Encoder; Aitum Vertical records at 6000 kbps with the main settings. Both plugins have updates, to be done after the test stream.
- Chainbrain YouTube stats: 1080p60, AV1/Opus. Our source is 25 fps, so smoothness differs.
- Camera: AF Transition Speed 7 and AF Subj. Shift Sens. 5 (fast and responsive) found in the Movie2 menu photo; recommend slower, locked-on values. DRO location documented.
- The recording folder path is not recorded (it contains the Windows user name).

## [1.9.1] - OBS output settings reviewed
- OBS Video and Output (Streaming) screenshots read: 1080p25 canvas, NVENC H.264 CBR 8000 kbps, keyframe auto, P4, Look-ahead and Adaptive Quantisation off. Video settings are correct. Recommended: keyframe 2 s, P5/P6, Look-ahead and Adaptive Quantisation on (not applied yet).
- Multistream uses Aitum Multistream (Twitch main; Kick and Blaze clone it). The vertical view is Aitum Vertical (not the plain OBS dock).
- Finding: at 25 fps, 8000 kbps is about 3x the bits per frame of 6000 kbps at 60 fps, so bitrate is not the cause of the quality gap.

## [1.9.0] - Step 7 started, README and hand-over guide
- README rewritten (final settings table, file list, working rules: update the docs on every edit).
- New shareable guide `Text Files/MD/ZV-E10_STREAMING_GUIDE.md` (no personal data) for others with the same camera.
- Checklist: Step 7 (picture quality fine-tuning) and Step 8 (ShaderFilter retune) added. Step 3 FPS text fixed (25, not 30). f/2.8 zoom figure corrected (about 0.6 stop, not 1.3).
- User: temperature icon disappeared about 10 minutes after the fan; Vertical black-and-white is intentional.
- Chainbrain 2 screenshot reviewed, not committed (chat names). Bitrate guidance (Twitch about 6000 kbps CBR, YouTube higher) comes from third-party summaries, to be confirmed against the platform docs.

## [1.8.1] - LED lamps recorded
- Left and right LED floor lamps are controlled by a phone app (Bluetooth): both at 28%, left blue, right red. New OBS shot (ISO 500, PP Off, 4700K, lamps 28%): frame luma 50, forehead luma about 135 (sitting closer, slightly dimmer than the earlier 159); shelf neutral. Optional ISO 640 if the Key Light stays at 48%.

## [1.8.0] - Step 6 complete (lighting); correction
- CORRECTION: the v1.7.0 claim that the face was about 2 stops darker than Chainbrain came from measuring the wrong image region. Re-measured on the forehead: 159 (ISO 500, PP Off, 4700K) vs about 163 for Chainbrain, so ISO 500 is right and no extra light is needed. Wrong numbers removed from the notes.
- User photos of the Key Light setup: Elgato Key Light stand is taped and cannot move. Brightness stays at 48%. WB 4300K tested; no meaningful difference from 4700K.
- Photos and the Key Light device screenshot (serial number, IP) were NOT committed: they show a serial number, an IP address, personal folder names on the monitors and names on the whiteboard. Only firmware 1.0.3 and the model were recorded.
- Fan on the camera and Airplane Mode On recorded. Orange temperature icon still to be checked in a long run. Optional: lower the red LED strip, faster lens later. Added the 4300K screenshot (JPG).

## [1.7.0] - Step 5 complete (colour profile)
- Tested Picture Profile Off and PP1-PP10 at ISO 500 (11 screenshots, stored as JPG). No PP11 on the original ZV-E10 (earlier advice was wrong; fixed).
- Decision: Picture Profile Off, Creative Style Standard. Matches the Chainbrain black level; PP3-PP6 are flatter, PP7-PP10 are log/HLG.
- ISO 500: frame luma 60 vs Chainbrain 59. (The face-brightness claim originally written here was wrong, see 1.8.0.)

## [1.6.0] - Step 4 complete (exposure)
- User fixed the aperture to F3.5, ISO 250, WB 4700K, shutter 1/50, SteadyShot Off, Manual Exposure; fan on the camera, Airplane Mode On. Monitor Brightness is greyed out.
- Measured the OBS screenshot: clean at ISO 250 but face about 1 stop under (luma 75/255; 47% of pixels near black). Recommended ISO 500 (max 640). Step 4 ticked; final ISO is confirmed in Step 5 screenshots.
- Step 6 lighting rule relaxed from ISO 100-400 to ISO 250-640 at F3.5. Screenshot added.

## [1.5.10] - Step 4: white balance done, aperture still stuck
- User set WB 4700K and ISO 640, Key Light 48%, and removed a Sharpen filter from the main OBS source. OBS result looks natural and brighter.
- Aperture still F5.6 (photos: ISO 400 MM -0.7, ISO 640 MM -0.3). Dial/Wheel Setup = wheel Tv / dial Av read from the menu photos; fixes recorded in the checklist.
- Noticed an orange temperature icon on the camera live view; added a thermal warning to the checklist. Added 3 images.

## [1.5.9] - Step 4 progress, camera menus reviewed
- User added Image Files/Menus (32 photos, no EXIF/GPS, no serial numbers; all viewed). Movie Shoot Mode = Manual Exposure, 1/50, ISO 400, Movie SteadyShot Off, 4K Output Select = HDMI Only(25p) confirmed.
- Found: aperture is F5.6 (MM -1.0), not F3.5 - about 1.4 stops lost, the likely reason the image got dark. White Balance still Auto.
- Ticked the 4K Output Select item in Step 3 and four Step 4 items; Step 4 still open (aperture, white balance). Key Light to stay low (user eye comfort).

## [1.5.8] - Step 4 started: baseline and plan
- Camera screen photo (all auto): 1/25, F3.5, Auto ISO 250. The 1/25 shutter at 25p is Auto Slow Shutter (long exposure, motion blur, noisy-looking dark areas).
- Key Light currently 4700K 48% (user). Step 4 checklist rewritten with menu paths and an order. Nothing ticked yet. Elgato Control Center screenshot not committed (device name).

## [1.5.7] - Vertical crop accepted
- User-tuned vertical crop L800 R1270 T660 B50 checked: matches the Shorts reference (headphones 28% of width, glasses centred). Exact 9:16 equivalent L1277 R1747 T660 B50.
- Quality check: 1.32x upscale (816 px -> 1080 px), acceptable for phones; grain is the bigger issue (Step 4/6). Added screenshot.

## [1.5.6] - Vertical crop measured against the Shorts reference
- User result L1020 R1605 T250 B0 looked wider than the Short. Measured glasses/face width and position against the YouTube Shorts frame: about 1.15x tighter needed.
- New vertical crop L1145 R1761 T465 B34 (exact 9:16, 934x1661). Corrected the earlier claim that the Short could not be matched (it was based on a leaning pose).
- Added the screenshot of the user's result.

## [1.5.5] - Vertical canvas setup
- Diagnosed the Vertical clone: 3840x2160 with 3840x2160 bounds and no crop shows only the top-left corner of the 4K frame; Fit to Screen uses the 1920x1080 canvas.
- Added vertical Edit Transform recipe (bounds 1080x1920, Cover, Crop Bounds, crop L1020 R1605 T0 B0) to OBS_ZOOM_GUIDE.md and crop_presets.yaml.
- Added 2 screenshots (vertical Edit Transform, YouTube Shorts target look). Values are untested starting points.

## [1.5.4] - 16mm crops aligned; latency advice
- User-tuned 16mm crops accepted (LEDs at both edges): before 1010/1250/1130/95, during 1010/1250/1032/210. Exact 16:9 equivalents recorded.
- Added latency section (Buffering Disable, NV12, audio Sync Offset) and 4 screenshots.

## [1.5.3] - 16mm vs 18mm comparison
- Tested 16mm crops at 18mm: too tight. Added 18mm crop numbers and the clone mapping (2 2 = before playing, 2 = during playing).
- Documented sharpness maths and repeatability trade-off; recommendation: 16mm + crop. Noted visible noise in dark areas (exposure, Step 4/6).
- Added 4 screenshots (18mm, cropped and uncropped).

## [1.5.2] - First crop result + per-clone presets
- Tested crop 980/1260/1110/150: LEDs at both edges, horizontal framing matches old VOD target.
- Added suggested vertical tweaks for the "before songs" and "playing songs" clones; stored in OBS & Stream Files/SCENE/crop_presets.yaml.
- Added screenshots: uncropped, cropped, old VOD target frames (before songs / playing songs).

## [1.5.1] - OBS crop troubleshooting
- Edit Transform screenshots added. OBS 32 shows bounds type "Cover" (no "Scale to inner bounds"); Cover works for 16:9 crops.
- Explained crop 0 = full zoomed-out frame, and why crop 3840/2160 gives a black screen.
- Corrected the LED-edge estimate: needs about 2.4x not 1.2x; recommend about 1.2x lens zoom plus about 2.0x crop. Added crop numbers and a vertical-canvas starting point.

## [1.5.0] - Step 3 complete (OBS side): 4K source at 25 fps
- OBS Cam Link source now 4K (appears at 100% = 2x size on the 1080p canvas); OBS FPS 25; Lanczos set (user reported, screenshots added).
- Added Text Files/MD/OBS_ZOOM_GUIDE.md: Fit to Screen, Scale-to-inner-bounds crop zoom, crop formula and starting values.
- Added OBS main window screenshots (default 4K size and positioned) to Image Files/PNG/.
- To do: per-item Fit to Screen/crop on clones, tune crop for LED-edge framing, confirm camera File Format = 4K and 4K Output Select = HDMI Only(25p).

## [1.4.0] - Step 2 complete; Step 3 HDMI item done
- Verified by photo: Zoom Range = ClearImage Zoom (Camera Settings2, Zoom page 6/9). Step 2 ticked (optional lens deferred).
- Verified by photo: HDMI Info. Display = Off. Step 3 HDMI item ticked.
- Recorded current state: File Format = XAVC S HD, 4K Output Select = Memory Card+HDMI, HDMI Resolution = Auto.
- Recorded OBS Cam Link source: Device Default, Colour Space/Range Default, Buffering Auto-Detect, hardware decoding off, audio = capture audio only; driver Video Proc Amp all defaults.
- Added settings screenshots (OBS x3, camera menus x4) and Settings Files/YAML/current_settings.yaml.
- Still to do in Step 3: OBS source to Custom 3840x2160 @ 25 fps (PAL) with camera in 4K, HDMI Only(25p).

## [1.3.5] - Step 2 started: corrections after checking Sony's help guide
- Corrected menu path: Clear Image Zoom lives under "Zoom Range" (MENU -> Camera Settings2 -> Zoom Range), not "Zoom Setting".
- Corrected "standby" advice: no true standby on ZV-E10 while USB-powered/HDMI-connected (Power Save is disabled). Advice is now: leave the camera ON.
- Clear Image Zoom limits recorded: about 1.5x in 4K, about 2x in HD.
- Recorded user confirmations: camera on WW07 20W PD adapter, region PAL (25p/50p). Shutter guidance for PAL added.

## [1.3.4] - Power, menu and retention photos verified (batch 4); all photos in
- Added and viewed: Power Temp-High, USB-C Connected 1/2, Connector Alternative (+ Specs), Alternative USB-s On Extender, Menu Burnt Into Screen.
- Verified Auto Power OFF Temp. = High on the camera menu (Step 1 item 2).
- Alt connector WW07-G3b-PD: PD 20W max; serial number on label redacted in the committed copy.
- Burnt-in menu photo: faint ghost behind a live view that still updates = image retention, not frozen.
- CORRECTION to v1.3.3 notes: the braided cable in Panel Out/Front/Side is the micro-HDMI lead, not USB-C. USB-C power is the black cable in USB-C Connected 1.
- Noted camera shows 1/50 and Auto ISO 320 (PAL region likely; Step 4 needs ISO lock).

## [1.3.3] - Hardware photos verified (batch 3)
- Added and viewed: Cam Link 4K Connected, Cam Link 4K Model, USB 10G Ports, ZV E-10 Panel Out.
- Back/Front/Side already in repo (byte-identical to re-uploads).
- Cam Link Model photo: serial number blacked out before commit (model 20GAM9901 left visible).
- Panel Out confirms LCD flipped out and USB-C cable connected; Cam Link on rear USB, see IMAGE_NOTES.md.

## [1.3.2] - Reference images verified
- Re-uploaded Chainbrain + 3 Mavo problem samples confirmed byte-identical to repo copies; viewed all four.
- Added Text Files/MD/IMAGE_NOTES.md with verified visual descriptions.

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
