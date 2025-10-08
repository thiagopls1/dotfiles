local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('jsonls', {
	capabilities = capabilities,
	on_attach = on_attach
})

vim.lsp.enable('jsonls')
