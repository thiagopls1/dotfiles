require "telescope".setup {
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
		}
	}
}

local telescope_builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>p", telescope_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>r", telescope_builtin.lsp_references, { desc = "Telescope peek references" })
