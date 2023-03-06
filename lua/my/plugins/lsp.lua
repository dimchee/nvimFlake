local M = {
  'neovim/nvim-lspconfig',
  requires = {
    'folke/neodev.nvim',
    'MrcJkb/haskell-tools.nvim'
  },
}

M.servers = {
  texlab = true, ltex = { autostart = false },
  lua_ls = true, -- sumneko-lua-language-server
  elmls = true,
  rust_analyzer = true,
  julials = true,
  hls = {
    haskell = {
      plugin = {
        class = {
          codeActionsOn = true,
          codeLensOn = true,
        },
        eval = {
          globalOn = true,
          config = {
            diff = true,
            exceptions = true,
          }
        }
      }
    }
  }
}


M.config = function()
  local opts = { unique = false, silent = true }

  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  --vim.keymap.set('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  -- local ht = require'haskell-tools'
  -- vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
  -- vim.keymap.set('n', '<leader>rf', function()
  -- 	ht.repl.toggle(vim.api.nvim_bug_get_name(0))
  -- end, opts)
  -- vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
  vim.api.nvim_create_augroup('LspAttach_keymaps', {})
  vim.api.nvim_create_autocmd('LspAttach', {
    group = 'LspAttach_keymaps',
    callback = function()
      local buf_opts = { unique = false, silent = true, buffer = true }
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, buf_opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, buf_opts)

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buf_opts)

      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
      -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, buf_opts)
      -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, buf_opts)
      -- vim.keymap.set('n', '<leader>wl', '=vim.lsp.buf.list_workspace_folders()', buf_opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buf_opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, buf_opts)
      vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, buf_opts)
      -- vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, buf_opts)
    end
  })
  vim.api.nvim_create_autocmd({
    'FileType', 'BufEnter', 'CursorHold', 'InsertLeave', 'BufWritePost', 'TextChanged'
  }, {
    pattern = 'haskell',
    group = vim.api.nvim_create_augroup('haskell-tools-code-lens', {}),
    callback = vim.lsp.codelens.refresh,
  })
  local lspconf = require 'lspconfig'
  require 'neodev'.setup {}
  for server, conf in pairs(require 'my.plugins.lsp'.servers) do
    lspconf[server].setup(type(conf) == 'table' and conf or {
      -- on_attach = on_attach
    })
  end
  vim.api.nvim_create_user_command('SpellCheck', 'LspStart ltex', {})
end
-- local sumneko_dir = vim.trim(vim.fn.system'dirname $(dirname $(readlink -f $(which lua-language-server)))')
-- local sumneko_bin_dir = sumneko_dir .. '/share/lua-language-server/bin/'
-- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
-- cmd = { sumneko_bin_dir .. 'lua-language-server', '-E', sumneko_bin_dir .. 'main.lua' },

return M
