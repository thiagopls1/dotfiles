require"barbar".setup{
        sidebar_filetypes = {
                NvimTree = true
        },
        animation = false,
}

-- KEYBINDINGS
local barbar_opts = { noremap = true, silent = true }
local nvim_map = vim.api.nvim_set_keymap
-- Move to previous/next
nvim_map('n', '<A-Left>', '<Cmd>BufferPrevious<CR>', barbar_opts)
nvim_map('n', '<A-Right>', '<Cmd>BufferNext<CR>', barbar_opts)
-- Re-order to previous/next
nvim_map('n', '<A-PageUp>', '<Cmd>BufferMovePrevious<CR>', barbar_opts)
nvim_map('n', '<A-PageDown>', '<Cmd>BufferMoveNext<CR>', barbar_opts)
-- Close tab
nvim_map('n', '<A-w>', '<Cmd>BufferClose<CR>', barbar_opts)