local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('ruby_lsp', {
	on_attach = on_attach,
	capabilities = capabilities
})

vim.lsp.enable('ruby_lsp')
