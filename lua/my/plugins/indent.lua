M = {'lukas-reineke/indent-blankline.nvim'}

function M.config()
    --Map blankline
    vim.g.indent_blankline_char_highlight = 'LineNr'
    require("indent_blankline").setup {
        char = '┊',
        buftype_exclude = { 'terminal', 'nofile' },
        filetype_exclude = { 'help', 'packer' },
        show_trailing_blankline_indent = false
    }
end

return M
