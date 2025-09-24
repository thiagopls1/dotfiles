local lspconf = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP Format setup
local lsp_format = require("lsp-format")
lsp_format.setup()

local on_attach = function(client, bufnr)
	lsp_format.on_attach(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil
	client.server_capabilities.documentHighlightProvider = false
end

-- LSP File Operations setup
lspconf.util.default_config = vim.tbl_extend(
	'force',
	lspconf.util.default_config,
	{
		capabilities = vim.tbl_deep_extend(
			"force",
			capabilities,
			require("lsp-file-operations").default_capabilities()
		)
	}
)

require("lsp-file-operations").setup()

-- Languages Support
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

vim.lsp.config('csharp_ls', {
	on_attach = on_attach,
})

vim.lsp.config('ts_ls', {
	on_attach = on_attach,
})

vim.lsp.config('angularls', {
	on_attach = on_attach,
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "bufnr" },
				disable = { "lowercase-global" }
			},
		},
	},
	on_attach = on_attach,
})

vim.lsp.config('cssls', {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config('cssmodules', {
	on_attach = on_attach,
})

vim.lsp.config('html', {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config('docker_compose_language_service', {
	on_attach = on_attach,
})

vim.lsp.config('yamlls', {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
					"/azure-pipeline*.y*l",
					"/*.azure*",
					"Azure-Pipelines/**/*.y*l",
					"Pipelines/*.y*l",
				},
				-- ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-action.json"] = {
				-- 	".github/**/*.y*l",
				-- },
				["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json"] = {
					".github/**/*.y*l",
				}
			},
			format = {
				enable = true
			}
		},
	},
	on_attach = on_attach,
})

vim.lsp.config('ruby_lsp', {
	on_attach = on_attach,
})


vim.lsp.config('jsonls', {
	capabilities = capabilities,
	on_attach = on_attach
})

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

vim.lsp.config('bashls', {
	on_attach = on_attach,
	capabilities = capabilities
})

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

vim.lsp.config('nimls', {
	cmd = { 'nimlangserver', "--lib:/usr/lib/nim" },
	on_attach = on_attach,
	capabilities = capabilities,
})


vim.lsp.enable('pyright')
vim.lsp.enable('csharp_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('angularls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('cssls')
vim.lsp.enable('cssmodules')
vim.lsp.enable('html')
vim.lsp.enable('docker_compose_language_service')
vim.lsp.enable('yamlls')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('jsonls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('bashls')
vim.lsp.enable('ccls')
vim.lsp.enable('nimls')
