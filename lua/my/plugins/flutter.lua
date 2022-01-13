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
            on_attach = require'lsp'.on_attach
        }
    }
    vim.api.nvim_buf_set_keymap(
        0, "n", "<leader>ot", "<cmd>flutteroutlinetoggle<cr>", { silent=true, unique=true }
    )
    require'telescope'.load_extension'flutter'
end

return M
