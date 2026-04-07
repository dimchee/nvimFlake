local M = {
	'TimUntersberger/neogit',
	requires = 'nvim-lua/plenary.nvim',
	commit = "536ded80c32caf58c50c62ed4670b61d6a462d8e",
	keys = {'<leader>gg'},
}

M.config = function()
	require'neogit'.setup()
	vim.keymap.set('n', '<leader>gg', require'neogit'.open, {silent=true})
end

return M
