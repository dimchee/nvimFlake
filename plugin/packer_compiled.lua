-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/dimchee/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/dimchee/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/dimchee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/dimchee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dimchee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  Notes = {
    config = { "require'notes'.setup{notes_dir = '~/Library/Neuron'}" },
    keys = { { "", "gzi" }, { "", "gzz" }, { "", "gzZ" }, { "", "gzn" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/Notes",
    url = "/home/dimchee/Code/Dev/Notes"
  },
  Replay = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/Replay",
    url = "https://github.com/chrisbra/Replay"
  },
  ["cmp-latex-symbols"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/cmp-latex-symbols",
    url = "https://github.com/kdheepak/cmp-latex-symbols"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/dimchee/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["crates.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/Saecki/crates.nvim"
  },
  ["dirbuf.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/dirbuf.nvim",
    url = "https://github.com/elihunter173/dirbuf.nvim"
  },
  ["haskell-tools.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/haskell-tools.nvim",
    url = "https://github.com/MrcJkb/haskell-tools.nvim"
  },
  ["hologram.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/hologram.nvim",
    url = "https://github.com/giusgad/hologram.nvim"
  },
  ["lean.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rmappings\2\nsetup\tlean\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/lean.nvim",
    url = "https://github.com/Julian/lean.nvim"
  },
  ["lsp_lines.nvim"] = {
    config = { "\27LJ\2\n”\2\0\0\a\0\15\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0005\3\a\0=\3\b\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\t\0B\0\1\0016\0\3\0009\0\n\0009\0\v\0'\2\f\0'\3\r\0006\4\0\0'\6\1\0B\4\2\0029\4\t\0045\5\14\0B\0\5\1K\0\1\0\1\0\1\tdesc\21Toggle lsp_lines\14<Leader>l\5\bset\vkeymap\vtoggle\18virtual_lines\1\0\1\22only_current_line\2\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim\nsetup\14lsp_lines\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nZ\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogit = {
    config = { "\27LJ\2\nŒ\1\0\0\a\0\n\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\0\0'\6\1\0B\4\2\0029\4\b\0045\5\t\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\topen\15<leader>gg\6n\bset\vkeymap\bvim\nsetup\vneogit\frequire\0" },
    keys = { { "", "<leader>gg" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["nord.nvim"] = {
    after = { "lualine.nvim" },
    config = { 'require"nord".set()' },
    loaded = true,
    needs_bufread = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/nord.nvim",
    url = "https://github.com/shaunsingh/nord.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire¯\5\1\0\n\0&\0I6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\15\0005\4\6\0009\5\3\0009\5\4\0055\a\5\0B\5\2\2=\5\a\0049\5\3\0009\5\b\5B\5\1\2=\5\t\0049\5\3\0009\5\n\5)\aüÿB\5\2\2=\5\v\0049\5\3\0009\5\n\5)\a\4\0B\5\2\2=\5\f\0049\5\3\0009\5\r\5B\5\1\2=\5\14\4=\4\3\0039\4\16\0009\4\17\0044\6\5\0005\a\18\0>\a\1\0065\a\19\0>\a\2\0065\a\20\0>\a\3\0065\a\21\0>\a\4\6B\4\2\2=\4\17\0035\4\23\0003\5\22\0=\5\24\4=\4\25\0035\4\26\0=\4\27\3B\1\2\0016\1\0\0'\3\28\0B\1\2\0029\1\29\1B\1\1\0029\2\30\0015\3 \0=\3\31\0026\2!\0006\4\0\0'\6\"\0B\4\2\0029\4#\4B\2\2\4H\5\5€6\a\0\0'\t$\0B\a\2\0028\a\5\a=\1%\aF\5\3\3R\5ù\127K\0\1\0\17capabilities\14lspconfig\fservers\19my.plugins.lsp\npairs\1\0\1\24dynamicRegistration\1\rcodeLens\17textDocument\25default_capabilities\17cmp_nvim_lsp\17experimental\1\0\2\15ghost_text\2\16native_menu\1\fsnippet\vexpand\1\0\0\0\1\0\1\tname\18latex_symbols\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\fsources\vconfig\1\0\0\n<C-e>\nclose\n<C-f>\n<C-d>\16scroll_docs\14<C-Space>\rcomplete\n<C-y>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\nsetup\bcmp\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\næ\5\0\0\a\0\30\0{5\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\5\0006\5\1\0009\5\6\0059\5\a\0059\5\b\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\t\0006\5\1\0009\5\6\0059\5\a\0059\5\n\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\v\0006\5\1\0009\5\6\0059\5\a\0059\5\f\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\r\0006\5\1\0009\5\6\0059\5\a\0059\5\14\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\15\0006\5\1\0009\5\6\0059\5\a\0059\5\16\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\17\0006\5\1\0009\5\6\0059\5\a\0059\5\18\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\19\0006\5\1\0009\5\6\0059\5\a\0059\5\20\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\21\0006\5\1\0009\5\6\0059\5\a\0059\5\22\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\23\0006\5\1\0009\5\6\0059\5\a\0059\5\24\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\25\0006\5\1\0009\5\6\0059\5\a\0059\5\26\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\27\0006\5\1\0009\5\6\0059\5\28\0059\5\29\5\18\6\0\0B\1\5\1K\0\1\0\brun\rcodelens\15<leader>cl\16code_action\15<leader>ca\vrename\15<leader>rn\15references\agr\19implementation\agi\19signature_help\n<C-k>\nhover\6K\20type_definition\agt\15definition\agd\16declaration\agD\vformat\bbuf\blsp\14<leader>f\6n\bset\vkeymap\bvim\1\0\3\vunique\1\vbuffer\2\vsilent\2¤\a\1\0\f\0)\0n5\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\5\0006\5\1\0009\5\6\0059\5\a\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\b\0006\5\1\0009\5\6\0059\5\t\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\n\0006\5\1\0009\5\6\0059\5\v\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\f\0006\5\1\0009\5\6\0059\5\r\5\18\6\0\0B\1\5\0016\1\1\0009\1\14\0019\1\15\1'\3\16\0004\4\0\0B\1\3\0016\1\1\0009\1\14\0019\1\17\1'\3\18\0005\4\19\0003\5\20\0=\5\21\4B\1\3\0016\1\1\0009\1\14\0019\1\17\0015\3\22\0005\4\23\0006\5\1\0009\5\14\0059\5\15\5'\a\24\0004\b\0\0B\5\3\2=\5\25\0046\5\1\0009\5\26\0059\5\27\0059\5\28\5=\5\21\4B\1\3\0016\1\29\0'\3\30\0B\1\2\0026\2\29\0'\4\31\0B\2\2\0029\2 \0024\4\0\0B\2\2\0016\2!\0006\4\29\0'\6\"\0B\4\2\0029\4#\4B\2\2\4H\5\v€8\a\5\0019\a \a6\t$\0\18\v\6\0B\t\2\2\a\t%\0X\t\2€\f\t\6\0X\t\1€4\t\0\0B\a\2\1F\5\3\3R\5ó\1276\2\1\0009\2\14\0029\2&\2'\4'\0'\5(\0004\6\0\0B\2\4\1K\0\1\0\18LspStart ltex\15SpellCheck\29nvim_create_user_command\ntable\ttype\fservers\19my.plugins.lsp\npairs\nsetup\vneodev\14lspconfig\frequire\frefresh\rcodelens\blsp\ngroup\28haskell-tools-code-lens\1\0\1\fpattern\fhaskell\1\a\0\0\rFileType\rBufEnter\15CursorHold\16InsertLeave\17BufWritePost\16TextChanged\rcallback\0\1\0\1\ngroup\22LspAttach_keymaps\14LspAttach\24nvim_create_autocmd\22LspAttach_keymaps\24nvim_create_augroup\bapi\15setloclist\14<leader>q\14goto_next\a]d\14goto_prev\a[d\15open_float\15diagnostic\14<leader>e\6n\bset\vkeymap\bvim\1\0\2\vunique\1\vsilent\2\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/nvim-luapad",
    url = "https://github.com/rafcamlet/nvim-luapad"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nm\0\0\4\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\1\0\1\22background_colour\f#000000\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nì\2\0\0\4\0\14\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0029\0\a\0B\0\1\0025\1\f\0005\2\t\0005\3\n\0=\3\v\2=\2\r\1=\1\b\0K\0\1\0\17install_info\1\0\1\rfiletype\rmarkdown\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl5https://github.com/ikatyang/tree-sitter-markdown\rmarkdown\23get_parser_configs\28nvim-treesitter.parsers\14highlight\1\0\0\1\0\2\venable\2&additional_vim_regex_highlighting\1\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["pets.nvim"] = {
    config = { "\27LJ\2\nU\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\npopup\1\0\0\1\0\1\rwinblend\3d\nsetup\tpets\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/pets.nvim",
    url = "https://github.com/giusgad/pets.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["prochrome.nvim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/prochrome.nvim",
    url = "https://github.com/dimchee/prochrome.nvim"
  },
  ["prolog.vim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/prolog.vim",
    url = "https://github.com/adimit/prolog.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/suda.vim",
    url = "https://github.com/lambdalisue/suda.vim"
  },
  ["telescope-manix"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/telescope-manix",
    url = "https://github.com/MrcJkb/telescope-manix"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n©\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\6\17persist_size\1\nsetup\3\20\14direction\15horizontal\20start_in_insert\2\17open_mapping\22<leader><leader>t\18close_on_exit\2\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  undotree = {
    config = { "\27LJ\2\n˜\1\0\0\a\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\0045\5\b\0B\0\5\0016\0\5\0'\2\6\0B\0\2\0029\0\t\0B\0\1\1K\0\1\0\nsetup\1\0\2\fnoremap\2\vsilent\2\vtoggle\rundotree\frequire\14<leader>u\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/jiaoshijie/undotree"
  },
  ["vale.nvim"] = {
    config = { "\27LJ\2\no\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\bbin\tvale\21vale_config_path $HOME/.config/vale/vale.ini\nsetup\tvale\frequire\0" },
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/vale.nvim",
    url = "https://github.com/marcelofern/vale.nvim"
  },
  ["vim-koka"] = {
    loaded = true,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/start/vim-koka",
    url = "https://github.com/Nymphium/vim-koka"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp_nvim_lsp"] = "cmp-nvim-lsp",
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: toggleterm.nvim
time([[Setup for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\15set hidden\bcmd\bvim\0", "setup", "toggleterm.nvim")
time([[Setup for toggleterm.nvim]], false)
time([[packadd for toggleterm.nvim]], true)
vim.cmd [[packadd toggleterm.nvim]]
time([[packadd for toggleterm.nvim]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\nY\0\2\b\0\6\0\v6\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\4\0\18\6\0\0&\5\6\5\18\6\1\0005\a\5\0B\2\5\1K\0\1\0\1\0\1\vsilent\2\14<leader>t\6n\bset\vkeymap\bvimE\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0À\1\0\1\bcwd\26$XDG_CONFIG_HOME/nvim\15find_filesD\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0À\1\0\1\bcwd\26$XDG_CONFIG_HOME/nvim\14live_grepT\0\0\3\0\4\0\t6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\1K\0\1\0\vsearch\20telescope-manix\14telescope\frequire«\2\1\0\6\0\20\0(6\0\0\0'\2\1\0B\0\2\0023\1\2\0\18\2\1\0'\4\3\0009\5\4\0B\2\3\1\18\2\1\0'\4\5\0009\5\6\0B\2\3\1\18\2\1\0'\4\a\0009\5\b\0B\2\3\1\18\2\1\0'\4\t\0009\5\n\0B\2\3\1\18\2\1\0'\4\v\0003\5\f\0B\2\3\1\18\2\1\0'\4\r\0003\5\14\0B\2\3\1\18\2\1\0'\4\15\0003\5\16\0B\2\3\0016\2\0\0'\4\17\0B\2\2\0029\2\18\2'\4\19\0B\2\2\0012\0\0€K\0\1\0\nmanix\19load_extension\14telescope\0\6n\0\acg\0\acf\14live_grep\6g\30current_buffer_fuzzy_find\6/\fbuffers\6b\15find_files\6t\0\22telescope.builtin\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: vimtex
time([[Setup for vimtex]], true)
try_loadstring("\27LJ\2\nß\1\0\0\2\0\t\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0)\1\2\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0+\1\2\0=\1\b\0K\0\1\0\26vimtex_view_automatic\fzathura\23vimtex_view_method\25vimtex_quickfix_mode\28vimtex_quickfix_enabled\rtectonic\27vimtex_compiler_method\6g\bvim\0", "setup", "vimtex")
time([[Setup for vimtex]], false)
-- Setup for: nord.nvim
time([[Setup for nord.nvim]], true)
try_loadstring("\27LJ\2\nY\0\0\2\0\5\0\t6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\3\0+\1\2\0=\1\4\0K\0\1\0\28nord_disable_background\6g\18termguicolors\6o\bvim\0", "setup", "nord.nvim")
time([[Setup for nord.nvim]], false)
time([[packadd for nord.nvim]], true)
vim.cmd [[packadd nord.nvim]]
time([[packadd for nord.nvim]], false)
-- Setup for: nvim-cmp
time([[Setup for nvim-cmp]], true)
try_loadstring("\27LJ\2\nI\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\4\0\0\tmenu\fmenuone\rnoselect\16completeopt\bopt\bvim\0", "setup", "nvim-cmp")
time([[Setup for nvim-cmp]], false)
time([[packadd for nvim-cmp]], true)
vim.cmd [[packadd nvim-cmp]]
time([[packadd for nvim-cmp]], false)
-- Setup for: undotree
time([[Setup for undotree]], true)
try_loadstring("\27LJ\2\nÞ\1\0\0\4\0\f\0\0306\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0+\1\1\0=\1\3\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2\14\0\1\0X\2\b€6\1\5\0009\1\6\1'\3\b\0B\1\2\2'\2\t\0&\1\2\1'\2\n\0&\1\2\1=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\v\0K\0\1\0\rundofile\14/vim/undo\18/.local/state\tHOME\19XDG_STATE_HOME\vgetenv\aos\fundodir\vbackup\rswapfile\bopt\bvim\0", "setup", "undotree")
time([[Setup for undotree]], false)
time([[packadd for undotree]], true)
vim.cmd [[packadd undotree]]
time([[packadd for undotree]], false)
-- Config for: vale.nvim
time([[Config for vale.nvim]], true)
try_loadstring("\27LJ\2\no\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\bbin\tvale\21vale_config_path $HOME/.config/vale/vale.ini\nsetup\tvale\frequire\0", "config", "vale.nvim")
time([[Config for vale.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nì\2\0\0\4\0\14\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0029\0\a\0B\0\1\0025\1\f\0005\2\t\0005\3\n\0=\3\v\2=\2\r\1=\1\b\0K\0\1\0\17install_info\1\0\1\rfiletype\rmarkdown\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\1\burl5https://github.com/ikatyang/tree-sitter-markdown\rmarkdown\23get_parser_configs\28nvim-treesitter.parsers\14highlight\1\0\0\1\0\2\venable\2&additional_vim_regex_highlighting\1\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire¯\5\1\0\n\0&\0I6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\15\0005\4\6\0009\5\3\0009\5\4\0055\a\5\0B\5\2\2=\5\a\0049\5\3\0009\5\b\5B\5\1\2=\5\t\0049\5\3\0009\5\n\5)\aüÿB\5\2\2=\5\v\0049\5\3\0009\5\n\5)\a\4\0B\5\2\2=\5\f\0049\5\3\0009\5\r\5B\5\1\2=\5\14\4=\4\3\0039\4\16\0009\4\17\0044\6\5\0005\a\18\0>\a\1\0065\a\19\0>\a\2\0065\a\20\0>\a\3\0065\a\21\0>\a\4\6B\4\2\2=\4\17\0035\4\23\0003\5\22\0=\5\24\4=\4\25\0035\4\26\0=\4\27\3B\1\2\0016\1\0\0'\3\28\0B\1\2\0029\1\29\1B\1\1\0029\2\30\0015\3 \0=\3\31\0026\2!\0006\4\0\0'\6\"\0B\4\2\0029\4#\4B\2\2\4H\5\5€6\a\0\0'\t$\0B\a\2\0028\a\5\a=\1%\aF\5\3\3R\5ù\127K\0\1\0\17capabilities\14lspconfig\fservers\19my.plugins.lsp\npairs\1\0\1\24dynamicRegistration\1\rcodeLens\17textDocument\25default_capabilities\17cmp_nvim_lsp\17experimental\1\0\2\15ghost_text\2\16native_menu\1\fsnippet\vexpand\1\0\0\0\1\0\1\tname\18latex_symbols\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\fsources\vconfig\1\0\0\n<C-e>\nclose\n<C-f>\n<C-d>\16scroll_docs\14<C-Space>\rcomplete\n<C-y>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n©\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\6\17persist_size\1\nsetup\3\20\14direction\15horizontal\20start_in_insert\2\17open_mapping\22<leader><leader>t\18close_on_exit\2\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: nord.nvim
time([[Config for nord.nvim]], true)
require"nord".set()
time([[Config for nord.nvim]], false)
-- Config for: crates.nvim
time([[Config for crates.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0", "config", "crates.nvim")
time([[Config for crates.nvim]], false)
-- Config for: lsp_lines.nvim
time([[Config for lsp_lines.nvim]], true)
try_loadstring("\27LJ\2\n”\2\0\0\a\0\15\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0005\3\a\0=\3\b\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\t\0B\0\1\0016\0\3\0009\0\n\0009\0\v\0'\2\f\0'\3\r\0006\4\0\0'\6\1\0B\4\2\0029\4\t\0045\5\14\0B\0\5\1K\0\1\0\1\0\1\tdesc\21Toggle lsp_lines\14<Leader>l\5\bset\vkeymap\vtoggle\18virtual_lines\1\0\1\22only_current_line\2\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim\nsetup\14lsp_lines\frequire\0", "config", "lsp_lines.nvim")
time([[Config for lsp_lines.nvim]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\n˜\1\0\0\a\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\0045\5\b\0B\0\5\0016\0\5\0'\2\6\0B\0\2\0029\0\t\0B\0\1\1K\0\1\0\nsetup\1\0\2\fnoremap\2\vsilent\2\vtoggle\rundotree\frequire\14<leader>u\6n\bset\vkeymap\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: pets.nvim
time([[Config for pets.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\npopup\1\0\0\1\0\1\rwinblend\3d\nsetup\tpets\frequire\0", "config", "pets.nvim")
time([[Config for pets.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\næ\5\0\0\a\0\30\0{5\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\5\0006\5\1\0009\5\6\0059\5\a\0059\5\b\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\t\0006\5\1\0009\5\6\0059\5\a\0059\5\n\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\v\0006\5\1\0009\5\6\0059\5\a\0059\5\f\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\r\0006\5\1\0009\5\6\0059\5\a\0059\5\14\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\15\0006\5\1\0009\5\6\0059\5\a\0059\5\16\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\17\0006\5\1\0009\5\6\0059\5\a\0059\5\18\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\19\0006\5\1\0009\5\6\0059\5\a\0059\5\20\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\21\0006\5\1\0009\5\6\0059\5\a\0059\5\22\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\23\0006\5\1\0009\5\6\0059\5\a\0059\5\24\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\25\0006\5\1\0009\5\6\0059\5\a\0059\5\26\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\27\0006\5\1\0009\5\6\0059\5\28\0059\5\29\5\18\6\0\0B\1\5\1K\0\1\0\brun\rcodelens\15<leader>cl\16code_action\15<leader>ca\vrename\15<leader>rn\15references\agr\19implementation\agi\19signature_help\n<C-k>\nhover\6K\20type_definition\agt\15definition\agd\16declaration\agD\vformat\bbuf\blsp\14<leader>f\6n\bset\vkeymap\bvim\1\0\3\vunique\1\vbuffer\2\vsilent\2¤\a\1\0\f\0)\0n5\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\5\0006\5\1\0009\5\6\0059\5\a\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\b\0006\5\1\0009\5\6\0059\5\t\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\n\0006\5\1\0009\5\6\0059\5\v\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\f\0006\5\1\0009\5\6\0059\5\r\5\18\6\0\0B\1\5\0016\1\1\0009\1\14\0019\1\15\1'\3\16\0004\4\0\0B\1\3\0016\1\1\0009\1\14\0019\1\17\1'\3\18\0005\4\19\0003\5\20\0=\5\21\4B\1\3\0016\1\1\0009\1\14\0019\1\17\0015\3\22\0005\4\23\0006\5\1\0009\5\14\0059\5\15\5'\a\24\0004\b\0\0B\5\3\2=\5\25\0046\5\1\0009\5\26\0059\5\27\0059\5\28\5=\5\21\4B\1\3\0016\1\29\0'\3\30\0B\1\2\0026\2\29\0'\4\31\0B\2\2\0029\2 \0024\4\0\0B\2\2\0016\2!\0006\4\29\0'\6\"\0B\4\2\0029\4#\4B\2\2\4H\5\v€8\a\5\0019\a \a6\t$\0\18\v\6\0B\t\2\2\a\t%\0X\t\2€\f\t\6\0X\t\1€4\t\0\0B\a\2\1F\5\3\3R\5ó\1276\2\1\0009\2\14\0029\2&\2'\4'\0'\5(\0004\6\0\0B\2\4\1K\0\1\0\18LspStart ltex\15SpellCheck\29nvim_create_user_command\ntable\ttype\fservers\19my.plugins.lsp\npairs\nsetup\vneodev\14lspconfig\frequire\frefresh\rcodelens\blsp\ngroup\28haskell-tools-code-lens\1\0\1\fpattern\fhaskell\1\a\0\0\rFileType\rBufEnter\15CursorHold\16InsertLeave\17BufWritePost\16TextChanged\rcallback\0\1\0\1\ngroup\22LspAttach_keymaps\14LspAttach\24nvim_create_autocmd\22LspAttach_keymaps\24nvim_create_augroup\bapi\15setloclist\14<leader>q\14goto_next\a]d\14goto_prev\a[d\15open_float\15diagnostic\14<leader>e\6n\bset\vkeymap\bvim\1\0\2\vunique\1\vsilent\2\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nm\0\0\4\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\1\0\1\22background_colour\f#000000\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\nZ\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0", "config", "lualine.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Telescope', function(cmdargs)
          require('packer.load')({'telescope.nvim'}, { cmd = 'Telescope', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'telescope.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Telescope ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> gzn <cmd>lua require("packer.load")({'Notes'}, { keys = "gzn", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>gg <cmd>lua require("packer.load")({'neogit'}, { keys = "<lt>leader>gg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gzi <cmd>lua require("packer.load")({'Notes'}, { keys = "gzi", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gzz <cmd>lua require("packer.load")({'Notes'}, { keys = "gzz", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gzZ <cmd>lua require("packer.load")({'Notes'}, { keys = "gzZ", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lean ++once lua require("packer.load")({'lean.nvim'}, { ft = "lean" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/lean.nvim/ftdetect/lean.lua]], true)
vim.cmd [[source /home/dimchee/.local/share/nvim/site/pack/packer/opt/lean.nvim/ftdetect/lean.lua]]
time([[Sourcing ftdetect script at: /home/dimchee/.local/share/nvim/site/pack/packer/opt/lean.nvim/ftdetect/lean.lua]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
