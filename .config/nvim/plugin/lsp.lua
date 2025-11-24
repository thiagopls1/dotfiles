local lspconf = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })

-- LSP Rename
require("inc_rename").setup()
vim.keymap.set("n", "<leader>R", ":IncRename ")
vim.keymap.set("v", "<leader>R", ":IncRename ")

local on_attach = function(client, _)
	client.server_capabilities.semanticTokensProvider = nil
	client.server_capabilities.documentHighlightProvider = false
end

-- LSP File Operations setup
lspconf.util.default_config = vim.tbl_extend("force", lspconf.util.default_config, {
	capabilities = vim.tbl_deep_extend("force", capabilities, require("lsp-file-operations").default_capabilities()),
})

require("lsp-file-operations").setup()

return on_attach, capabilities
