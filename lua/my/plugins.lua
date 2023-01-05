local function packer()
	local ok, mod = pcall(require, 'packer')
	if ok then return mod end
	local install_path = vim.fn.stdpath'data' .. '/site/pack/packer/start/packer.nvim'
	local packer_url = 'https://github.com/wbthomason/packer.nvim'
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		if vim.fn.input'Install packer? (y for yes)' ~= 'y' then return end
		vim.fn.system {'git', 'clone', '--depth', '1', packer_url, install_path}
	end
	ok, packer = pcall(require, 'packer')
	if ok then return packer
	else return {
		startup = function()
			print'There is something wrong with packer :P'
		end
	} end
end


packer().startup(function(use)
	use 'wbthomason/packer.nvim'
	for _, mod in ipairs(vim.api.nvim_get_runtime_file('lua/my/plugins/*.lua', true)) do
		local ok, m = pcall(loadfile(mod))
		if type(m) == 'table' and ok then use(m)
		elseif type(m) == 'string' then print('Can\'t load file '..mod..' error: '..m)
		else print'WTF' end
	end
	-- Until resolved https://github.com/neovim/neovim/issues/12103
	use 'lambdalisue/suda.vim'
	-- Until prolog gets proper support
	use 'adimit/prolog.vim'
	-- use_rocks 'luafun/luafun'
end)
-- https://github.com/j-hui/fidget.nvim
