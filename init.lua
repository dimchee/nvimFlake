-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
-- checkout https://nvim-mini.org/MiniMax/
vim.pack.add {
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-mini/mini.hues',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/dimchee/notes.nvim',
  'https://github.com/NeogitOrg/neogit.git',
  'https://github.com/nvim-mini/mini.completion',
}

require 'notes'.setup { notes_dir = '~/XDG/Notes' }
require 'mini.icons'.setup {}
require 'oil'.setup {}
vim.cmd.colorscheme('miniwinter')

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', {})

vim.lsp.config('lua_ls', {
  on_attach = function(client, _)
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':', '#', '(' }
  end,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      workspace = {
        ignoreSubmodules = true,
        library = { vim.env.VIMRUNTIME },
      },
    },
  }
})
vim.lsp.enable { 'lua_ls', 'pyright', 'ruff', 'superhtml' }


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  once = true,
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set( 'n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)

    vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    require 'mini.completion'.setup {
      lsp_completion = {
        -- Without this config autocompletion is set up through `:h 'completefunc'`.
        -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
        -- (sets up only when needed) and makes it possible to use `<C-u>`.
        source_func = 'omnifunc',
        auto_setup = false,
        process_items = function(items, base)
          local o = { kind_priority = { Text = -1, Snippet = 99 } }
          return require 'mini.completion'.default_process_items(items, base, o)
        end
      },
    }
    vim.lsp.config('*', { capabilities = require 'mini.completion'.get_lsp_capabilities() })
  end,
})

-- Appearance
vim.opt.number = true         -- Print line number
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'    -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.cursorline = true     -- Enable highlighting of the current line
vim.opt.conceallevel = 3      -- Hide * markup for bold and italic
vim.opt.showmode = false      -- Dont show mode since we have a statusline
vim.opt.termguicolors = true  -- True color support
-- Indent
vim.opt.shiftround = true     -- Round indent
vim.opt.autoindent = true
vim.opt.smartindent = true    -- Insert indents automatically-
-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true  -- Don't ignore case with capitals
-- Timeouts
vim.opt.timeoutlen = 300
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
-- Backups and undos
vim.opt.undolevels = 10000
vim.opt.undofile = true     -- enable persistent undo
vim.opt.backup = false      -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false    -- creates a swapfile
-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.errorbells = false
-- Other
vim.g.netrw_browser_viewer = 'firefox' -- Open link with gx
vim.opt.clipboard = 'unnamedplus'      -- Sync with system clipboard
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.inccommand = 'nosplit' -- preview incremental substitute
vim.opt.hidden = true          -- Do not save when switching buffers
vim.opt.spelllang = { 'en' }

-- Diagnostic keymaps
-- local diagnostic_goto = function(count, severity)
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function() vim.diagnostic.jump { count=count, severity = severity, float=true } end
-- end
-- vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']e', diagnostic_goto(1, 'ERROR'), { desc = 'Next Error' })
-- vim.keymap.set('n', '[e', diagnostic_goto(-1, 'ERROR'), { desc = 'Prev Error' })
-- vim.keymap.set('n', ']w', diagnostic_goto(1, 'WARN'), { desc = 'Next Warning' })
-- vim.keymap.set('n', '[w', diagnostic_goto(-1, 'WARN'), { desc = 'Prev Warning' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('t', '<C-w><C-w>', '<C-\\><C-n><C-w>w', { desc = 'Change Window' })

-- Moving lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Default options that are always set: (https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua)
vim.opt.tabstop = 4    -- Number of spaces tabs count for
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'nix', 'html', 'css', 'js', 'ts' },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'tex', 'csv', 'typst', 'html' },
  callback = function()
    local opts = { silent = true, unique = false }
    vim.keymap.set('i', '\\v c', 'č', opts)
    vim.keymap.set('i', "\\' c", 'ć', opts)
    vim.keymap.set('i', '\\v s', 'š', opts)
    vim.keymap.set('i', '\\v z', 'ž', opts)
    vim.keymap.set('i', '\\dj ', 'đ', opts)
    vim.keymap.set('i', '\\v C', 'Č', opts)
    vim.keymap.set('i', "\\' C", 'Ć', opts)
    vim.keymap.set('i', '\\v S', 'Š', opts)
    vim.keymap.set('i', '\\v Z', 'Ž', opts)
    vim.keymap.set('i', '\\Dj ', 'Đ', opts)
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function()
    local opts = { silent = true, unique = false }
    vim.keymap.set('n', 'mp', function()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local ln = vim.api.nvim_get_current_line()
      vim.api.nvim_set_current_line(ln:sub(1, col + 1) ..
        '[](' .. vim.fn.getreg '+' .. ')' .. ln:sub(col + 2, #ln + 1))
      vim.api.nvim_win_set_cursor(0, { row, col + 2 })
      vim.cmd 'startinsert'
    end, opts)
  end,
})
