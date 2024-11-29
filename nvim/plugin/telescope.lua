require"telescope".setup{
	pickers = {
		find_files = {
			theme = "dropdown"
		}
	}
}

local telescope_builtin = require"telescope.builtin"
vim.keymap.set("n", "<leader>p", telescope_builtin.find_files, { desc = "Telescope find files" })

