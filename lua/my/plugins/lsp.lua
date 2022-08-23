local M = {
  'neovim/nvim-lspconfig',
  cmd = 'LspStart',
	module = 'lspconfig',
}

M.servers = {
	sumneko_lua,
	elmls,
	rust_analyzer
}

M.config = function()
	local opts = { unique = false, silent = true }
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
	--vim.keymap.set('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
	local on_attach = function(client, buf)
		vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
		local buf_opts = { unique = false, silent = true, buffer = buf }
		--vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, buf_opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
		vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, buf_opts)

		vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buf_opts)

		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
		--vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, buf_opts)
		--vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, buf_opts)
		--vim.keymap.set('n', '<leader>wl', '=vim.lsp.buf.list_workspace_folders()', buf_opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buf_opts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, buf_opts)

	end
	local lspconf = require'lspconfig'
	lspconf.sumneko_lua.setup {
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = {'vim'},
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
		on_attach = on_attach
	}
	lspconf.rust_analyzer.setup { on_attach = on_attach }
	lspconf.elmls.setup { on_attach = on_attach }
end

return M
