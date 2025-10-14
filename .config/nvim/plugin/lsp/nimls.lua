local on_attach, capabilities = require "plugin.lsp"

vim.lsp.config('nimls', {
	cmd = { 'nimlangserver', "--lib:/usr/lib/nim" },
	on_attach = on_attach,
	capabilities = capabilities,
})

-- vim.lsp.enable('nimls')
