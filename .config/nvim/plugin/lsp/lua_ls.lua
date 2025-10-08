local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "bufnr" },
				disable = { "lowercase-global" }
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})


vim.lsp.enable('lua_ls')
