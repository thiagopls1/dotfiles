local lspconf = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP Format setup
local lsp_format = require "lsp-format"
lsp_format.setup {}

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
	on_attach = on_attach,
}

lspconf.csharp_ls.setup { on_attach = on_attach, }

lspconf.ts_ls.setup {
	on_attach = on_attach,
}

local nvm_path = string.gsub(os.getenv("nvm which current") or "", "/bin/node", "/lib/node_modules")
local cmd = { "ngserver", "--stdio", "--tsProbeLocations", nvm_path, "--ngProbeLocations", nvm_path }

lspconf.angularls.setup({
	on_attach = on_attach,
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
})

lspconf.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "bufnr" }
			},
		},
	},
	on_attach = on_attach,
}

lspconf.cssls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}

lspconf.cssmodules_ls.setup {
	on_attach = on_attach,
}

lspconf.html.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}

lspconf.docker_compose_language_service.setup {
	on_attach = on_attach,
}

-- lspconf.eslint.setup {
-- 	options = {
-- 		overrideConfigFile = ".eslintrc.json"
-- 	},
-- 	on_attach = on_attach,
-- }

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
}

lspconf.jsonls.setup {
	capabilities = capabilities,
	on_attach = on_attach
}

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

if file_exists(".prettierrc") or file_exists(".prettierignore") then
	-- Prettier setup
	vim.g['prettier#exec_cmd_async'] = 1
	vim.g['prettier#autoformat'] = 1
	vim.g['prettier#config#trailing_comma'] = 'all'
	vim.cmd "au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.html,*.css,*.yaml Prettier"
end
