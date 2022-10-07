local chrome = require'prochrome'.newApp {
  onStart = {'elm-live', 'src/Main.elm', '--', '--debug'},
  url = 'http://localhost:8000'
}
vim.keymap.set(
  'n', '<C-a>', function() chrome:get() end,
  { silent = true, desc = 'Start elm live server' }
)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
