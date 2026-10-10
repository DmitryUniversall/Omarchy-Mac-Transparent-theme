-- Mac Transparent: glassy windows, soft white borders, heavy blur.
-- Ported from https://github.com/notzeman/Omarchy-Mac-Transparent-theme (hyprland.conf)
-- to the Lua config used by Omarchy 4.
--
-- Loaded right after Omarchy's defaults and BEFORE ~/.config/hypr/looknfeel.lua,
-- so anything you set there (gaps, border_size, rounding, animations) still wins.

local active_border_color = { colors = { "rgba(ffffff66)", "rgba(ffffff22)" }, angle = 90 }
local inactive_border_color = "rgba(3a3a3a60)"

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 4,

    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },

    resize_on_border = true,
    extend_border_grab_area = 15,
  },

  group = {
    col = {
      border_active = { colors = { "rgba(ffffff55)", "rgba(ffffff22)" }, angle = 90 },
      border_inactive = "rgba(3a3a3a55)",
      border_locked_active = { colors = { "rgba(ff990088)", "rgba(ff990022)" }, angle = 90 },
      border_locked_inactive = "rgba(3a3a3a77)",
    },

    groupbar = {
      enabled = true,
      font_size = 10,
      gaps_in = 3,
      gaps_out = 3,
    },
  },

  decoration = {
    shadow = {
      enabled = true,
      range = 25,
      render_power = 3,
      color = "rgba(00000055)",
      color_inactive = "rgba(00000044)",
      offset = { 0, 5 },
      scale = 1.0,
    },

    blur = {
      enabled = true,
      size = 4,
      passes = 3,
      contrast = 1.0,
      brightness = 0.9,
      vibrancy = 0.1,
      noise = 0.01,
      ignore_opacity = false,
      new_optimizations = true,
      -- Frost translucent app menus too (Firefox, GTK); popups_ignorealpha
      -- keeps their transparent rounded corners and shadows unblurred.
      popups = true,
      popups_ignorealpha = 0.2,
    },

    active_opacity = 1.0,
    inactive_opacity = 0.95,
    fullscreen_opacity = 1.0,
  },
})

-- Animations ------------------------------------------------------------------

hl.curve("water", { type = "bezier", points = { { 0.22, 0.9 }, { 0.36, 1.0 } } })
hl.curve("flow", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0 } } })
hl.curve("ripple", { type = "bezier", points = { { 0.33, 0.0 }, { 0.2, 1.0 } } })
hl.curve("stream", { type = "bezier", points = { { 0.4, 0.0 }, { 0.4, 1.0 } } })
hl.curve("cascade", { type = "bezier", points = { { 0.19, 1.0 }, { 0.22, 1.0 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3.0, bezier = "water" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.8, bezier = "cascade" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.4, bezier = "stream" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1.6, bezier = "flow" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.4, bezier = "water" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.0, bezier = "cascade" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.8, bezier = "ripple" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 2.0, bezier = "water" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 1.4, bezier = "flow" })
hl.animation({ leaf = "layers", enabled = true, speed = 1.5, bezier = "md3_standard" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 1.5, bezier = "overshot", style = "popin 80%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.3, bezier = "md3_accel", style = "popin 90%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.8, bezier = "flow" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2.5, bezier = "water", style = "slidevert" })
hl.animation({ leaf = "border", enabled = true, speed = 2.9, bezier = "water" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 3.5, bezier = "flow" })

-- Frosted glass behind the Omarchy shell -------------------------------------
-- The old theme blurred waybar, mako, walker and swayosd. In Omarchy 4 those are
-- all Quickshell layers. ignore_alpha keeps fully transparent parts of a layer
-- (and the faint menu scrim) unblurred, so only the visible cards get frosted.

hl.layer_rule({
  match = {
    namespace = "^(omarchy-bar|omarchy-notifications|omarchy-osd|omarchy-menu|omarchy-clipboard|omarchy-emojis|omarchy-polkit|omarchy-reminders|omarchy-keyboard-panel|omarchy-network-qr)$",
  },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.1,
})
