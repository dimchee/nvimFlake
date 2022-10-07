local M = {
	'jiaoshijie/undotree',
	requires = {'nvim-lua/plenary.nvim'},
	setup = function()
		vim.opt.swapfile = false
		vim.opt.backup = false
		vim.opt.undodir = os.getenv'XDG_STATE_HOME' or (os.getenv'HOME' .. '/.local/state') .. "/vim/undo"
		vim.opt.undofile = true
	end,
	config = function()
		vim.keymap.set(
			'n', '<leader>u', require'undotree'.toggle,
			{ noremap = true, silent = true }
		)
		require'undotree'.setup()
	end
}

return M
