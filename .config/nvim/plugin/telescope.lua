local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require("neoclip").setup()

telescope.load_extension("emoji")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = require("telescope.themes").get_dropdown({}),
	},
	pickers = {
		find_files = {
			file_ignore_patterns = {
				"^.git$",
				".ccls%-cache",
				".zig%-cache",
				".zig%-out",
				"node_modules",
				"__pycache__",
				".pytest_cache",
				"htmlcov",
				".venv",
				".git/.*",
				"^dist$",
				"^.next$",
				"^bin$",
				"^obj$",
			},
			hidden = true,
			no_ignore = true,
		},
		buffers = {
			mappings = {
				n = {
					["tD"] = actions.delete_buffer,
				},
				i = {
					["<c-D>"] = actions.delete_buffer,
					["<c-s-d>"] = actions.delete_buffer,
				},
			},
		},
	},
})

require("telescope").load_extension("ui-select")

vim.keymap.set("n", "tf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "tr", builtin.lsp_references, { desc = "Telescope peek references" })
vim.keymap.set("n", "tg", builtin.live_grep, { desc = "Search in files" })
vim.keymap.set("n", "tb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "te", "<Cmd>Telescope emoji<CR>", { desc = "Telesope emojis" })
vim.keymap.set("n", "tv", "<Cmd>Telescope neoclip<CR>", { desc = "Telescope clipboard history" })
vim.keymap.set("n", "tn", "<Cmd>Telescope notify<CR>", { desc = "Telescope notifications history" })
vim.keymap.set("n", "ts", "<Cmd>SessionManager load_session<CR>", { desc = "Telescope session selector" })
