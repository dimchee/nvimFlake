local M = {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
    ft = 'dart'
}

function M.config()
    local flutter_sdk = vim.fn.resolve(vim.fn.getenv'flutter_sdk')
    require'flutter-tools'.setup {
        widget_guides = {
            enabled = true
        },
        flutter_path = flutter_sdk.."/bin/flutter",
        lsp = {
            on_attach = require'my.plugins.lsp'.on_attach
        }
    }
    vim.keymap.set(
        'n', '<leader>ot', '<cmd>flutteroutlinetoggle<cr>', { silent=true, unique=true, buffer=0 }
    )
    require'telescope'.load_extension'flutter'
end

return M
