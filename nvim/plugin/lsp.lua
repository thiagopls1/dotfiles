-- Languages Support
require"lspconfig".pyright.setup{
	settings = {
		pyright = {
			strictParameterNoneValue = false,
			strictSetInference = false,
			strictListInference = false,
			strictDictionaryInference = false,
			typeCheckingMode = 'off',
			analyzeUnannotatedFunctions = false
		}
	}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconf = require"lspconfig"
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconf.csharp_ls.setup{}
lspconf.ts_ls.setup{}
lspconf.angularls.setup{}
lspconf.lua_ls.setup{
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			},
		},
	},
}

lspconf.cssls.setup{
	capabilities = capabilities,
}

lspconf.html.setup{
	capabilities = capabilities,
}

lspconf.azure_pipelines_ls.setup{
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
}

