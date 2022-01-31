local M = {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    keys = {'<leader>gg'},
}

M.config = function()
    require'neogit'.setup()
    vim.keymap.set('n', '<leader>gg', require'neogit'.open, {silent=true})
end

return M
