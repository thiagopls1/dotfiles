local on_attach, capabilities = require("plugin.lsp")

vim.lsp.config("textlsp", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		textLSP = {
			analysers = {
				languagetool = {
					enabled = true,
					check_text = {
						on_change = true,
						on_open = true,
						on_save = true,
					},
				},
			},
			documents = {
				language = "auto:pt-BR",
				min_length_language_detect = 256,
			},
		},
	},
})

-- vim.lsp.enable("textlsp")
