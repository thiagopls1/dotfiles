local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('ts_ls', {
	on_attach = on_attach,
	capabilities = capabilities
})

vim.lsp.enable('ts_ls')
