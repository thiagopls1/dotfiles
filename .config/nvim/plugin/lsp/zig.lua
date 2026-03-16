local on_attach, capabilities = require("plugin.lsp")

vim.lsp.config("zls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("zls")
