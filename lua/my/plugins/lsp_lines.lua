return {
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require'lsp_lines'.setup()
		vim.diagnostic.config {
			virtual_text = false,
			virtual_lines = { only_current_line = true }
		}
		require'lsp_lines'.toggle() -- disable them by default
		vim.keymap.set(
			'',
			'<Leader>l',
			require'lsp_lines'.toggle,
			{ desc = 'Toggle lsp_lines' }
		)
  end,
}
