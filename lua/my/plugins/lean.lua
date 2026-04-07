return {
	'Julian/lean.nvim',
	requires = {
		'neovim/nvim-lspconfig',
		'nvim-lua/plenary.nvim',
		'hrsh7th/nvim-cmp',
	},
	config = function()
		require'lean'.setup {
			mappings = true
		}
	end,
	ft='lean',
}
