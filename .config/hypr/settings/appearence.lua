local themes = require("settings.themes")

hl.env("XCURSOR_THEME", themes.cursor)
hl.env("XCURSOR_SIZE", "24")

hl.env("HYPRCURSOR_THEME", themes.cursor)
hl.env("HYPRCURSOR_SIZE", "24")

-- hl.env("GTK_THEME", themes.gtk)

hl.env("QT_QPA_PLATFORM", themes.qt.platform)
hl.env("QT_QPA_PLATFORMTHEME", themes.qt.platform_theme)
hl.env("QT_STYLE_OVERRIDE", themes.qt.style_override)

hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", themes.qt.disable_win_deco)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", themes.qt.scale)

hl.env("QS_ICON_THEME", themes.quickshell.icon_theme)

hl.config({
	decoration = {
		rounding = 5,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = themes.colors.shadow,
		},

		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})

hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

local default_speed = 4
hl.animation({ leaf = "windows", enabled = true, speed = default_speed, bezier = "md3_decel", style = "popin 20%" })
hl.animation({ leaf = "border", enabled = true, speed = default_speed, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = default_speed, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = default_speed, bezier = "easeOutExpo" })
-- hl.animation({ leaf = "specialWorkspaces", enabled = true, speed = 1, bezier = "md3_decel", style = "fade" })
