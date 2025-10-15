local telescope = require "telescope"
local builtin = require "telescope.builtin"
local actions = require "telescope.actions"

require("neoclip").setup()

telescope.load_extension("emoji")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case"
		}
	},
	pickers = {
		find_files = {
			file_ignore_patterns = {
				".git",
				"node_modules",
				"__pycache__",
				".pytest_cache",
				"htmlcov",
				".venv",
				".git/.*",
				"dist",
				".next",
				"bin",
				"obj",
			},
			hidden = true,
		},
		buffers = {
			mappings = {
				i = {
					["<c-s-d>"] = actions.delete_buffer,
				}
			}
		}
	}
})

vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>r", builtin.lsp_references, { desc = "Telescope peek references" })
vim.keymap.set("n", "<leader>f", builtin.live_grep, { desc = "Search in files" })
vim.keymap.set("n", "<leader>B", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>.", "<Cmd>Telescope emoji<CR>", { desc = "Telesope emojis" })
vim.keymap.set("n", "<leader>P", "<Cmd>Telescope neoclip<CR>", { desc = "Telesope emojis" })
