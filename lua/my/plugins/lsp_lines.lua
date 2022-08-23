return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	setup = function()
		vim.diagnostic.config {
			virtual_text = false,
		}
	end,
  config = function()
    require("lsp_lines").setup()
  end,
}
