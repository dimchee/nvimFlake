-- Not working cause of new nvim (i think)
local M = {
    'oberblastmeister/neuron.nvim',
    requires = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',
    },
    -- branch='unstable',
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
    vim.keymap.set('n', 'gzg', function()
        require'telescope.builtin'.live_grep{cwd="~/Library/Neuron"}
    end, {silent=true})
end

return M
