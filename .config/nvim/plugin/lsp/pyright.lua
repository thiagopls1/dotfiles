local on_attach, _ = require "plugin.lsp"

vim.lsp.config('pyright', {
	settings = {
		pyright = {
			strictParameterNoneValue = false,
			strictSetInference = false,
			strictListInference = false,
			strictDictionaryInference = false,
			typeCheckingMode = 'off',
			analyzeUnannotatedFunctions = false
		}
	},
	on_attach = on_attach,
})

vim.lsp.enable('pyright')
