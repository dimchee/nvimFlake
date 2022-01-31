-- Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
vim.g.mapleader = ','
vim.g.maplocalleader = ','
local opts = { silent=true, noremap=true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


vim.keymap.set('n', '<leader>R', '<cmd>luafile $VIM_HOME/init.lua<cr>', opts)
vim.keymap.set('n', '<space><space>', '<cmd>nohls<cr>', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ":m .+1<CR>==", opts)
vim.keymap.set('v', '<A-k>', ":m .-2<CR>==", opts)
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", opts)
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)
