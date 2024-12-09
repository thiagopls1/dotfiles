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
capabilities.textDocument.completion.completionItem.snippetSupport = true

require"lspconfig".csharp_ls.setup{}
require"lspconfig".ts_ls.setup{}
require"lspconfig".angularls.setup{}
require"lspconfig".cssls.setup{
	capabilities = capabilities,
}
require"lspconfig".azure_pipelines_ls.setup{
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

