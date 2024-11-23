au Filetype * setl ts=2 sts=2 sw=2

call plug#begin()

Plug 'numToStr/Comment.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes npm install' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'barrett-ruth/live-server.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'TheGLander/indent-rainbowline.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'romgrk/barbar.nvim'

call plug#end()


lua << EOF
-- Language supports

-- opts - nvim
local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

require"catppuccin".setup{
        flavour = "macchiato",
        transparent_background = true
}

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
require"lspconfig".csharp_ls.setup{}
require"lspconfig".ts_ls.setup{}
require"lspconfig".angularls.setup{}
require"Comment".setup{}
require"rainbow-delimiters.setup".setup{}
require"live-server".setup{}
--require"ibl".setup(require"indent-rainbowline".make_opts{})
require"barbar".setup{
        sidebar_filetypes = {
                NvimTree = true
        },
        animation = false,
}

require"telescope".setup{
	pickers = {
		find_files = {
			theme = "dropdown"
		}
	}
}

local cmp = require'cmp'

-- Completion
cmp.setup{
        snippet = {
                expand = function(args)
                        vim.snippet.expand(args.body)
                end,
        },
  window = {

        },
        mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' }
        }),
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require"nvim-tree".setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})

require'lualine'.setup {
        options = { theme = 'ayu_mirage' }
}



local nvim_tree_api = require"nvim-tree.api"
local telescope_builtin = require"telescope.builtin"

-- KEYBINDINGS

local barbar_opts = { noremap = true, silent = true }
local nvim_map = vim.api.nvim_set_keymap
-- Move to previous/next
nvim_map('n', '<A-Left>', '<Cmd>BufferPrevious<CR>', barbar_opts)
nvim_map('n', '<A-Right>', '<Cmd>BufferNext<CR>', barbar_opts)
-- Re-order to previous/next
nvim_map('n', '<A-PageDown>', '<Cmd>BufferMovePrevious<CR>', barbar_opts)
nvim_map('n', '<A-PageUp>', '<Cmd>BufferMoveNext<CR>', barbar_opts)
-- Close tab
nvim_map('n', '<A-w>', '<Cmd>BufferClose<CR>', barbar_opts)

--nvim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
--vim.keymap.set("n", "l", edit_or_open,          {})
--vim.keymap.set("n", "L", vsplit_preview,        {})
vim.keymap.set("n", "<leader>e", nvim_tree_api.tree.toggle, opts("Open"))
vim.keymap.set("n", "<leader>p", telescope_builtin.find_files, { desc = "Telescope find files" })

EOF

colorscheme catppuccin

set number
