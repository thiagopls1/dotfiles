local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('ccls', {
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		compilationDatabaseDirectory = "build",
		index = {
			threads = 0,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
		workspace_required = false
	}
})

vim.lsp.enable('ccls')
