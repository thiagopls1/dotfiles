hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		scroll_method = "on_button_down",
		scroll_button = 274,

		follow_mouse = 1,

		sensitivity = -0.2,
		accel_profile = "flat",

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.device({
	name = "dualsense-wireless-controller-touchpad",
	enabled = false,
})

hl.device({
	name = "dualsense-wireless-controller-touchpad-1",
	enabled = false,
})

hl.device({
	name = "dualsense-wireless-controller-touchpad-2",
	enabled = false,
})

hl.device({
	name = "dualsense-wireless-controller-touchpad-3",
	enabled = false,
})

hl.device({
	name = "logitech-g502-hero-gaming-mouse",
	scroll_method = "no_scroll",
})

hl.device({
	name = "etps/2-elantech-touchpad",
	natural_scroll = true,
})
