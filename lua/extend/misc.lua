local misc = {}

misc.safe_exit = function()
	if (not packer_plugins['vim-floaterm'].loaded) or (not packer_plugins['nvim-tree.lua'].loaded) then
		vim.cmd [[PackerLoad vim-floaterm]]
		vim.cmd [[PackerLoad nvim-tree.lua]]
	end

	-- close floaterm
	local floatermBufnr = vim.call("floaterm#buflist#gather")
	if #floatermBufnr ~= 0 then
		vim.cmd[[FloatermKill]]
	end

	-- close nvim-tree
	local view = require'nvim-tree.view'
	if view.is_visible() then
		require('extend.tree').toggle()
	end

	-- quit
	vim.cmd[[confirm xa]]
end

misc.safe_save = function()
	vim.cmd[[write]]
	vim.cmd[[SaveSession]]
end

return misc
