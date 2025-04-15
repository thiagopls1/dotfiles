-- local Snacks = require "snacks"

vim.keymap.set('n', '<leader>t', '<Cmd>terminal<CR>', { silent = true, desc = 'Open Terminal' })

-- Pickers
-- vim.keymap.set("n", "<leader>p", Snacks.picker.files, { desc = "File Picker" })
-- vim.keymap.set("n", "<leader>f", Snacks.picker.grep, { desc = "Live grep" })
-- vim.keymap.set("n", "<leader>B", Snacks.picker.buffers, { desc = "Buffers" })
-- vim.keymap.set("n", "<leader>r", Snacks.picker.lsp_references, { desc = "Peek References" })
-- vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })
-- vim.keymap.set("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })
-- vim.keymap.set("n", "<leader>:", Snacks.picker.command_history, { desc = "Command History" })
