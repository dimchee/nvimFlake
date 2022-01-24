local fn = vim.fn
local get_rfile = vim.api.nvim_get_runtime_file

local packer_path = fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
local packer_url = 'https://github.com/wbthomason/packer.nvim'

BOOTSTRAP = fn.empty(fn.glob(packer_path)) > 0 
if BOOTSTRAP then
    fn.system {'git', 'clone', packer_url, packer_path}
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
        else print('Can\'t load module'..mod) end
    end
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
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function() require'lualine'.setup {options = {theme = 'nord'}} end
    }
    use {'rafcamlet/nvim-luapad',
        config = function() require('luapad').setup{} end
    }
    use {'purescript-contrib/purescript-vim', ft='purescript',
        config = function()
            vim.cmd'syntax on'
            vim.cmd'filetype on'
            vim.cmd'filetype plugin indent on'
        end
    }
    use {'RRethy/nvim-align'}

    BOOTSTRAP = BOOTSTRAP and require'packer'.sync()
    BOOTSTRAP = BOOTSTRAP and require'nvim-treesitter.install'.install {ask_reinstall=true} "all"
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
--
-- Langs:
-- https://github.com/ShinKage/idris2-nvim
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
