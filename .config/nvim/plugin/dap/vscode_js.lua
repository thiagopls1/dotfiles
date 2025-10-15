require("dap-vscode-js").setup({
	adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal', 'pwa-extensionHost' }
})

-- for _, language in ipairs({ "typescript", "javascript" }) do
-- 	require("dap").configurations[language] = {
-- 		... -- see below
-- 	}
-- end
