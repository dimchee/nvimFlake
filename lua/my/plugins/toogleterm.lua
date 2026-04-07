local M = {
	'akinsho/toggleterm.nvim',
	setup = function() vim.cmd'set hidden' end,
}

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

return M
