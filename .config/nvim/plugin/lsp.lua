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

return on_attach, capabilities
