return {
	'hoob3rt/lualine.nvim',
	requires = {'kyazdani42/nvim-web-devicons'},
	after = 'nord.nvim',
	config = function()
		require'lualine'.setup {
			options = { theme = 'nord' }
		}
	end
}
