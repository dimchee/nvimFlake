vim.g.mapleader = ','
-- use <C-l>
-- vim.keymap.set('n', '<space><space>', '<cmd>nohls<cr>', {silent = true})
vim.g.filetype_pl="prolog"

vim.cmd[[command! Packer lua package.loaded['my.plugins'] = nil; require'my.plugins']]
vim.cmd[[command! PS lua package.loaded['my.plugins'] = nil; require'my.plugins'; require'packer'.sync()]]
vim.cmd[[command! PC lua package.loaded['my.plugins'] = nil; require'my.plugins'; require'packer'.compile()]]
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
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- https://jdhao.github.io/2022/08/21/you-do-not-need-a-plugin-for-this/
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end
})

require'my.options'
require'my.koka'
