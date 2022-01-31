local M = {
    'hrsh7th/nvim-cmp',
    module = 'cmp',
    cmd = 'CmpLoad',
    opt=true,
}
M.requires = {
    {'neovim/nvim-lspconfig'},
    {'onsails/lspkind-nvim', module='lspkind'},
    -- extensions
    {'hrsh7th/cmp-nvim-lsp', module='cmp_nvim_lsp'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lua'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-emoji'},
    {'kdheepak/cmp-latex-symbols'},
    -- https://github.com/petertriho/cmp-git
}

M.config = function()
    vim.cmd[[command! -nargs=* CmpLoad]] -- empty command needed
    local cmp = require'cmp'
    local lspkind = require'lspkind'
    cmp.setup({
        -- completion = {
        --     autocomplete = false,
        -- },
        mapping = {
            ['<C-]>'] = cmp.mapping.confirm{select = true},
            ['<CR>'] = cmp.config.disable,--cmp.mapping.confirm({ select = true }),
            -- not using
            --['<C-Space>'] = cmp.mapping.complete(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.close(),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            --{ name = 'path' },
            --{ name = 'buffer' },
            { name = 'emoji' },
            { name = 'latex_symbols' },
        	{ name = 'neorg' },
        }),
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end
        },
        experimental = {
            native_menu = false,
            ghost_text = true,
        },
        formatting = {
            format = lspkind.cmp_format {
                with_text = false,
                menu = {
                    buffer = '[buf]',
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[lua]',
                    path = '[path]',
                    luasnip = '[snip]',
                    emoji = '[ :) ]',
                    latex_symbols = '[TeX]',
                    neorg = '[note]',
                },
            }
        },
    })
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    require'cmp_nvim_lsp'.update_capabilities(capabilities)
    capabilities.textDocument.codeLens = { dynamicRegistration = false }
    --capabilities = vim.tbl_deep_extend("keep", capabilities, nvim_status.capabilities)
    --capabilities.textDocument.codeLens = { dynamicRegistration = false }
    for s, _ in pairs(require'my.plugins.lsp'.servers) do
        require'lspconfig'[s].capabilities = capabilities
    end
end

return M
