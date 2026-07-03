hl.window_rule({
	name = "remove-border-on-fullscreen",
	match = {
		fullscreen = true,
	},
	border_size = 0,
})

hl.window_rule({
	-- Ignore maximize requests from apps. You'll probably like this.
	name = "supress-maximize-events",
	match = {
		class = ".*",
	},
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- dev.noctalia.noctalia-qs
hl.window_rule({
	name = "noctalia-window-rules",
	match = {
		class = "^(dev.noctalia.noctalia-qs)$",
	},
	float = true,
	center = true,
	rounding = 17,
})

hl.window_rule({
	name = "flameshot-rules",
	match = {
		class = "^(flameshot)$",
	},
	fullscreen = false,
	no_anim = true,
	float = true,
})

hl.window_rule({
	name = "firefox-pip",
	match = {
		class = "firefox",
		title = "Picture-in-Picture",
	},
	pin = true,
	float = true,
})

hl.window_rule({
	name = "firefox-bitwarden",
	match = {
		title = "[Bb]itwarden",
	},
	float = true,
})

hl.window_rule({
	name = "steam-apps",
	match = {
		class = "steam",
	},
	workspace = "4 silent",
	float = true,
	rounding = 0,
})

hl.window_rule({
	name = "steam",
	match = {
		class = "steam",
		title = "Steam",
	},
	workspace = "4 silent",
	tile = true,
	rounding = 5,
})

hl.window_rule({
	name = "steam-bp",
	match = {
		class = "steam",
		title = "Big Picture",
	},
	fullscreen = true,
})

hl.window_rule({
	name = "steam-kb",
	match = {
		class = "steam",
		title = "Entrada Steam — Teclado virtual",
	},
	workspace = "unset",
	pin = true,
})

hl.window_rule({
	name = "discord",
	match = {
		class = "discord",
	},
	workspace = "3 silent",
})

hl.window_rule({
	name = "games",
	match = {
		class = "(steam_app_.*)|([Gg]ame)|(launcher.*)",
	},
	rounding = 0,
	border_size = 0,
	fullscreen = true,
})

hl.window_rule({
	name = "gpu-screen-recorder",
	match = {
		title = "gsr ui",
	},
	rounding = 0,
	border_size = 0,
	no_anim = true,
	fullscreen = true,
	pin = true,
	move = { "0", "0" },
})

hl.window_rule({
	name = "gpu-screen-recorder-notify",
	match = {
		title = "gsr notify",
	},
	rounding = 0,
	border_size = 0,
	no_anim = true,
	float = true,
	pin = true,
	no_focus = true,
	move = { "monitor_w-window_w", "monitor_h*0.06" },
})

hl.window_rule({
	name = "kshutdown",
	match = {
		class = "kshutdown",
	},
	float = true,
})

hl.window_rule({
	name = "workspace-magic",
	match = {
		workspace = "name:special:magic",
	},
	float = true,
})

hl.layer_rule({
	name = "noctalia-background",
	match = {
		namespace = "noctalia-background-.*$",
	},
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

hl.layer_rule({
	name = "noctalia-launcher",
	match = {
		namespace = "noctalia-launcher-overlay-.*$",
	},
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
