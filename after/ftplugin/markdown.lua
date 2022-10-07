require'my.cyrillic'

local chrome = require'prochrome'.newApp {
  onStart = {'gh', 'markdown-preview', '--disable-auto-open'},
  url = 'http://localhost:3333'
}
vim.keymap.set(
  'n', '<C-a>', function() chrome:get() end,
  { silent = true, desc = 'Start github markdown preview' }
)
