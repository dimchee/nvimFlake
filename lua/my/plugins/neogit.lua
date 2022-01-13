local M = {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    keys = {'<leader>gg'},
}

M.config = function()
    require'neogit'.setup()
    vim.api.nvim_set_keymap(
        'n', '<leader>gg', '<cmd>lua require"neogit".open()<cr>', {silent=true}
    )
end

return M
