local on_attach, capabilities = require("plugin.lsp")

vim.lsp.config("gopls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("gopls")
