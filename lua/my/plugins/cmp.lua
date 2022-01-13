local M = {
    'hrsh7th/nvim-cmp',
    module = 'cmp',
    cmd = 'CmpLoad',
    opt=true,
}
M.requires = {
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lua'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-emoji'},
    {'kdheepak/cmp-latex-symbols'},
    -- https://github.com/petertriho/cmp-git
}

M.kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

M.config = function()
    vim.cmd[[command! -nargs=* CmpLoad]] -- empty command needed
    local cmp = require'cmp'
    local kind_icons = require'my.plugins.cmp'.kind_icons
    cmp.setup({
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
            --{ name = 'path' },
            --{ name = 'buffer' },
            { name = 'emoji' },
            { name = 'latex_symbols' },
        	{ name = 'neorg' },
        }),
        experimental = {
            native_menu = true,
            ghost_text = false,
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                vim_item.menu = ({
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
    })
    -- local capabilities = require'cmp_nvim_lsp'.update_capabilities(
    --     vim.lsp.protocol.make_client_capabilities()
    -- )
    for _, s in ipairs(require'my.plugins.lsp'.servers) do
        require'lspconfig'[s].capabilities = capabilities
    end
end

return M
