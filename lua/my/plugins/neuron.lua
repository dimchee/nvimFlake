local M = {
    'oberblastmeister/neuron.nvim',
    requires = {'nvim-telescope/telescope.nvim'},
    branch='unstable',
    keys = { "gzi", "gzz", "gzZ", "gzn", "gzb", "gzB", "gzt", "gz[", "gz]", "gzg" },
}


function M.config()
    require'neuron'.setup {
        virtual_titles = true,
        mappings = true,
        run = nil, -- function to run when in neuron dir
        neuron_dir = '~/Library/Neuron',
        leader = 'gz', -- leader key, remember 'go zettel'
    }
    local keymap = vim.api.nvim_set_keymap
    local tele_do = require'my.plugins.telescope'.tele_do
    keymap('n', 'gzg', tele_do'live_grep{cwd="~/Library/Neuron"}', {silent=true})
end

return M
