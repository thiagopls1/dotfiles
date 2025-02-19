require 'nvim-treesitter.configs'.setup {
	sync_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	ensure_installed = {
		"angular",
		"bash",
		"c",
		"c_sharp",
		"css",
		"html",
		"javascript",
		"latex",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"regex",
		"scss",
		"tsx",
		"typescript",
		"vim",
		"vimdoc"
	},
}

require 'nvim-ts-autotag'.setup {}
