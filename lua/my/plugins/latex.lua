local M = {
    'lervag/vimtex',
    ft='tex',
}

M.setup = function()
    vim.g.vimtex_compiler_method = 'tectonic'
    vim.g.vimtex_quickfix_enabled = true
    -- vim.g.vimtex_quickfix_method = 'pplatex'
    vim.g.vimtex_quickfix_mode = 2
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_automatic = true
    vim.g.vimtex_compiler_progname = 'nvr'
end

M.config = function()
    local opts = { silent=true, unique=true, buffer=0 }
    vim.keymap.set('n', '<C-a>', '<cmd>VimtexCompile<cr>', opts)
    vim.keymap.set('i', "\\v c", 'č', opts)
    vim.keymap.set('i', "\\' c", 'ć', opts)
    vim.keymap.set('i', "\\v s", 'š', opts)
    vim.keymap.set('i', "\\v z", 'ž', opts)
    vim.keymap.set('i', "\\dj ", 'đ', opts)
    vim.keymap.set('i', "\\v C", 'Č', opts)
    vim.keymap.set('i', "\\' C", 'Ć', opts)
    vim.keymap.set('i', "\\v S", 'Š', opts)
    vim.keymap.set('i', "\\v Z", 'Ž', opts)
    vim.keymap.set('i', "\\Dj ", 'Đ', opts)
end

return M

