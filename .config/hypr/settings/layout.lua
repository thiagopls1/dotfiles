local themes = require("settings.themes")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 2,
		resize_on_border = true,
		hover_icon_on_border = true,

		col = {
			active_border = themes.colors.border.active,
			inactive_border = themes.colors.border.inactive,
		},

		allow_tearing = false,
		layout = "scrolling",
	},
	scrolling = {
		focus_fit_method = 1,
		direction = "down",
		column_width = 0.97,
		follow_min_visible = 0.4,
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
	},
})
