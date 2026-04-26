local db = require("dashboard")

db.setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		packages = {
			enable = false,
		},
		shortcut = {
			{
				desc = "󰊳 Update",
				group = "@property",
				action = "PlugUpdate",
				key = "u",
			},
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Sessions",
				group = "Label",
				action = "SessionManager load_session",
				key = "s",
			},
		},
	},
})
