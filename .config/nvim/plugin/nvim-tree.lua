local nvim_tree_api = require("nvim-tree.api")
local dapui = require("dapui")

require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		float = {
			enable = true,
			open_win_config = {
				border = "rounded",
				relative = "editor",
				row = 0,
				col = 0,
				width = 30,
				height = (vim.opt.lines:get() - vim.opt.cmdheight:get()) - 3,
			},
		},
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
	},
})

-- Bindings
local function opts(desc)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local function toggle_nvim_tree()
	nvim_tree_api.tree.toggle()
	dapui.close()
end

--vim.keymap.set("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "me", toggle_nvim_tree, opts("Open"))
