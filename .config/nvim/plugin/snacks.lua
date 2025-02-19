local Snacks = require "snacks"

Snacks.setup {
	explorer = { enabled = true },
	picker = {
		enabled = true,
		win = {
			input = {
				keys = {
					["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
				},
			},
			list = { keys = { ["dd"] = "bufdelete" } },
		}
	},
	image = {
		formats = {
			"png",
			"jpg",
			"jpeg",
			"gif",
			"bmp",
			"webp",
			"tiff",
			"heic",
			"avif",
			"mp4",
			"mov",
			"avi",
			"mkv",
			"webm",
			"pdf",
			"ico"
		},
		force = false, -- try displaying the image, even if the terminal does not support it
		doc = {
			-- enable image viewer for documents
			-- a treesitter parser must be available for the enabled languages.
			-- supported language injections: markdown, html
			enabled = true,
			-- render the image inline in the buffer
			-- if your env doesn't support unicode placeholders, this will be disabled
			-- takes precedence over `opts.float` on supported terminals
			inline = true,
			-- render the image in a floating window
			-- only used if `opts.inline` is disabled
			float = true,
			max_width = 80,
			max_height = 40,
		},
		img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
		-- window options applied to windows displaying image buffers
		-- an image buffer is a buffer with `filetype=image`
		wo = {
			wrap = false,
			number = false,
			relativenumber = false,
			cursorcolumn = false,
			signcolumn = "no",
			foldcolumn = "0",
			list = false,
			spell = false,
			statuscolumn = "",
		},
		cache = vim.fn.stdpath("cache") .. "/snacks/image",
		debug = {
			request = false,
			convert = false,
			placement = false,
		},
		env = {},
	}
}
