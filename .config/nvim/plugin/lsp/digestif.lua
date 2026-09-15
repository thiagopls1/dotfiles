local on_attach, capabilities = require("plugin.lsp")

vim.lsp.config("digestif", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable("digestif")
