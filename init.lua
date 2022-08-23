vim.g.mapleader = ','
vim.keymap.set('n', '<space><space>', '<cmd>nohls<cr>', {silent = true})

vim.cmd[[command! Packer lua package.loaded['my.plugins'] = nil; require'my.plugins']]
vim.cmd[[command! PS lua package.loaded['my.plugins'] = nil; require'my.plugins'; require'packer'.sync()]]
--vim.api.nvim

function Markdownify()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local ln = vim.api.nvim_get_current_line()
    vim.api.nvim_set_current_line(ln:sub(1, col+1)
        .. '[]('..vim.fn.getreg'+' .. ')'
        .. ln:sub(col+2, #ln + 1)
    )
    vim.api.nvim_win_set_cursor(0, {row, col + 2})
    vim.cmd'startinsert'
end
vim.keymap.set('n', 'mp', Markdownify)
