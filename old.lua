-- ToDo
-- Should make dependencies list! (add to flake or something)
-- - tree-sitter
-- - tree-sitter-grammars.*
-- use vim.iter
-- - snipet for url pasting from clipboard
-- - nvim keybinding cheatsheet, way to learn bindings (practice one random every day)
-- - use https://github.com/artempyanykh/marksman
-- - results of c compiler to quickfix list
-- - in visual o ili O - s pocetka na kraj ili obrnuto
-- - ^M - <C-v><C-m> da se unese (windows ending)
-- - gq - split line to visual lines
-- - learn about omni-completion
-- - :help scroll-cursor
-- - use vim.lsp.start
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
-- https://github.com/EmmyLuaLs/emmylua-analyzer-rust
--
-- Plugins
-- 'rachartier/tiny-glimmer.nvim'
-- 'rachartier/tiny-inline-diagnostic.nvim'
-- 'Wansmer/treesj'
-- 'hat0uma/csvview.nvim'
-- 'Goose97/timber.nvim'
-- 'jake-stewart/multicursor.nvim'
-- 'meznaric/key-analyzer.nvim'
-- 'nvim-neotest/neotest'
-- 'b0o/SchemaStore.nvim'
-- 'lvimuser/lsp-inlayhints.nvim'
-- 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
-- 'hoob3rt/lualine.nvim'
-- 'rafcamlet/nvim-luapad'
-- 'L3MON4D3/LuaSnip'
-- 'shaunsingh/nord.nvim'
-- 'rcarriga/nvim-notify'
-- 'dimchee/prochrome.nvim'
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
-- 'dgagn/diagflow.nvim'
-- 'onsails/diaglist.nvim'
-- 'piersolenski/wtf.nvim'
-- 'nvimdev/guard.nvim'
-- 'folke/snacks.nvim'
-- 'yetone/avante.nvim'

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
  spec = {

    { 'nvim-lua/plenary.nvim' },
    -- Until resolved https://github.com/neovim/neovim/issues/12103
    { 'lambdalisue/suda.vim' },
    -- { dir = '~/Desktop/zig.nvim', opts = {} },
    {
      'dimchee/notes.nvim',
      -- dir = "~/Git/notes.nvim",
      opts = {
        notes_dir = '~/XDG/Notes',
      },
    },
    {
      'hat0uma/csvview.nvim',
      opts = {
        parser = { comments = { '#', '//' } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { 'if', mode = { 'o', 'x' } },
          textobject_field_outer = { 'af', mode = { 'o', 'x' } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
          jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
          jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
          jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
        },
      },
      cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
    },
    -- {
    --   'robitx/gp.nvim',
    --   config = function()
    --     local conf = {
    --       -- For customization, refer to Install > Configuration in the Documentation/Readme
    --     }
    --     require('gp').setup(conf)
    --   end,
    -- },
    -- -- https://github.com/folke/neoconf.nvim
    -- {
    --   'Julian/lean.nvim',
    --   event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    --
    --   dependencies = {
    --     'neovim/nvim-lspconfig',
    --     'nvim-lua/plenary.nvim',
    --     -- you also will likely want nvim-cmp or some completion engine
    --   },
    --
    --   -- see details below for full configuration options
    --   opts = {
    --     mappings = true,
    --   },
    -- },
    {
      'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim',  -- required
        'sindrets/diffview.nvim', -- optional - Diff integration

        -- Only one of these is needed, not both.
        'nvim-telescope/telescope.nvim', -- optional
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
          keymap('<leader>gp', function() require('gitsigns').nav_hunk 'prev' end, '[G]o to [P]revious Hunk')
          keymap('<leader>gn', function() require('gitsigns').nav_hunk 'next' end, '[G]o to [N]ext Hunk')
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
            -- '--synctex',
            '-Z shell-escape',
            -- '--keep-logs',
          },
        }
        vim.g.vimtex_quickfix_enabled = true
        vim.g.vimtex_quickfix_method = 'pplatex'
        vim.g.vimtex_quickfix_mode = 2
        -- vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_view_automatic = true
        vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } }
        -- vim.keymap.set('n', '<F5>', '<cmd>VimtexCompile<cr>', { silent = true, desc = 'Compile latex file' })
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
        { 'j-hui/fidget.nvim',     opts = {} },
        { 'rafcamlet/nvim-luapad', opts = {} },
        -- { 'zeioth/garbage-day.nvim', event = "VeryLazy", opts = {} },
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
            -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
          end,
        })
      end,
      config = function()
        vim.lsp.config('lua_ls', {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if
                  path ~= vim.fn.stdpath 'config'
                  and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
              then
                return
              end
            end
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = {
                  'lua/?.lua',
                  'lua/?/init.lua',
                },
              },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
            })
          end,
          settings = {
            Lua = {},
          },
        })
        vim.lsp.config('ltex', { autostart = false })
        -- vim.lsp.config('clangd', { cmd = { 'clangd', '--query-driver=gcc' }})

        vim.lsp.enable 'ltex'
        vim.lsp.enable 'lua_ls'
        vim.lsp.enable 'ruff'
        vim.lsp.enable 'pyright'
        vim.lsp.enable 'julials'
        vim.lsp.enable 'texlab'
        vim.lsp.enable 'gleam'
        vim.lsp.enable 'elmls'
        vim.lsp.enable 'taplo'
        vim.lsp.enable 'nixd'
        vim.lsp.enable 'zls'
        vim.lsp.enable 'clangd'
        vim.lsp.enable 'gopls'
        -- java script / web
        vim.lsp.enable 'ts_ls'
        vim.lsp.enable 'biome'
        vim.lsp.enable 'cssls'
        vim.lsp.enable 'superhtml'
        -- vim.lsp.enable('vls')
        vim.lsp.enable 'stylua'

        vim.lsp.enable 'tinymist'
        -- vim.lsp.config('tinymist', {
        --   settings = {
        --     formatterMode = 'typstyle',
        --     exportPdf = 'onType',
        --     semanticTokens = 'disable',
        --   },
        -- })
      end,
    },
    {
      'nvim-flutter/flutter-tools.nvim',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
      },
      config = true,
    },
    {
      'chomosuke/typst-preview.nvim',
      lazy = false, -- or ft = 'typst'
      version = '1.*',
      opts = {
        invert_colors = 'auto',
        dependencies_bin = {
          ['tinymist'] = 'tinymist',
        },
      }, -- lazy.nvim will implicitly calls `setup {}`
    },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          'nvim-dap-ui',
        },
      },
    },
    {
      'mrcjkb/haskell-tools.nvim',
      version = '^3', -- Recommended
      lazy = false,   -- This plugin is already lazy
    },
    {
      'mrcjkb/rustaceanvim',
      version = '^5', -- Recommended
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
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      init = function() require('luasnip.loaders.from_vscode').lazy_load() end,
    },
    {
      'dupeiran001/nord.nvim',
      lazy = false,
      priority = 1000,
      opts = {},
      init = function() vim.cmd.colorscheme 'nord' end,
    },
    {
      'nvim-lualine/lualine.nvim',
      opts = {
        options = {
          icons_enabled = true,
          theme = 'nord',
        },
        sections = { lualine_c = { 'overseer', 'filename' } },
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
    -- {
    --   'echasnovski/mini.indentscope',
    --   version = '*',
    --   opts = {
    --     -- symbol = "▏",
    --     symbol = '│',
    --     options = { try_as_border = true },
    --   },
    -- },
    { 'numToStr/Comment.nvim', opts = {} },
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      keys = {
        -- See `:help telescope.builtin`
        -- { '<leader>?',       '<cmd>Telescope oldfiles     <cr>',                                                      desc = '[?] Find recently opened files' },
        {
          '<leader><space>',
          '<cmd>Telescope buffers<cr>',
          desc = '[ ] Find existing buffers',
        },
        {
          '<leader>gf',
          '<cmd>Telescope git_files   <cr>',
          desc = 'Search [G]it [F]iles',
        },
        {
          '<leader>sf',
          '<cmd>Telescope find_files  <cr>',
          desc = '[S]earch [F]iles',
        },
        {
          '<leader>sh',
          '<cmd>Telescope help_tags   <cr>',
          desc = '[S]earch [H]elp',
        },
        {
          '<leader>sw',
          '<cmd>Telescope grep_string <cr>',
          desc = '[S]earch current [W]ord',
        },
        {
          '<leader>sg',
          '<cmd>Telescope live_grep   <cr>',
          desc = '[S]earch by [G]rep',
        },
        {
          '<leader>sd',
          '<cmd>Telescope diagnostics <cr>',
          desc = '[S]earch [D]iagnostics',
        },
        {
          '<leader>cf',
          function() require('telescope.builtin').find_files { cwd = '$XDG_CONFIG_HOME/nvim' } end,
          desc = '[C]onfig [F]iles',
        },
        {
          '<leader>cg',
          function() require('telescope.builtin').live_grep { cwd = '$XDG_CONFIG_HOME/nvim' } end,
          desc = '[C]onfig [G]rep',
        },
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
      opts = {
        -- solves strange bug with preview in gzz
        defaults = {
          preview = {
            treesitter = false,
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<c-d>'] = 'delete_buffer',
              },
            },
          },
        },
      },
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- {
    --   'nvim-telescope/telescope-fzf-native.nvim',
    --   build = 'make',
    --   cond = function() return vim.fn.executable 'make' == 1 end,
    -- },
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        { 'nushell/tree-sitter-nu' },
      },
      lazy = false,
      build = ':TSUpdate',
      -- ensure_installed = { 'go', 'lua', 'python', 'rust', 'vimdoc', 'elm', 'haskell', 'nix', 'zig', 'markdown', 'markdown_inline', 'html', 'css', 'javascript' },
    },
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      opts = {
        setup = 20,
        direction = 'horizontal',
        persist_size = false,
        open_mapping = '<c-\\><c-\\>',
        start_in_insert = true,
        close_on_exit = true,
        highlights = {
          Normal = { link = 'Normal' },
          NormalFloat = { link = 'NormalFloat' },
          FloatBorder = { link = 'FloatBorder' },
        },
      },
    },
    {
      'stevearc/oil.nvim',
      opts = {},
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- -- {
    -- --   'stevearc/conform.nvim',
    -- --   opts = {
    -- --     formatters_by_ft = {
    -- --       lua = { 'stylua' },
    -- --     },
    -- --     formatters = {
    -- --       injected = { options = { ignore_errors = true } },
    -- --     },
    -- --     format_on_save = {
    -- --       lsp_format = "fallback",
    -- --       timeout_ms = 500,
    -- --     },
    -- --   },
    -- -- },
    --
    -- {
    --   'jiaoshijie/undotree',
    --   dependencies = { 'nvim-lua/plenary.nvim' },
    --   init = function()
    --     vim.opt.swapfile = false
    --     vim.opt.backup = false
    --     vim.opt.undodir = os.getenv 'XDG_STATE_HOME' or (os.getenv 'HOME' .. '/.local/state') .. "/vim/undo"
    --     vim.opt.undofile = true
    --   end,
    --   config = function()
    --     vim.keymap.set(
    --       'n', '<leader>u', require 'undotree'.toggle,
    --       { noremap = true, silent = true }
    --     )
    --     require 'undotree'.setup()
    --   end
    -- },
    {
      'dimchee/prochrome.nvim',
      build = 'bash install.sh',
      config = function()
        vim.api.nvim_create_user_command(
          'Browse',
          function(opts) require('prochrome').open { url = opts.fargs[1] } end,
          { nargs = 1 }
        )
        vim.api.nvim_create_user_command(
          'Hugo',
          function()
            require('prochrome').open {
              is_app = true,
              on_start = { 'hugo', 'server', '-D', '--navigateToChanged' },
              url = 'http://localhost:1313/mojaSrbija/',
            }
          end,
          { nargs = 0 }
        )
      end,
      -- enabled = false,
    },
    -- {
    --   'sudormrfbin/cheatsheet.nvim',
    --   config = function()
    --     vim.keymap.set('n', '<leader>?', '<cmd>Cheatsheet<cr>', { silent = true, unique = true })
    --   end,
    --   opts = {},
    --   dependencies = {
    --     { 'nvim-telescope/telescope.nvim' },
    --     { 'nvim-lua/popup.nvim' },
    --     { 'nvim-lua/plenary.nvim' },
    --   }
    -- },
    -- {
    --   "Zeioth/compiler.nvim",
    --   cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    --   dependencies = {
    --     'nvim-telescope/telescope.nvim',
    --     { 'stevearc/overseer.nvim', opts = {} },
    --   },
    --   opts = {},
    --   init = function()
    --     local opts = { noremap = true, silent = true }
    --     local map = vim.api.nvim_set_keymap
    --     map('n', '<F5>', "<cmd>CompilerRedo<cr>", opts)
    --     map('n', '<F6>', "<cmd>CompilerToggleResults<cr>", opts)
    --     map('n', '<F7>', "<cmd>CompilerOpen<cr>", opts)
    --   end
    -- },
    {
      'mfussenegger/nvim-dap',
      dependencies = {
        {
          'theHamsta/nvim-dap-virtual-text',
          opts = {},
        },
      },
      init = function()
        require('dap').adapters.codelldb = {
          type = 'executable',
          command = 'codelldb',
        }
        require('dap').configurations.zig = {
          {
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            -- program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
            program = function()
              return vim.fn.input(
                'Path to executable: ',
                vim.fn.getcwd() .. '/zig-out/bin/',
                'file'
              )
            end,
            cwd = '${workspaceFolder}/zig-out/bin',
            stopOnEntry = false,
            args = {},
          },
        }
      end,
      -- stylua: ignore
      keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>dO", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>do", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
      },
    },
    { 'rcarriga/nvim-dap-ui',  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }, opts = {} },
    {
      'stevearc/overseer.nvim',
      opts = {},
      init = function()
        local function get_zig_build(opts)
          return vim.fs.find('build.zig', { upward = true, type = 'file', path = opts.dir })[1]
        end
        require('overseer').register_template {
          name = 'zig build',
          cache_key = get_zig_build,
          generator = function(opts, callback)
            if vim.fn.executable 'zig' == 0 then return 'Command "zig" not found' end
            local build_zig = get_zig_build(opts)
            if not build_zig then return 'No build.zig found' end
            local cwd = vim.fs.dirname(build_zig)

            local ret = {}
            require('overseer').builtin.system(
              { 'zig', 'build', '--help' },
              { cwd = cwd, text = true, env = { ['LANG'] = 'C.UTF-8' } },
              vim.schedule_wrap(function(out)
                if out.code ~= 0 and out.code ~= 1 then
                  return callback(out.stderr or out.stdout or "Error running 'zig build'")
                end

                local parsing = false
                for line in vim.gsplit(out.stdout, '\n') do
                  if line:find 'Steps:' == 1 then
                    parsing = true
                  elseif parsing and line == '' then
                    break
                  elseif parsing then
                    table.insert(ret, {
                      name = string.format('%s', line),
                      builder = function()
                        return {
                          cmd = { 'zig', 'build', line:match '%S+' },
                          cwd = cwd,
                          components = {
                            {
                              'on_output_parse',
                              errorformat = table.concat({
                                '%E%f:%l:%c: error: %m',
                                '%W%f:%l:%c: note: %m',
                                '%Z%p^',
                                '%-G%.%#',
                              }, ','),
                            },
                            { 'on_result_diagnostics', remove_on_restart = true },
                            'default',
                          },
                        }
                      end,
                    })
                  end
                end

                callback(ret)
              end)
            )
          end,
        }
        vim.api.nvim_create_user_command('OverseerRestartLast', function()
          local overseer = require 'overseer'
          local tasks = overseer.list_tasks { recent_first = true }
          if vim.tbl_isempty(tasks) then
            vim.notify('No tasks found', vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], 'restart')
          end
        end, {})
        local opts = { noremap = true, silent = true }
        local map = vim.api.nvim_set_keymap
        map('n', '<leader>cc', '<cmd>OverseerRestartLast<cr>', opts)
        map('n', '<leader>ct', '<cmd>OverseerToggle<cr>', opts)
        map('n', '<F5>', '<cmd>OverseerRun<cr>', opts)
      end,
    },
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
-- vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
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
vim.api.nvim_create_user_command('Llama', function(_)
  local buf = vim.api.nvim_create_buf(true, false)
  local win = vim.api.nvim_open_win(buf, false, { split = 'right' })
  vim.api.nvim_set_current_win(win)
  vim.fn.jobstart({ 'llama-cli', '-hf', 'ggml-org/gemma-3n-E2B-it-GGUF' }, { term = true })
end, { desc = 'Open llama.cpp instance in split' })
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
      vim.api.nvim_set_current_line(ln:sub(1, col + 1) .. '[](' .. vim.fn.getreg '+' .. ')' .. ln:sub(col + 2, #ln + 1))
      vim.api.nvim_win_set_cursor(0, { row, col + 2 })
      vim.cmd 'startinsert'
    end, opts)
  end,
})
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'markdown' },
--   callback = function()
--     local opts = { silent = true, unique = true }
--     vim.keymap.set('v', 'gs', function()
--       local crow, ccol = unpack(vim.api.nvim_win_get_cursor(0))
--       local vrow, vcol = vim.fn.line('v'), vim.fn.col('v')
--       ccol = ccol + 1
--       if crow ~= vrow then
--         vim.notify("can't search multiple lines")
--       end
--       local ln = vim.api.nvim_get_current_line()
--       local visual = ln:sub(ccol < vcol and ccol or vcol, ccol < vcol and vcol or ccol)
--       vim.fn.jobstart({ "firefox", "--search", visual })
--     end, opts)
--   end,
-- })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'css', 'js', 'ts' },
  callback = function()
    vim.keymap.set(
      'n',
      '<F5>',
      function()
        require('prochrome').open {
          is_app = true,
          on_start = { 'live-server', '--no-browser' },
          url = 'http://localhost:8080',
        }
      end,
      { silent = true, desc = 'Start live-server' }
    )
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'elm',
  callback = function()
    vim.keymap.set(
      'n',
      '<F5>',
      function()
        require('prochrome').open {
          is_app = true,
          on_start = { 'elm-live', 'src/Main.elm', '--', '--output', 'elm-stuff/main.js', '--debug' },
          url = 'http://localhost:8000',
        }
      end,
      { silent = true, desc = 'Start elm-live' }
    )
  end,
})
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'Readme.md',
  callback = function()
    vim.keymap.set(
      'n',
      '<F5>',
      function()
        require('prochrome').open {
          is_app = true,
          on_start = { 'gh', 'markdown-preview', '--disable-auto-open' },
          url = 'http://localhost:3333',
        }
      end,
      { silent = true, desc = 'Start github markdown preview' }
    )
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
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'rust',
--   callback = function()
--     vim.keymap.set('n', '<F5>', function()
--       require('prochrome').open {
--         is_app = true,
--         on_start = { 'cargo', 'doc' },
--         url = 'file://' .. Path:new('./target/doc/')
--             :joinpath(get_rust_project_name())
--             :joinpath('/index.html')
--             :expand(),
--       }
--     end, { silent = true, desc = 'Start documentation' })
--   end,
-- })
