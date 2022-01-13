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
    local su = { silent=true, unique=true }
    vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", ":VimtexCompile<cr>", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\v c", "č", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\' c", "ć", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\v s", "š", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\v z", "ž", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\dj ", "đ", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\v C", "Č", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\' C", "Ć", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\v S", "Š", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\v Z", "Ž", su)
    vim.api.nvim_buf_set_keymap(0, "i", "\\Dj ", "Đ", su)
end

return M

