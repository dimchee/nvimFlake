function StartElmEnv()
    vim.fn.jobstart {"elm-live", "src/Main.elm", "--", "--debug"}
    require'prochrome'.newapp'http://localhost:8000'
end

function RefreshOrStartElmEnv()
    if require'prochrome'.job_id then
        require'prochrome'.refresh()
    else StartElmEnv() end
end

vim.keymap.set('n', '<C-a>', '<cmd>lua RefreshOrStartElmEnv()<cr>', { silent=true })
--vim.keymap.set('n', '<C-r>', '<cmd>lua require"prochrome".refresh()<cr>', { silent=true })
