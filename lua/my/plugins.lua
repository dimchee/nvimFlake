local fn = vim.fn
local get_rfile = vim.api.nvim_get_runtime_file

local packer_path = fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
local packer_url = 'https://github.com/wbthomason/packer.nvim'

if fn.empty(fn.glob(packer_path)) > 0 then
    BOOTSTRAP = fn.system {'git', 'clone', '--depth', '1', packer_url, packer_path}
    print'Installing packer, when complete restart neovim..'
    vim.cmd'packadd packer.nvim'
end

local ok, packer = pcall(require, 'packer')
if not ok and not BOOTSTRAP then
    -- maybe data dir already populated, and just need to add packer
    vim.cmd'packadd packer.nvim'
    ok, packer = pcall(require, 'packer')
end

if not ok then
    print'was not able to require packer'
end

return ok and packer.startup(function(use)
    use {'wbthomason/packer.nvim', opt=true}
    for _, mod in ipairs(get_rfile('lua/my/plugins/*.lua', true)) do
        local ok, m = pcall(loadfile(mod))
        if type(m) == 'table' and ok then use(m)
        elseif type(m) == 'string' then print('Can\'t load file '..mod..' error: '..m)
        else print'WTF' end
    end
    use {'L3MON4D3/LuaSnip',
        config = function()
            vim.keymap.set({ "i", "s" }, "<c-k>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<c-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
            require'my.snippets'
        end
    }
    use {
        'shaunsingh/nord.nvim',
        setup = function()
            vim.o.termguicolors = true
            vim.g.nord_disable_background = true
        end, config = 'require"nord".set()'
    }
    use {
        'folke/which-key.nvim',
        config = 'require"which-key".setup {}'
    }
    use {'nathom/filetype.nvim'} -- faster startup + filetypes
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function() require'lualine'.setup {options = {theme = 'nord'}} end
    }
    use {'rafcamlet/nvim-luapad',
        config = function() require'luapad'.setup{} end
    }
    use {'Olical/conjure'} 
    use {'purescript-contrib/purescript-vim', ft='purescript',
        setup = function() vim.cmd'au BufNewFile,BufRead *.purs set filetype=purescript' end, 
        config = function()
            vim.cmd'syntax on'
            vim.cmd'filetype on'
            vim.cmd'filetype plugin indent on'
        end
    }
    use {'adimit/prolog.vim', ft='prolog',
        setup = function() vim.cmd'au BufNewFile,BufRead *.pl set filetype=prolog' end
    }
    use {'ShinKage/idris2-nvim', ft='idris2',
    -- install lsp first:
    -- https://github.com/idris-community/idris2-lsp/issues/68
        requires = {'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim'},
        config = function()
            require'idris2'.setup{}
        end
    }
    use {'RRethy/nvim-align'}
    use {
        'numToStr/Comment.nvim',
        config = function()
            require'Comment'.setup()
        end
    }
    use {
        'saecki/crates.nvim',
        event = {'BufRead Cargo.toml'},
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require'crates'.setup()
        end,
    }
    use {
        '~/Code/Nvim/notes',
        config = function()
            require'notes'.setup{notes_dir = '~/Library/Neuron'}
        end
    }
    -- use {
    --     '~/Code/Nvim/prochrome'
    -- }
    use {'dimchee/prochrome', run = 'bash install.sh' }

    if BOOTSTRAP then
        require'packer'.sync()
        require'nvim-treesitter.install'.install({ask_reinstall=true}, 'all')
    end
end)

-- ToDo
-- https://github.com/jghauser/follow-md-links.nvim
-- https://github.com/folke/trouble.nvim
-- https://github.com/nekonako/xresources-nvim
-- https://github.com/phaazon/hop.nvim
-- https://github.com/blackCauldron7/surround.nvim
-- https://github.com/kevinhwang91/nvim-bqf
-- https://github.com/nvim-neorg/neorg
-- https://github.com/hkupty/iron.nvim
-- https://github.com/jubnzv/virtual-types.nvim/
-- https://github.com/folke/which-key.nvim
-- https://github.com/onsails/lspkind-nvim
-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/akinsho/bufferline.nvim
-- https://github.com/romgrk/barbar.nvim
-- https://github.com/kyazdani42/nvim-tree.lua
-- https://github.com/notomo/gesture.nvim
-- https://github.com/numToStr/Comment.nvim
-- https://github.com/ThePrimeagen/vim-be-good
-- https://github.com/nvim-neorg/neorg
-- https://github.com/svermeulen/vimpeccable
-- https://github.com/CRAG666/code_runner.nvim
-- https://github.com/michaelb/sniprun
-- https://github.com/simrat39/rust-tools.nvim
-- https://github.com/hood/popui.nvim or https://github.com/nvim-telescope/telescope-ui-select.nvim
-- https://github.com/psiska/telescope-hoogle.nvim for haskell
-- https://github.com/tamago324/telescope-openbrowser.nvim
-- https://github.com/habamax/vim-godot
-- for sql https://github.com/tpope/vim-dadbod
-- https://github.com/nathom/filetype.nvim to get faster
-- https://github.com/xiyaowong/telescope-emoji.nvim
-- https://github.com/dhruvmanila/telescope-bookmarks.nvim
-- https://github.com/tamago324/telescope-openbrowser.nvim
-- https://github.com/Pocco81/HighStr.nvim
-- nice theme https://github.com/adisen99/apprentice.nvim
-- https://github.com/molleweide/LuaSnip-snippets.nvim
-- https://github.com/arjunmahishi/run-code.nvim
-- https://github.com/rcarriga/nvim-dap-ui
--
-- Langs:
-- use {'JuliaEditorSupport/julia-vim'}
-- -- if using ft='julia' E117: Unknown function: LaTeXtoUnicode#Refresh
-- use {'ziglang/zig.vim', ft='zig'}
-- use {'LnL7/vim-nix', ft='nix'}
-- use {'habamax/vim-godot', ft='gdscript'}
-- use {'glslang/agda-vim', ft='agda'}
-- use {'tikhomirov/vim-glsl', ft='glsl',
--     setup = function()
--         vim.cmd'autocmd! BufNewFile,BufRead *.vs,*.fs,*.glsl set ft=glsl'
--     end
-- }
