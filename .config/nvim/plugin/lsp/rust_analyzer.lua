local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('rust_analyzer', {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "rustup", "run", "stable", "rust-analyzer" },
	settings = {
		['rust_analyzer'] = {
			useLibraryCodeForTypes = true,
			autoSearchPaths = true,
			autoImportCompletions = false,
			reportMissingImports = true,
			followImportForHints = true,

			diagnostics = {
				enable = true
			},
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				command = "cargo clippy",
			},
		},
	},
})

vim.lsp.enable('rust_analyzer')
