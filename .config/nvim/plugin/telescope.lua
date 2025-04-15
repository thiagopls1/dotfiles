local telescope = require "telescope"
local builtin = require "telescope.builtin"
local actions = require "telescope.actions"

telescope.load_extension "emoji"
telescope.setup {
	pickers = {
		find_files = {
			file_ignore_patterns = {
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
}

vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>r", builtin.lsp_references, { desc = "Telescope peek references" })
vim.keymap.set("n", "<leader>f", builtin.live_grep, { desc = "Search in files" })
vim.keymap.set("n", "<leader>B", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>.", "<Cmd>Telescope emoji<CR>", { desc = "Telesope emojis" })
