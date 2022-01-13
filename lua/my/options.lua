--Incremental live completion
vim.o.inccommand = 'nosplit'

-- Set tab options for vim
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
vim.opt.softtabstop = 4

-- Allow filetype plugins and syntax highlighting
vim.opt.autoindent = true
vim.opt.smartindent = true                      -- make indenting smarter again

-- Set highlight on search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true

-- Make line numbers default
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                  -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
--vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
--vim.opt.showtabline = 4                         -- always show tabs
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.wrap = false                            -- display lines as one long line
vim.cmd[[set linebreak]] -- ne deli reci na kraju reda

-- Backups and undos
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false                        -- creates a swapfile
vim.cmd[[set undodir=~/.undodir]]


--Do not save when switching buffers
vim.o.hidden = true

--Set show command
--vim.o.showcmd = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.cmd[[set noerrorbells]]

-- Open link with gx
vim.g.netrw_browser_viewer = 'firefox'
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim

-- :help options
-- vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
-- vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
-- vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
-- vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
-- vim.opt.pumheight = 10                          -- pop up menu height
-- vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
-- vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
-- vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
-- vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
-- vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.opt.cursorline = true                       -- highlight the current line
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

-- vim.opt.shortmess:append "c"

-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
