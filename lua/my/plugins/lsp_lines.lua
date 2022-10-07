return {
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	setup = function()
		vim.diagnostic.config {
			virtual_text = false,
		}
	end,
  config = function()
    require'lsp_lines'.setup()
		vim.diagnostic.config {
			virtual_lines = { only_current_line = true }
		}
		vim.keymap.set(
			'',
			'<Leader>l',
			require'lsp_lines'.toggle,
			{ desc = 'Toggle lsp_lines' }
		)
  end,
}
