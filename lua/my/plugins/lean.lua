local M = {
    'Julian/lean.nvim',
    requires = {{'neovim/nvim-lspconfig'}, {'nvim-lua/plenary.nvim'}},
    ft = 'lean',
}

M.config = function()
    require'lean'.setup{
        abbreviations = { builtin = true },
        -- lsp = { on_attach = on_attach },
        lsp3 = { on_attach = require'my.plugins.lsp'.on_attach },
        mappings = true,
    }
end

return M
