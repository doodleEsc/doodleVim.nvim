local misc = {}

misc.safe_exit = function()
	require('utils.defer').load_immediately({'vim-floaterm', 'nvim-tree.lua'})

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
	require('utils.defer').load_immediately('auto-session')
	vim.cmd[[write]]
	require("auto-session").SaveSession()
end

return misc
