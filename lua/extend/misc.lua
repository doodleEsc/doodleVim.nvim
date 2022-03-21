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
	vim.cmd[[confirm qa]]
end

misc.safe_save = function()
	if not packer_plugins['auto-session'].loaded then
		vim.cmd [[PackerLoad auto-session]]
	end
	vim.cmd[[write]]
	require("auto-session").SaveSession()
end

return misc
