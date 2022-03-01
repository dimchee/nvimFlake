local M = {
    'neovim/nvim-lspconfig',
    cmd = 'LspStart',
	module = 'lspconfig',
}

local get_sumneko_cmd = function()
    local hand = io.popen('readlink -f $(which lua-language-server)')
    local sumneko_bin = hand:read(); hand:close()
    local sumneko_root = sumneko_bin..'/../..'
    return {sumneko_bin, "-E", sumneko_root .. "/main.lua"}
end
local get_lua_runtime_path = function()
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
end

M.servers = {
    hls = true,
    rust_analyzer = true,
    gopls = true,
    texlab = true,
    purescriptls = true,
    tsserver = true,
    rnix = true,
    bashls = true,
    elmls = true,
    html = true,
    pyright = true,
    zls = true,
    gdscript = true,
    ccls = {
        cmd = {'ccls', '--init={"clang":{"extraArgs": ["-std=c++17"]}}'}
    },
    julials = {
        root_dir = function(fname)
            return require'lspconfig/util'.find_git_ancestor(fname)
                or require'lspconfig/util'.path.dirname(fname)
        end,
    },
    sumneko_lua = {
        cmd = get_sumneko_cmd(),
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = get_lua_runtime_path(),
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
    },
}

M.config = function()
    --vim.lsp.set_log_level("debug") -- debugging
    local lspconf = require'lspconfig'
    local lsp = require'my.plugins.lsp'

    for s, conf in pairs(lsp.servers) do
        if type(conf) ~= "table" then
            conf = {}
        end
        conf = vim.tbl_deep_extend("force", {
            --on_init = custom_init,
            on_attach = lsp.on_attach,
            -- capabilities = lsp.capabilities, does not exist
        }, conf)
        lspconf[s].setup(conf)
    end
    --vim.lsp.codelens.display = lsp.codelens_display
end


M.ns_id = vim.api.nvim_create_namespace'my_codelens_display'
M.group_by_lines = function(lenses)
    local sol = {}
    for _, lens in ipairs(lenses) do
        local line = lens.range.start.line
        sol[line] = sol[line] or {}
        table.insert(sol[line], lens.command.title)
    end
    return sol
end

M.codelens_display = function(lenses, buf, _) -- client
    local lsp = require'my.plugins.lsp'
    vim.api.nvim_buf_clear_namespace(buf, lsp.ns_id, 0, -1)
    local id = 0
    for line, titles in pairs(lsp.group_by_lines(lenses)) do
        id = id + 1
        --print(table.concat(titles, ' | '))
        vim.api.nvim_buf_set_extmark(buf, lsp.ns_id, line, 0, {
            id = id,
            virt_lines = {{{table.concat(titles, ' | '), 'DiagnosticVirtualTextWarn'}}},
            virt_lines_above = true,
        })
    end
end


M.on_attach = function(client, buf)
    -- vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { unique = false, silent = true, buffer = buf }
    --vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Diagnostics
    vim.diagnostic.config { virtual_text = false }
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    --vim.keymap.set('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    if nil and vim.lsp.codelens and client.resolved_capabilities.code_lens then
        vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.run, opts)
        vim.cmd [[
            augroup lsp_document_codelens
                au! * <buffer>
                autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
                autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
            augroup END
        ]]
    end
end

return M
