local M = {
    'nvim-telescope/telescope.nvim',
    cmd = {'Telescope'},
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    module = 'telescope',
}

--require'mappings'.module_keymaps(M, '<leader>t', {'t', 'f', 'b', '/', 'g', 'c'})
        -- keys = require'tele'.keys,
function M.tele_do(what)
    if type(what) == 'string' then
        return "<cmd>lua require'telescope.builtin'."..what..'<cr>'
    else
        print('error, cant tele_do ' .. vim.inspect(what))
    end
end

function M.setup()
    local tele_do = require'my.plugins.telescope'.tele_do
    local function set_key(key, what)
        vim.api.nvim_set_keymap('n', '<leader>t'..key, what, {silent=true})
    end
    --Add leader shortcuts
    --keymap('n', '<leader>b' , tele_do'buffers()', k_opts)

    set_key('t', tele_do'find_files()')
    set_key('f', tele_do'file_browser()')
    set_key('b', tele_do'buffers()')
    set_key('/' , tele_do'current_buffer_fuzzy_find()')
    set_key('g' , tele_do'live_grep()')
    set_key('c', tele_do'find_files{cwd="~/NixHome/home/vim"}')
    --keymap('n', '<leader>ht', tele_do'help_tags()', k_opts)
    --keymap('n', '<leader>t' , tele_do'tags()', k_opts)
    --keymap('n', '<leader>sg', tele_do'grep_string()', k_opts)
    --keymap('n', '<leader>ct', tele_do'tags{ only_current_buffer = true }', k_opts)
    --keymap('n', '<leader>?' , tele_do'oldfiles()', k_opts)
end

return M
