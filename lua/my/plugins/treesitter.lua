local M = { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

function M.config()
    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.markdown = {
        install_info = {
            url = "https://github.com/ikatyang/tree-sitter-markdown",
            files = {"src/parser.c", "src/scanner.cc"}
        },
        filetype = "markdown",
    }
end

return M
