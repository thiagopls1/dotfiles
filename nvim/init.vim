au Filetype * setl ts=2 sts=2 sw=2

call plug#begin()

Plug 'navarasu/onedark.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'davidgranstrom/nvim-markdown-preview'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin-macchiato

lua << EOF
-- Language supports
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
EOF

set number
