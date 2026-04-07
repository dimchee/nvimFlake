-- maybe try this one https://github.com/marko-cerovac/material.nvim
return {
	'shaunsingh/nord.nvim',
	setup = function()
		vim.o.termguicolors = true
		vim.g.nord_disable_background = true
	end, 
	config = 'require"nord".set()'
}

