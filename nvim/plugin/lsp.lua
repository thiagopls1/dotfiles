-- LSP Format setup
local lsp_format = require "lsp-format"
lsp_format.setup {}

-- Languages Support
local lspconf = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconf.pyright.setup {
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
	on_attach = lsp_format.on_attach,
}

lspconf.csharp_ls.setup { on_attach = lsp_format.on_attach, }
lspconf.ts_ls.setup { on_attach = lsp_format.on_attach, }
lspconf.angularls.setup { on_attach = lsp_format.on_attach, }
lspconf.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			},
		},
	},
	on_attach = lsp_format.on_attach,
}

lspconf.cssls.setup {
	capabilities = capabilities,
	on_attach = lsp_format.on_attach,
}

lspconf.html.setup {
	capabilities = capabilities,
	on_attach = lsp_format.on_attach,
}

lspconf.azure_pipelines_ls.setup {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
					"/azure-pipeline*.y*l",
					"/*.azure*",
					"Azure-Pipelines/**/*.y*l",
					"Pipelines/*.y*l",
				},
			},
		},
	},
	on_attach = lsp_format.on_attach,
}

-- Prettier setup
vim.g['prettier#exec_cmd_async'] = 1
vim.g['prettier#autoformat'] = 1
vim.cmd "au BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css Prettier"
