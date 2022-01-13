local M = {
    'p00f/cphelper.nvim',
    requires = 'nvim-lua/plenary.nvim',
}
function M.config()
    vim.g.cphdir = vim.loop.os_homedir() .. "/Code/Compet"
    vim.g.cpp_compile_command = 'g++ -Wall -Wextra -std=c++17 solution.cpp -o cpp.out'
end

return M
