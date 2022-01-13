local M = {
    'akinsho/toggleterm.nvim',
    setup = function() vim.cmd'set hidden' end,
}

M.repls = {haskell='ghci', prolog='swipl', python='python'}--, julia='julia'}
M.opened_repls = {}
function M.config()
    require'toggleterm'.setup{
        setup = 20,
        direction = 'horizontal',
        persist_size = false,
        open_mapping = '<leader><leader>t',
        start_in_insert = true,
        close_on_exit = true,
    }
end

function M.toggle()
    repl = require'my.terminal'.opened_repls[vim.api.nvim_buf_get_option(0, 'filetype')]
    if repl then repl:toggle() end
end

function M.make_buf_repl()
    local ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local term = require'my.terminal'
    if term.repls[ft] then
        term.opened_repls[ft] = require'toggleterm.terminal'.Terminal:new({
            cmd = term.repls[ft],
            setup = 20,
            direction = 'horizontal',
            start_in_insert = true,
            close_on_exit = true,
        })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":lua require'my.terminal'.toggle()<cr>", { silent=true })
    end
end
-- vim.cmd[[autocmd FileType * :lua require'my.terminal'.make_buf_repl()]]

return M
