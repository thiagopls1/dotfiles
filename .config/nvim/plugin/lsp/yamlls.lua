local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('yamlls', {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
					"/azure-pipeline*.y*l",
					"/*.azure*",
					"Azure-Pipelines/**/*.y*l",
					"azure-pipelines/**/*.y*l",
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


vim.lsp.enable('yamlls')
