require "nvim-tree".setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
	}
})

-- Bindings
local function opts(desc)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local nvim_tree_api = require "nvim-tree.api"
--vim.keymap.set("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>e", nvim_tree_api.tree.toggle, opts("Open"))
