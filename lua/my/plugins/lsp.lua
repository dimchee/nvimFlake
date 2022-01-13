local M = {
    'neovim/nvim-lspconfig',
    cmd = 'LspStart',
	module = 'lspconfig',
}

M.servers = {
    'hls', 'rust_analyzer', 'gopls', 'texlab', 'purescriptls',
    'rnix', 'bashls', 'elmls', 'pyright', 'zls', 'gdscript'
}

M.config = function()
    vim.lsp.set_log_level("debug") -- debugging
    local lspconf = require'lspconfig'
    local lsp = require'my.plugins.lsp'

    for _, s in ipairs(lsp.servers) do
        lspconf[s].setup {
            on_attach = lsp.on_attach
        }
    end
    lspconf.ccls.setup {
        on_attach = lsp.on_attach,
        cmd = {'ccls', '--init={"clang":{"extraArgs": ["-std=c++17"]}}'}
    }
    local util = require 'lspconfig/util'
    lspconf.julials.setup {
        on_attach = lsp.on_attach,
        root_dir = function(fname)
            return util.find_git_ancestor(fname) or util.path.dirname(fname)
        end,
    }
    lsp.lsp_lua_config()
    table.insert(lsp.servers, 'ccls')
    table.insert(lsp.servers, 'julials')
    table.insert(lsp.servers, 'sumneko_lua')
end

M.on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { unique = false, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
    if vim.lsp.codelens and client.resolved_capabilities['code_lens'] then
        print'capable of code_lens :)'
        vim.cmd('au InsertLeave <buffer='..bufnr..'> lua vim.lsp.codelens.refresh()')
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ce", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
    end
end
    

M.lsp_lua_config = function()
    local lspconf = require'lspconfig'
    local hand = io.popen('readlink -f $(which lua-language-server)')
    local sumneko_binary = hand:read(); hand:close()
    local sumneko_root_path = sumneko_binary..'/../..'
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconf.sumneko_lua.setup {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        on_attach = require'my.plugins.lsp'.on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    }
end

return M
