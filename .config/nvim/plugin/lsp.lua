local lspconf = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP Format setup
local lsp_format = require "lsp-format"
lsp_format.setup {}

-- LSP File Operations setup
lspconf.util.default_config = vim.tbl_extend(
	'force',
	lspconf.util.default_config,
	{
		capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities {},
			require "lsp-file-operations".default_capabilities {}
		)
	}
)
require "lsp-file-operations".setup {}

-- Languages Support
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
				globals = { "vim", "bufnr" }
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

lspconf.docker_compose_language_service.setup {
	on_attach = lsp_format.on_attach,
}

lspconf.yamlls.setup {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
					"/azure-pipeline*.y*l",
					"/*.azure*",
					"Azure-Pipelines/**/*.y*l",
					"Pipelines/*.y*l",
				},
				["https://json.schemastore.org/github-action.json"] = {
					".github/**/*.y*l",
				},
				["https://json.schemastore.org/github-workflows.json"] = {
					".github/**/*.y*l",
				}
			},
			format = {
				enable = true
			}
		},
	},
	on_attach = lsp_format.on_attach,
}

-- Prettier setup
vim.g['prettier#exec_cmd_async'] = 1
vim.g['prettier#autoformat'] = 1
vim.cmd "au BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css Prettier"
