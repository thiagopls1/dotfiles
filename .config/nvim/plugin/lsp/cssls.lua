local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('cssls', {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable('cssls')
