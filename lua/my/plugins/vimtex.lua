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

return M
