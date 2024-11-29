au Filetype * setl ts=2 sts=2 sw=2

set nowrap
set formatoptions-=t

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
Plug 'TheGLander/indent-rainbowline.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'romgrk/barbar.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'mxsdev/nvim-dap-vscode-js', { 'do': 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out' }

call plug#end()


lua << EOF

-- Theme Config - Catppuccin
require"catppuccin".setup{
        flavour = "macchiato",
        transparent_background = true
}


require"Comment".setup{}
require"rainbow-delimiters.setup".setup{}
require"live-server".setup{}
require"nvim-autopairs".setup{}
--require"ibl".setup(require"indent-rainbowline".make_opts{})

require'lualine'.setup {
        options = { theme = 'ayu_mirage' }
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
EOF

colorscheme catppuccin
set number
