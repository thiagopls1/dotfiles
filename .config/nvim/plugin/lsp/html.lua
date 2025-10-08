local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('html', {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable('html')
