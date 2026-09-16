require("nvim-treesitter").install({
	"angular",
	"bash",
	"c",
	"c_sharp",
	"css",
	"html",
	"javascript",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"scss",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"angular",
		"bash",
		"c",
		"cs",
		"css",
		"html",
		"javascript",
		"lua",
		"markdown",
		"python",
		"regex",
		"scss",
		"typescript",
		"typescriptreact",
		"vim",
		"vimdoc",
	},
	callback = function()
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.treesitter.start()
	end,
})
