require'my.options'
require'my.mappings'
require'my.deprecated'

vim.tbl_foreach = table.foreach 

vim.cmd[[command! PackerLoad lua require'my.plugins']]
vim.cmd[[
augroup filetypedetect
au BufNewFile,BufRead *.lean	setf lean
augroup END
]]


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
vim.api.nvim_set_keymap("n", "mp", "<cmd>lua Markdownify()<cr>", { silent=true })

-- https://github.com/luafun/luafun
-- https://github.com/lua-stdlib/functional

