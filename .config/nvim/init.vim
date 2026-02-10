au Filetype * setl ts=2 sts=2 sw=2

set nowrap
set formatoptions-=t
set number

call plug#begin()

Plug 'numToStr/Comment.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes npm install' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'stevearc/conform.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-fzf-writer.nvim'
Plug 'xiyaowong/telescope-emoji.nvim'
Plug 'AckslD/nvim-neoclip.lua'

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'TheGLander/indent-rainbowline.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nanozuki/tabby.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'mxsdev/nvim-dap-vscode-js', { 'do': 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out' }
Plug 'goropikari/nvim-dap-cpp', { 'do': 'make setup' }
Plug 'nicholasmata/nvim-dap-cs'

Plug 'akinsho/git-conflict.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'brenoprata10/nvim-highlight-colors'
Plug 'onsails/lspkind.nvim'
Plug 'andweeb/presence.nvim'
Plug 'nvimdev/dashboard-nvim'
Plug 'alvan/vim-closetag'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'antosha417/nvim-lsp-file-operations'
Plug 'nvim-treesitter/nvim-treesitter', { 'tag': 'master', 'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'smjonas/inc-rename.nvim'
Plug 'Civitasv/cmake-tools.nvim'

call plug#end()

lua << EOF
require	"Comment".setup{}
require	"rainbow-delimiters.setup".setup{}

require "catppuccin".setup{
        flavour = "macchiato",
        transparent_background = true
}

require"presence".setup{
	auto_update = true,
	debounce_timeout = 1,
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.api.nvim_create_user_command("Redir", function(ctx)
	local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", {plain = true})
	vim.cmd('new')
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

-- Add nvim config files to package
local home_dir = os.getenv("HOME")
package.path = home_dir .. "/.config/nvim/?.lua;" .. package.path

-- KeyBindings
vim.keymap.set('n', '<leader>t', '<Cmd>terminal<CR>', { silent = true, desc = 'Open Terminal' })
EOF

vnoremap <leader>y "+y
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

colorscheme catppuccin
