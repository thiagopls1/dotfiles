local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('csharp_ls', {
	on_attach = on_attach,
})

vim.lsp.enable('csharp_ls')
