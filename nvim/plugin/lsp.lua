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

-- Languages Support
require"lspconfig".csharp_ls.setup{}
require"lspconfig".ts_ls.setup{}
require"lspconfig".angularls.setup{}

-- Code Completion
local cmp = require'cmp'
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
