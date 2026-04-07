require'my.cyrillic'

local opts = { silent=true, buffer=0 }
vim.keymap.set('n', '<C-a>', '<cmd>VimtexCompile<cr>', opts)
