require "dapui".setup {}

local nvim_tree_api = require "nvim-tree.api"
local nvim_tree_was_visible = nil

-- Languages Support
require "dap-python".setup("python")
require "dap-cpp".setup()

require "dap-vscode-js".setup({
	adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal', 'pwa-extensionHost' }
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		... -- see below
	}
end

-- DAP & DAPUI Config
local dap, dapui = require "dap", require "dapui"

-- Open automatically when a new debug session is created
dap.listeners.after.event_initialized["dapui_config"] = function()
	nvim_tree_was_visible = nvim_tree_api.tree.is_visible()
	dapui.open()
	if nvim_tree_was_visible then
		nvim_tree_api.tree.close()
	end
end

-- On debug finish
dap.listeners.before.event_terminated["dapui_config"] = function()
	-- dapui.close()
end

-- On debug exit
dap.listeners.before.event_exited["dapui_config"] = function()
	-- dapui.close()
	-- if nvim_tree_was_visible then
	-- 	nvim_tree_api.tree.open()
	-- end
end

-- DAP Colors
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#202230' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#202230' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#202230' })

-- DAP Signs
vim.fn.sign_define("DapBreakpoint", {
	text = 'o',
	texthl = 'DapBreakpoint',
	linehl = 'DapBreakpoint',
	numhl =
	'DapBreakpoint'
})
vim.fn.sign_define("DapStopped", { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

-- DAP Keybindings
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue/Start DAP session" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
-- SHIFT + F11
vim.keymap.set("n", "<F23>", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<F8>", dap.terminate, { desc = "Terminate" })
-- SHIFT + F8
vim.keymap.set("n", "<F20>", dap.disconnect, { desc = "Disconnect" })
vim.keymap.set("n", "<leader>b", dapui.toggle, { desc = "Toggle Dap UI" })
