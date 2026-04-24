-- require("nvim-treesitter.configs").setup({
-- 	sync_install = true,
-- 	highlight = {
-- 		enable = true,
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- 	indent = { enable = true },
-- 	ensure_installed = {
-- 		"angular",
-- 		"bash",
-- 		"c",
-- 		"c_sharp",
-- 		"css",
-- 		"html",
-- 		"javascript",
-- 		"lua",
-- 		"markdown",
-- 		"markdown_inline",
-- 		"python",
-- 		"regex",
-- 		"scss",
-- 		"tsx",
-- 		"typescript",
-- 		"vim",
-- 		"vimdoc",
-- 	},
-- })

require("tree-sitter-manager").setup({
	-- Default Options
	-- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
	-- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
	auto_install = true, -- if enabled, install missing parsers when editing a new file
	highlight = true, -- treesitter highlighting is enabled by default
	-- languages = {}, -- override or add new parser sources
	-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
	-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
})

require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup()
