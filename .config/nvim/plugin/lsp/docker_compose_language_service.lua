local on_attach, _ = require "plugin.lsp"

vim.lsp.config('docker_compose_language_service', {
	on_attach = on_attach,
})

vim.lsp.enable('docker_compose_language_service')
