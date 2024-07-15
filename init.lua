-- ToDo
-- - snipet for url pasting from clipboard
-- - nvim keybinding cheatsheet, way to learn bindings (practice one random every day)
-- - in visual o ili O - s pocetka na kraj ili obrnuto
-- - ^M - <C-v><C-m> da se unese (windows ending)
-- - gq - split line to visual lines
-- - learn about omni-completion
-- - :help scroll-cursor
-- Organisation of config
-- - init.lua
-- - lua/my/
--   - langs
--     - julia
--     - haskell
--     - rust
--     - ...
--   -
-- https://jdhao.github.io/2022/08/21/you-do-not-need-a-plugin-for-this/
--
-- Plugins
-- 'nvim-neotest/neotest'
-- 'b0o/SchemaStore.nvim'
-- 'lvimuser/lsp-inlayhints.nvim'
-- 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
-- 'hoob3rt/lualine.nvim'
-- 'rafcamlet/nvim-luapad'
-- 'L3MON4D3/LuaSnip'
-- 'shaunsingh/nord.nvim'
-- '~/Code/Dev/Notes'
-- 'rcarriga/nvim-notify'
-- 'dimchee/prochrome.nvim'
-- 'nvim-telescope/telescope.nvim'
-- 'marcelofern/vale.nvim'
-- 'nvim-treesitter/nvim-treesitter'
-- 'Julian/lean.nvim'
-- 'elihunter173/dirbuf.nvim'
-- 'Saecki/crates.nvim'
-- 'numToStr/Comment.nvim'
-- 'marcelofern/vale.nvim'
-- 'chrisbra/Replay'
-- 'MrcJkb/telescope-manix'
-- 'pwntester/octo.nvim'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup {
  -- Until resolved https://github.com/neovim/neovim/issues/12103
  { 'lambdalisue/suda.vim' },
  { dir = "~/Code/Dev/Notes",
    opts = {
      notes_dir = "~/Library/Neuron"
    }
  },
  -- https://github.com/folke/neoconf.nvim
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      -- you also will likely want nvim-cmp or some completion engine
    },

    -- see details below for full configuration options
    opts = {
      mappings = true,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {
      graph_style = 'unicode',
    },
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Open [G]it interface' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      on_attach = function(bufnr)
        local keymap = function(combo, func, desc) vim.keymap.set('n', combo, func, { buffer = bufnr, desc = desc }) end
        keymap('<leader>gp', require('gitsigns').prev_hunk, '[G]o to [P]revious Hunk')
        keymap('<leader>gn', require('gitsigns').next_hunk, '[G]o to [N]ext Hunk')
        keymap('<leader>ph', require('gitsigns').preview_hunk, '[P]review [H]unk')
      end,
    },
  },
  {
    'lervag/vimtex',
    lazy = false, -- for synctex to work
    config = function()
      vim.g.vimtex_compiler_method = 'tectonic'
      vim.g.vimtex_compiler_tectonic = {
        options = {
          '--synctex',
          '-Z shell-escape',
          '--keep-logs',
        },
      }
      vim.g.vimtex_quickfix_enabled = true
      vim.g.vimtex_quickfix_method = 'pplatex'
      vim.g.vimtex_quickfix_mode = 2
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_view_automatic = true
      vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } }
      vim.keymap.set('n', '<F5>', '<cmd>VimtexCompile<cr>', { silent = true, desc = 'Compile latex file' })
      vim.g.vimtex_syntax_conceal_disable = true
      -- vim.api.nvim_create_autocmd({ 'FileType' }, {
      --   group = vim.api.nvim_create_augroup('lazyvim_vimtex_conceal', { clear = true }),
      --   pattern = { 'bib', 'tex' },
      --   callback = function()
      --     vim.wo.conceallevel = 2
      --   end,
      -- })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    init = function()
      vim.api.nvim_create_user_command('SpellCheck', 'LspStart ltex', {})
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        end,
      })
    end,
    config = function()
      require('lspconfig').lua_ls.setup {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      }
      require 'lspconfig'.ltex.setup { autostart = false }
      require 'lspconfig'.ruff_lsp.setup {}
      require 'lspconfig'.pyright.setup {}
      require 'lspconfig'.julials.setup {}
      require 'lspconfig'.texlab.setup {}
      require 'lspconfig'.gleam.setup {}
      require 'lspconfig'.elmls.setup {}
    end,
  },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('cmp').setup {
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        mapping = require('cmp').mapping.preset.insert {
          ['<C-n>'] = require('cmp').mapping.select_next_item(),
          ['<C-p>'] = require('cmp').mapping.select_prev_item(),
          ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
          ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
          ['<C-Space>'] = require('cmp').mapping.complete {},
          ['<CR>'] = require('cmp').mapping.confirm {
            behavior = require('cmp').ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = require('cmp').mapping(function(fallback)
            if require('cmp').visible() then
              require('cmp').select_next_item()
            elseif require('luasnip').expand_or_locally_jumpable() then
              require('luasnip').expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = require('cmp').mapping(function(fallback)
            if require('cmp').visible() then
              require('cmp').select_prev_item()
            elseif require('luasnip').locally_jumpable(-1) then
              require('luasnip').jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end,
  },
  {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nord').setup {}
      vim.cmd.colorscheme 'nord'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'nord',
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    -- event = "LazyFile",
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    opts = {
      -- symbol = "▏",
      symbol = '│',
      options = { try_as_border = true },
    },
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    keys = {
      -- See `:help telescope.builtin`
      -- { '<leader>?',       '<cmd>Telescope oldfiles     <cr>',                                                      desc = '[?] Find recently opened files' },
      { '<leader><space>', '<cmd>Telescope buffers<cr>',                                                            desc = '[ ] Find existing buffers' },
      { '<leader>gf',      '<cmd>Telescope git_files   <cr>',                                                       desc = 'Search [G]it [F]iles' },
      { '<leader>sf',      '<cmd>Telescope find_files  <cr>',                                                       desc = '[S]earch [F]iles' },
      { '<leader>sh',      '<cmd>Telescope help_tags   <cr>',                                                       desc = '[S]earch [H]elp' },
      { '<leader>sw',      '<cmd>Telescope grep_string <cr>',                                                       desc = '[S]earch current [W]ord' },
      { '<leader>sg',      '<cmd>Telescope live_grep   <cr>',                                                       desc = '[S]earch by [G]rep' },
      { '<leader>sd',      '<cmd>Telescope diagnostics <cr>',                                                       desc = '[S]earch [D]iagnostics' },
      { '<leader>cf',      function() require 'telescope.builtin'.find_files { cwd = "$XDG_CONFIG_HOME/nvim" } end, desc = '[C]onfig [F]iles' },
      { '<leader>cg',      function() require 'telescope.builtin'.live_grep { cwd = "$XDG_CONFIG_HOME/nvim" } end,  desc = '[C]onfig [G]rep' },
      {
        '<leader>/',
        function()
          -- you can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        desc = '[/] fuzzily search in current buffer',
      },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- NOTE: additional parser
      { 'nushell/tree-sitter-nu' },
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'vimdoc', 'elm', 'haskell', 'nix' },
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      setup = 20,
      direction = 'horizontal',
      persist_size = false,
      open_mapping = '<c-/>',
      start_in_insert = true,
      close_on_exit = true,
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  {
    'jiaoshijie/undotree',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undodir = os.getenv 'XDG_STATE_HOME' or (os.getenv 'HOME' .. '/.local/state') .. "/vim/undo"
      vim.opt.undofile = true
    end,
    config = function()
      vim.keymap.set(
        'n', '<leader>u', require 'undotree'.toggle,
        { noremap = true, silent = true }
      )
      require 'undotree'.setup()
    end
  },
  {
    'dimchee/prochrome.nvim',
    build = 'bash install.sh',
    config = function()
      vim.api.nvim_create_user_command('Browse', function(opts)
        require('prochrome').open { url = opts.fargs[1] }
      end, { nargs = 1 })
      vim.api.nvim_create_user_command('Hugo', function()
        require('prochrome').open {
          is_app = true,
          on_start = { 'hugo', 'server', '-D', '--navigateToChanged' },
          url = 'http://localhost:1313/mojaSrbija/',
        }
      end, { nargs = 0 })
    end,
    -- enabled = false,
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    config = function()
      vim.keymap.set('n', '<leader>?', '<cmd>Cheatsheet<cr>', { silent = true, unique = true })
    end,
    opts = {},
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  },
  install = {
    colorscheme = { 'nord' },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

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
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go { severity = severity } end
end
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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
  pattern = { 'markdown', 'tex' },
  callback = function()
    local opts = { silent = true, unique = true }
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
      vim.api.nvim_set_current_line(ln:sub(1, col + 1) .. '[](' .. vim.fn.getreg '+' .. ')' .. ln:sub(col + 2, #ln + 1))
      vim.api.nvim_win_set_cursor(0, { row, col + 2 })
      vim.cmd 'startinsert'
    end, opts)
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'css', 'js', 'ts' },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.keymap.set('n', '<F5>', function()
      require('prochrome').open {
        is_app = true,
        on_start = { 'live-server', '--no-browser' },
        url = 'http://localhost:8080',
      }
    end, { silent = true, desc = 'Start live-server' })
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elm',
  callback = function()
    vim.keymap.set('n', '<F5>', function()
      require('prochrome').open {
        is_app = true,
        on_start = { 'elm-live', 'src/Main.elm', '--', '--debug' },
        url = 'http://localhost:8000',
      }
    end, { silent = true, desc = 'Start elm-live' })
  end,
})
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'Readme.md',
  callback = function()
    vim.keymap.set('n', '<F5>', function()
      require('prochrome').open {
        is_app = true,
        on_start = { 'gh', 'markdown-preview', '--disable-auto-open' },
        url = 'http://localhost:3333',
      }
    end, { silent = true, desc = 'Start github markdown preview' })
  end,
})
Path = require 'plenary.path'
local function get_rust_project_name()
  local file, text = io.open('Cargo.toml', 'rb')
  if file then
    text = file:read '*a'
    file:close()
  end
  local _, _, name = text:find '%[package%][^%[]*name%s*=%s*"(.-)"'
  return name
end
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.keymap.set('n', '<F5>', function()
      require('prochrome').open {
        is_app = true,
        on_start = { 'cargo', 'doc' },
        url = 'file://' .. Path:new('./target/doc/')
            :joinpath(get_rust_project_name())
            :joinpath('/index.html')
            :expand(),
      }
    end, { silent = true, desc = 'Start documentation' })
  end,
})
