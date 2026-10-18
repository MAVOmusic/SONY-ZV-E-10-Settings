# Shader catalog - OBS & Stream Files/SHADER/OLD (user library, v1.12.0)

Source: the USER-S files (163, from his installed obs-shaderfilter 2.4.3 example pack, committed by him and moved here) + 1 upstream-only extra (glitch-periodic.shader) + our two own shaders. Checked against the official exeldro/obs-shaderfilter repo (master 4b48d4f): all identical after line-ending normalisation except 11 files (his versions kept). Textures some reference are in OLD/textures/.

Total: 166 shader/effect files + textures folder. Our own: `edge_aware_sharpen.shader` (CONFIRMED), `lyrics_karaoke.shader` (CONFIRMED FINAL).
How to read 'Type': `.shader` loads with the normal ShaderFilter file loader; `.effect` needs the filter's **Use Effect File (.effect)** option ticked. Files marked TRANSITION are for scene transitions and will look broken/blank as a source filter - they are kept for completeness, skip them for look-tuning.
Categories are a first-pass sort by filename for planning only; the real per-shader verdict (music-stream use, mood, GPU note) gets written here one by one AFTER the user's 25 tuned looks are processed, as agreed.

| File | Type | Category (first pass) | # settings | Settings (first 12) | Needs / warnings |
|---|---|---|---|---|---|
| 3d-panel.shader | .shader | Frame/border/mask | 13 | credits, scale, tilt_x_deg, tilt_y_deg, tilt_z_deg, pos_x, pos_y, thickness, radius_fb, brightness, light_position, wiggle ... | animated (uses time) |
| 3d_swap_transition.shader | .shader | Transition (not a filter) | 8 | image_a, image_b, transition_time, convert_linear, reflection, perspective, depth, background_color | needs texture file (in OLD/textures or pick your own); animated (uses time); TRANSITION shader - meant for scene transitions, not a source filter |
| Add.shader | .shader | Composite/blend/key | 1 | other_image | needs texture file (in OLD/textures or pick your own) |
| alpha-gaming-bent-camera.shader | .shader | Composite/blend/key | 10 | left_side_width, left_side_size, left_side_shadow, left_flip_width, left_flip_shadow, right_side_width, right_side_size, right_side_shadow, right_flip_width, right_flip_shadow |  |
| alpha_border.shader | .shader | Frame/border/mask | 3 | border_color, border_thickness, alpha_cut_off |  |
| animated_path.effect | .effect | Other / effect | 8 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, speed_percent, path_map, reverse | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| animated_texture.effect | .effect | Text/clock/overlay | 21 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, notes, Animation_Image, Colorization_Image, reverse, bounce, center_animation ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader; TRANSITION shader - meant for scene transitions, not a source filter |
| ascii.shader | .shader | Text/clock/overlay | 5 | scale, base_color, monochrome, character_set, note |  |
| aspect_ratio.shader | .shader | Frame/border/mask | 8 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, borderColor, notes | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| audio.shader | .shader | Audio-reactive | 3 | audio_peak, audio_magnitude, intensity | audio-reactive: needs an audio source for the filter |
| background_removal.effect | .effect | Composite/blend/key | 13 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, notes, target, color, opacity, invert, Convert_709to601 ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| blend_opacity.shader | .shader | Composite/blend/key | 9 | Vertical, Rotational, Rotation_Offset, Opacity_Start_Percent, Opacity_End_Percent, Spread, Speed, Apply_To_Alpha_Layer, Notes | animated (uses time) |
| blink.shader | .shader | Other / effect | 1 | speed | animated (uses time) |
| bloom.shader | .shader | Light/glow | 4 | Angle_Steps, Radius_Steps, ampFactor, notes |  |
| border.shader | .shader | Frame/border/mask | 1 | borderColor |  |
| box-blur.shader | .shader | Blur/sharpen/detail | 5 | Strength, Mask_Left, Mask_Right, Mask_Top, Mask_Bottom |  |
| bt601tobt709.shader | .shader | Other / effect | 0 |  |  |
| bt709tobt601.shader | .shader | Other / effect | 0 |  |  |
| BulgePinch.shader | .shader | Distortion/3D | 6 | radius, magnitude, center_x, center_y, animate, notes | animated (uses time) |
| burn.shader | .shader | Light/glow | 11 | Burn_Gradient, Speed, Gradient_Adjust, Dissolve_Value, Animated, Apply_to_Channel, Apply_Smoke, Smoke_Horizonal_Speed, Smoke_Vertical_Speed, Iterations, Notes | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| cartoon.effect | .effect | Other / effect | 10 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, notes, hue_steps, value_steps, Apply_To_Alpha_Layer | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| cell_shaded.shader | .shader | Other / effect | 4 | Angle_Steps, Radius_Steps, ampFactor, notes |  |
| Chroma+UV-Distortion.shader | .shader | Colour/grade | 3 | distortion, amplitude, chroma | animated (uses time) |
| chromatic-aberration.shader | .shader | Colour/grade | 8 | power, gamma, num_iter, distort_radial, distort_barrel, offset_spectrum_ycgco, offset_spectrum_yuv, use_random |  |
| circle-mask-filter.shader | .shader | Frame/border/mask | 6 | Radius, Circle_Offset_X, Circle_Offset_Y, Source_Offset_X, Source_Offset_Y, Antialiasing |  |
| circle.shader | .shader | Frame/border/mask | 0 |  |  |
| clock_analog.shader | .shader | Text/clock/overlay | 11 | current_time_ms, current_time_sec, current_time_min, current_time_hour, hour_handle_color, minute_handle_color, second_handle_color, outline_color, top_line_color, background_color, time_offset_hours | animated (uses time) |
| clock_digital_led.shader | .shader | Text/clock/overlay | 10 | current_time_sec, current_time_min, current_time_hour, timeMode, showMatrix, showOff, ampm, ledColor, offsetHours, offsetSeconds | animated (uses time) |
| clock_digital_nixie.shader | .shader | Text/clock/overlay | 12 | current_time_ms, current_time_sec, current_time_min, current_time_hour, timeMode, offsetHours, offsetSeconds, corecolor, halocolor, flarecolor, anodecolor, anodehighlightscolor | animated (uses time) |
| color-depth.shader | .shader | Colour/grade | 2 | colorDepth, pixelSize |  |
| color_grade_filter.shader | .shader | Colour/grade | 5 | notes, lut, lut_amount_percent, lut_scale_percent, lut_offset_percent | needs texture file (in OLD/textures or pick your own) |
| corner-pin.shader | .shader | Frame/border/mask | 12 | Antialias_Edges, Top_Left_X, Top_Left_Y, Top_Right_X, Top_Right_Y, Bottom_Left_X, Bottom_Left_Y, Bottom_Right_X, Bottom_Right_Y, AAstrength, AAdist, debug_psmult |  |
| corner_pin.shader | .shader | Frame/border/mask | 8 | _DRx, _DRy, _DLx, _DLy, _TLx, _TLy, _TRx, _TRy |  |
| crt-curvature.shader | .shader | Distortion/3D | 3 | strength, border, feathering |  |
| cube_rotating.shader | .shader | Distortion/3D | 6 | images, speed, shadow, other_image1, other_image2, other_image3 | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| curve.shader | .shader | Colour/grade | 3 | strength, scale, curve_color |  |
| cut_rect_per_corner.shader | .shader | Frame/border/mask | 9 | corner_tl, corner_tr, corner_br, corner_bl, border_thickness, border_color, border_alpha_start, border_alpha_end, alpha_cut_off |  |
| cylinder.shader | .shader | Other / effect | 2 | cylinder_factor, background_cut |  |
| darken.shader | .shader | Other / effect | 3 | Opacity_Percentage, Fill_Percentage, Notes |  |
| dead-pixel-fixer.shader | .shader | Distortion/3D | 2 | Dead_Pixel_X, Dead_Pixel_Y |  |
| density_sat_hue.shader | .shader | Colour/grade | 21 | notes, density_r, saturation_r, hueShift_r, density_y, saturation_y, hueShift_y, density_g, saturation_g, hueShift_g, density_c, saturation_c ... |  |
| diffuse_transition.shader | .shader | Transition (not a filter) | 5 | image_a, image_b, transition_time, convert_linear, num_samples | needs texture file (in OLD/textures or pick your own); animated (uses time); TRANSITION shader - meant for scene transitions, not a source filter |
| digital-rain.shader | .shader | Other / effect | 6 | font, noise, base_color, rain_speed, char_speed, glow_contrast | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| displacement_map.shader | .shader | Other / effect | 4 | displacement_info, displacement_x, displacement_y, mask_layer | needs texture file (in OLD/textures or pick your own) |
| displacement_map_advanced.shader | .shader | Other / effect | 20 | displacement_info, displacement_x, displacement_y, displacement_curve, blur_info, blur_size, blur_quality, blur_directions, blur_angle, chromatic_aberration_info, chromatic_aberration, colorize_info ... | needs texture file (in OLD/textures or pick your own) |
| displacement_map_advanced_invert.shader | .shader | Colour/grade | 20 | displacement_info, displacement_x, displacement_y, displacement_curve, blur_info, blur_size, blur_quality, blur_directions, blur_angle, chromatic_aberration_info, chromatic_aberration, colorize_info ... | needs texture file (in OLD/textures or pick your own) |
| displacement_map_invert.shader | .shader | Colour/grade | 4 | displacement_info, displacement_x, displacement_y, background_layer | needs texture file (in OLD/textures or pick your own) |
| divide_rotate.shader | .shader | Other / effect | 5 | iChannel0, speed_percentage, alpha_percentage, Apply_To_Alpha_Layer, notes | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| doodle.effect | .effect | Other / effect | 9 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, Doodle_Scale_Percent, Snap_Percent, Notes | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| drawings.shader | .shader | Other / effect | 2 | AngleNum, SampNum |  |
| drop_shadow.shader | .shader | Light/glow | 6 | shadow_offset_x, shadow_offset_y, shadow_blur_size, notes, shadow_color, is_alpha_premultiplied |  |
| drunk.shader | .shader | Other / effect | 10 | glow_percent, blur, min_brightness, max_brightness, pulse_speed_percent, Apply_To_Alpha_Layer, glow_color, ease, glitch, notes | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| dynamic-mask.shader | .shader | Frame/border/mask | 25 | input_source, red_base_value, red_red_input_value, red_green_input_value, red_blue_input_value, red_alpha_input_value, red_multiplier, green_base_value, green_red_input_value, green_green_input_value, green_blue_input_value, green_alpha_input_value ... | needs texture file (in OLD/textures or pick your own) |
| edge_aware_sharpen.shader | .shader | Blur/sharpen/detail | 7 | amount, threshold, radius, shadow_protect, max_boost, test_grayscale, show_boost |  |
| edge_detection.shader | .shader | Blur/sharpen/detail | 11 | sensitivity, invert_edge, edge_color, edge_multiply, non_edge_color, non_edge_multiply, alpha_channel, alpha_level, alpha_invert, rand_f, notes |  |
| embers.effect | .effect | Other / effect | 20 | elapsed_time, uv_offset, uv_scale, uv_size, uv_pixel_interval, rand_f, rand_instance_f, rand_activation_f, loops, local_time, notes, Animation_Speed ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| emboss.shader | .shader | Blur/sharpen/detail | 2 | Use_Color, Apply_To_Alpha_Layer |  |
| emboss_color.shader | .shader | Blur/sharpen/detail | 6 | Angle_Steps, Radius_Steps, ampFactor, Up_Down_Percent, Apply_To_Alpha_Layer, notes |  |
| exeldro-bent-camera.shader | .shader | Other / effect | 10 | left_side_width, left_side_size, left_side_shadow, left_flip_width, left_flip_shadow, right_side_width, right_side_size, right_side_shadow, right_flip_width, right_flip_shadow |  |
| fade-transition.shader | .shader | Transition (not a filter) | 4 | image_a, image_b, transition_time, convert_linear | needs texture file (in OLD/textures or pick your own); animated (uses time); TRANSITION shader - meant for scene transitions, not a source filter |
| fill_color_gradient.shader | .shader | Colour/grade | 5 | Fill, Gradient_Width, Gradient_Offset, Fill_Direction, Fill_Color |  |
| fill_color_linear.shader | .shader | Colour/grade | 3 | Fill, Fill_Direction, Fill_Color |  |
| fill_color_radial_degrees.shader | .shader | Colour/grade | 6 | Fill_Direction, Fill, Start_Angle, Offset_X, Offset_Y, Fill_Color |  |
| fill_color_radial_percentage.shader | .shader | Colour/grade | 6 | Fill_Direction, Fill, Start_Angle, Offset_X, Offset_Y, Fill_Color |  |
| filter_template.effect | .effect | Other / effect | 11 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, uv_size, rand_f, rand_instance_f, rand_activation_f, loops, local_time, notes | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| filter_template.shader | .shader | Other / effect | 11 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, uv_size, rand_f, rand_instance_f, rand_activation_f, loops, local_time, notes | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| fire-3.effect | .effect | Light/glow | 26 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, uv_size, rand_f, rand_instance_f, rand_activation_f, loops, local_time, Movement_Direction_Horizontal, Movement_Direction_Vertical ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| fire.shader | .shader | Light/glow | 12 | Alpha_Percentage, Speed, Flame_Size, Fire_Type, Invert, lumaMin, lumaMinSmooth, Apply_To_Image, Replace_Image_Color, Apply_To_Specific_Color, Color_To_Replace, Notes | animated (uses time) |
| fireworks.shader | .shader | Light/glow | 3 | show_flash, show_stars, use_transparancy | animated (uses time) |
| fireworks2.shader | .shader | Light/glow | 1 | Speed | animated (uses time) |
| fisheye-xy.shader | .shader | Distortion/3D | 4 | center_x_percent, center_y_percent, power_x, power_y |  |
| fisheye.shader | .shader | Distortion/3D | 3 | center_x_percent, center_y_percent, power |  |
| flip.shader | .shader | Other / effect | 2 | horizontal, vertical |  |
| frosted_glass.shader | .shader | Other / effect | 8 | Alpha_Percent, Amount, Scale, Animate, Horizontal_Border, Border_Offset, Border_Color, notes |  |
| gamma_correction.shader | .shader | Frame/border/mask | 4 | Red, Green, Blue, notes |  |
| gaussian-blur-advanced.shader | .shader | Blur/sharpen/detail | 7 | Directions, Quality, Size, Mask_Left, Mask_Right, Mask_Top, Mask_Bottom |  |
| gaussian-blur-simple.shader | .shader | Blur/sharpen/detail | 5 | Strength, Mask_Left, Mask_Right, Mask_Top, Mask_Bottom |  |
| gaussian-blur.effect | .effect | Blur/sharpen/detail | 13 | imageSize, imageTexel, u_radius, u_diameter, u_texelDelta, elapsed_time, uv_offset, uv_scale, uv_pixel_interval, registerkernel, kernel, kernelTexel ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| gaussian-example.effect | .effect | Blur/sharpen/detail | 11 | elapsed_time, uv_offset, uv_scale, uv_size, uv_pixel_interval, initial_image, before_image, after_image, text_color, max_distance, exp | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| gaussian-simple.shader | .shader | Blur/sharpen/detail | 12 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, uv_size, rand_f, rand_instance_f, rand_activation_f, loops, local_time, samples, LOD | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| gb-camera.shader | .shader | Other / effect | 10 | pixelSize, dither_factor, alternative_bayer, brightness, contrast, gamma, color_1, color_2, color_3, color_4 |  |
| glass.shader | .shader | Other / effect | 10 | Alpha_Percent, Offset_Amount, xSize, ySize, Reflection_Offset, Horizontal_Border, Border_Offset, Border_Color, Glass_Color, notes |  |
| glitch-periodic.shader | .shader | Distortion/3D | 4 | PERI, DURA, AMPL, SCRA | animated (uses time) |
| glitch.shader | .shader | Distortion/3D | 2 | AMT, SPEED | animated (uses time) |
| glitch_analog.effect | .effect | Distortion/3D | 21 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, scan_line_jitter_displacement, scan_line_jitter_threshold_percent, vertical_jump_amount, vertical_speed, horizontal_shake, color_drift_amount ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| glitch_analog.shader | .shader | Distortion/3D | 15 | scan_line_jitter_displacement, scan_line_jitter_threshold_percent, vertical_jump_amount, vertical_speed, horizontal_shake, color_drift_amount, color_drift_speed, pulse_speed_percent, alpha_percent, rotate_colors, Apply_To_Alpha_Layer, Replace_Image_Color ... | animated (uses time) |
| glow.shader | .shader | Light/glow | 7 | glow_percent, blur, min_brightness, max_brightness, pulse_speed, ease, notes | animated (uses time) |
| gradient.shader | .shader | Other / effect | 18 | start_color, start_step, middle_color, middle_step, end_color, end_step, alpha_percent, pulse_speed, ease, rotate_colors, Apply_To_Alpha_Layer, Apply_To_Specific_Color ... | animated (uses time) |
| halftone.shader | .shader | Other / effect | 1 | threshold |  |
| hard_blink.shader | .shader | Other / effect | 2 | timeon, timeoff | animated (uses time) |
| heat-wave-simple.shader | .shader | Distortion/3D | 4 | Rate, Strength, Distortion, Opacity | animated (uses time) |
| hexagon.shader | .shader | Other / effect | 14 | Hex_Color, Alpha_Percent, Quantity, Border_Width, Blend, Equilateral, Zoom_Animate, Speed_Percent, Glitch, Distort_X, Distort_Y, Offset_X ... | animated (uses time) |
| hsl_hsv_saturation.shader | .shader | Colour/grade | 5 | hslSaturationFactor, hslGamma, hsvSaturationFactor, hsvGamma, adjustmentOrder |  |
| hue-rotaton.shader | .shader | Colour/grade | 2 | Speed, Hue_Override | animated (uses time) |
| intensity-scope.shader | .shader | Other / effect | 2 | gain, blend |  |
| invert-luma.shader | .shader | Colour/grade | 4 | Invert_Color, Invert_Luma, Gamma_Correction, Test_Ramp |  |
| Invert.shader | .shader | Colour/grade | 0 |  |  |
| Luminance.shader | .shader | Colour/grade | 5 | color, level, invertImageColor, invertAlphaChannel, notes |  |
| luminance2.shader | .shader | Colour/grade | 8 | color, lumaMax, lumaMin, lumaMaxSmooth, lumaMinSmooth, invertImageColor, invertAlphaChannel, notes |  |
| luminance_alpha.effect | .effect | Colour/grade | 11 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, color, mul_val, add_val, level, invertAlphaChannel | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| lyrics_karaoke.shader | .shader | Other / effect | 16 | text_color, highlight_color, outline_color, threshold_key, softness, despeckle, history_opacity, highlight_split, bold_px, outline_px, outer_color, outer_px ... |  |
| matrix.effect | .effect | Other / effect | 17 | elapsed_time, uv_offset, uv_scale, uv_size, uv_pixel_interval, rand_f, rand_instance_f, rand_activation_f, loops, local_time, mouse, Invert_Direction ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| motion_blur.shader | .shader | Blur/sharpen/detail | 2 | previous_output, strength | needs texture file (in OLD/textures or pick your own) |
| multiply.shader | .shader | Composite/blend/key | 1 | other_image | needs texture file (in OLD/textures or pick your own) |
| night_sky.shader | .shader | Colour/grade | 18 | speed, Include_Clouds, Include_Moon, center_width_percentage, center_height_percentage, Alpha_Percentage, Apply_To_Image, Replace_Image_Color, number_stars, SKY_COLOR, STAR_COLOR, LIGHT_SKY ... | animated (uses time) |
| noise.shader | .shader | Other / effect | 5 | speed, scale, noiseLevel, monochromatic, use_rand | animated (uses time) |
| normal_map.shader | .shader | Other / effect | 6 | strength, offsetHeight, invertR, invertG, invertH, type |  |
| obs.shader | .shader | Other / effect | 0 |  |  |
| opacity.shader | .shader | Composite/blend/key | 1 | Opacity |  |
| page-peel-transition.shader | .shader | Transition (not a filter) | 6 | image_a, image_b, transition_time, convert_linear, page_color, page_transparency | needs texture file (in OLD/textures or pick your own); animated (uses time); TRANSITION shader - meant for scene transitions, not a source filter |
| page-peel.shader | .shader | Other / effect | 2 | Speed, Position | animated (uses time) |
| perlin_noise.shader | .shader | Other / effect | 11 | speed, animated, apply_to_channel, inverted, multiply, speed_horizonal, speed_vertical, iterations, white_noise, black_noise, notes | animated (uses time) |
| perspective.shader | .shader | Distortion/3D | 6 | angle_x, angle_y, angle_z, perspective, border_color, show_border |  |
| pie-chart.shader | .shader | Other / effect | 24 | inner_radius, outer_radius, start_angle, total, part_1, color_1, part_2, color_2, part_3, color_3, part_4, color_4 ... |  |
| pixelation-transition.shader | .shader | Transition (not a filter) | 5 | transition_time, convert_linear, power, center_x, center_y | animated (uses time); TRANSITION shader - meant for scene transitions, not a source filter |
| pixelation.effect | .effect | Distortion/3D | 11 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, pixelation, doodle, Doodle_Scale_Percent, Snap_Percent, Notes | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| pixelation.shader | .shader | Distortion/3D | 3 | Target_Width, Target_Height, notes |  |
| polar.shader | .shader | Other / effect | 7 | center_x, center_y, point_y, flip, rotate, repeat, scale |  |
| pulse.effect | .effect | Other / effect | 9 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, speed, min_growth_pixels, max_growth_pixels | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| quadrilateral_crop.shader | .shader | Frame/border/mask | 8 | Top_Left_X, Top_Left_Y, Top_Right_X, Top_Right_Y, Bottom_Left_X, Bottom_Left_Y, Bottom_Right_X, Bottom_Right_Y |  |
| rain-window.shader | .shader | Other / effect | 6 | size, blurSize, trail_strength, trail_color, speed, debug | animated (uses time) |
| rainbow.shader | .shader | Other / effect | 13 | Saturation, Luminosity, Spread, Speed, Alpha_Percentage, Vertical, Rotational, Rotation_Offset, Apply_To_Image, Replace_Image_Color, Apply_To_Specific_Color, Color_To_Replace ... | animated (uses time) |
| rectangular_drop_shadow.shader | .shader | Frame/border/mask | 4 | shadow_offset_x, shadow_offset_y, shadow_blur_size, shadow_color |  |
| remove_partial_pixels.shader | .shader | Distortion/3D | 2 | minimum_alpha_percent, notes |  |
| repeat.effect | .effect | Distortion/3D | 11 | color_range_min, color_range_max, elapsed_time, uv_offset, uv_scale, uv_pixel_interval, uv_size, rand_f, alpha, copies, notes | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| repeat_grid_center_crop.effect | .effect | Frame/border/mask | 3 | alpha, columns, rows | needs texture file (in OLD/textures or pick your own); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| repeat_texture.effect | .effect | Text/clock/overlay | 13 | color_range_min, color_range_max, tex_image, elapsed_time, uv_offset, uv_scale, uv_pixel_interval, uv_size, rand_f, blend, copies, notes ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| rgb_color_wheel.shader | .shader | Colour/grade | 9 | speed, color_depth, Apply_To_Image, Replace_Image_Color, Apply_To_Specific_Color, Color_To_Replace, Alpha_Percentage, center_width_percentage, center_height_percentage | animated (uses time) |
| rgb_split.shader | .shader | Colour/grade | 6 | redx, redy, greenx, greeny, bluex, bluey |  |
| rgbvisibility.shader | .shader | Colour/grade | 7 | Red, Green, Blue, RedVisibility, GreenVisibility, BlueVisibility, notes |  |
| RGSSAA.shader | .shader | Blur/sharpen/detail | 3 | ColorSigma, SpatialSigma, notes |  |
| ripple.shader | .shader | Other / effect | 5 | distance_factor, time_factor, power_factor, center_pos_x, center_pos_y | animated (uses time) |
| rotating-source.shader | .shader | Other / effect | 6 | spin_speed, rotation, zoomin, keep_aspectratio, x_center, y_center | animated (uses time) |
| rotatoe.effect | .effect | Other / effect | 17 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, speed_percent, Axis_X, Axis_Y, Axis_Z, Angle_Degrees, Rotate_Transform ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| rounded_rect.shader | .shader | Frame/border/mask | 3 | corner_radius, border_thickness, border_color |  |
| rounded_rect2.shader | .shader | Frame/border/mask | 7 | corner_radius, border_thickness, border_color, border_alpha_start, border_alpha_end, alpha_cut_off, faster_scan |  |
| rounded_rect_per_corner.shader | .shader | Frame/border/mask | 9 | corner_radius_tl, corner_radius_tr, corner_radius_br, corner_radius_bl, border_thickness, border_color, border_alpha_start, border_alpha_end, alpha_cut_off |  |
| rounded_rect_per_side.shader | .shader | Frame/border/mask | 9 | corner_radius_bottom, corner_radius_left, corner_radius_top, corner_radius_right, border_thickness, border_color, border_alpha_start, border_alpha_end, alpha_cut_off |  |
| rounded_stroke.shader | .shader | Frame/border/mask | 5 | corner_radius, border_thickness, minimum_alpha_percent, border_color, notes |  |
| rounded_stroke_gradient.shader | .shader | Frame/border/mask | 10 | corner_radius, border_thickness, minimum_alpha_percent, rotation_speed, border_colorL, border_colorR, color_spread, center_width, center_height, notes | animated (uses time) |
| scan_line.shader | .shader | Other / effect | 9 | lengthwise, animate, speed, angle, shift, boost, floor, period, notes | animated (uses time) |
| seascape.shader | .shader | Other / effect | 9 | AA, SEA_HEIGHT, SEA_CHOPPY, SEA_SPEED, SEA_FREQ, SEA_BASE, SEA_WATER_COLOR, CAMERA_SPEED, CAMERA_TURN_SPEED | animated (uses time) |
| seasick.shader | .shader | Other / effect | 5 | notes, amplitude, speed, frequency, opacity | animated (uses time) |
| selective_color.shader | .shader | Colour/grade | 11 | cutoff_Red, cutoff_Green, cutoff_Blue, cutoff_Yellow, acceptance_Amplifier, show_Red, show_Green, show_Blue, show_Yellow, notes, background_type |  |
| shake.effect | .effect | Distortion/3D | 14 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, local_time, random_scale, worble, speed, min_growth_pixels, max_growth_pixels ... | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| shine.shader | .shader | Light/glow | 14 | l_tex, shine_color, speed_percent, gradient_percent, delay_percent, Apply_To_Alpha_Layer, ease, hide, reverse, One_Direction, glitch, notes ... | needs texture file (in OLD/textures or pick your own); animated (uses time) |
| simple_gradient.shader | .shader | Other / effect | 8 | speed_percentage, alpha_percentage, Lens_Flair, Animate_Lens_Flair, Apply_To_Alpha_Layer, Apply_To_Specific_Color, Color_To_Replace, notes | animated (uses time) |
| simplex_noise.shader | .shader | Other / effect | 9 | Snap_Percent, Speed_Percent, Resolution, Fractal, Use_Alpha_Layer, Fore_Color, Back_Color, Alpha_Percent, Notes | animated (uses time) |
| smart_denoise.shader | .shader | Blur/sharpen/detail | 3 | uSigma, uKSigma, uThreshold | needs texture file (in OLD/textures or pick your own) |
| specular-shine.shader | .shader | Light/glow | 9 | Hint, roughness, lightStrength, LightPositionX, LightPositionY, flattenNormal, stretchNormalX, stretchNormalY, Light_Color |  |
| spotlight.shader | .shader | Light/glow | 7 | Speed_Percent, Focus_Percent, Glitch, Spotlight_Color, Horizontal_Offset, Vertical_Offset, Notes | animated (uses time) |
| Swirl.shader | .shader | Distortion/3D | 7 | radius, angle, center_x, center_y, animate, inverse, notes | animated (uses time) |
| tetra.shader | .shader | Other / effect | 18 | redR, redG, redB, yelR, yelG, yelB, grnR, grnG, grnB, cynR, cynG, cynB ... |  |
| thermal.shader | .shader | Colour/grade | 1 | strength |  |
| tv-crt-subpixel.shader | .shader | Distortion/3D | 4 | channelWidth, channelHeight, hGap, vGap |  |
| twist.shader | .shader | Distortion/3D | 4 | center_x_percent, center_y_percent, power, rotation |  |
| two-pass-drop-shadow.effect | .effect | Light/glow | 11 | elapsed_time, uv_offset, uv_scale, uv_pixel_interval, rand_f, uv_size, shadow_offset_x, shadow_offset_y, shadow_blur_size, shadow_color, is_alpha_premultiplied | needs texture file (in OLD/textures or pick your own); animated (uses time); USE EFFECT FILE (.effect) option in ShaderFilter, not the plain shader loader |
| VCR.shader | .shader | Distortion/3D | 6 | vertical_shift, distort, vignet, stripe, vertical_factor, vertical_height | animated (uses time) |
| VHS.shader | .shader | Distortion/3D | 10 | range, offsetIntensity, noiseQuality, noiseIntensity, colorOffsetIntensity, Alpha_Percentage, Apply_To_Image, Replace_Image_Color, Color_To_Replace, Apply_To_Specific_Color | animated (uses time) |
| vignetting.shader | .shader | Other / effect | 4 | innerRadius, outerRadius, opacity, notes |  |
| voronoi-pixelation.shader | .shader | Distortion/3D | 2 | pixH, alternative | animated (uses time) |
| walking-dead-pixel-fixer.shader | .shader | Distortion/3D | 10 | Scan_Width, Scan_Height, Scan_Offset_X, Scan_Offset_Y, Show_Border, Contrast_Threshold, Min_Cluster_Size, Max_Cluster_Size, Show_Green, Bypass |  |
| ZigZag.shader | .shader | Distortion/3D | 9 | radius, angle, period, amplitude, center_x, center_y, phase, animate, notes | animated (uses time) |
| zoom.shader | .shader | Other / effect | 3 | center_x_percent, center_y_percent, power |  |
| zoom_blur.shader | .shader | Blur/sharpen/detail | 6 | samples, magnitude, speed_percent, ease, glitch, notes | animated (uses time) |
| zoom_blur_transition.shader | .shader | Transition (not a filter) | 5 | image_a, image_b, transition_time, convert_linear, strength | needs texture file (in OLD/textures or pick your own); animated (uses time); TRANSITION shader - meant for scene transitions, not a source filter |

## Category counts (first pass)
- Other / effect: 51
- Distortion/3D: 25
- Colour/grade: 25
- Frame/border/mask: 20
- Blur/sharpen/detail: 14
- Light/glow: 12
- Transition (not a filter): 6
- Composite/blend/key: 6
- Text/clock/overlay: 6
- Audio-reactive: 1

## Starting shader

`hsl_hsv_saturation.shader` is analysed in depth in `SHADER_NOTES.md` next to this catalog; fine-tuning starts when the user sends their settings + example image for it.
