local extend = {}

extend.TreeToggle = function()
	if (not packer_plugins['barbar.nvim'].loaded) or (not packer_plugins['nvim-tree.lua'].loaded) then
      vim.cmd [[packadd barbar.nvim]]
	  vim.cmd [[packadd nvim-tree.lua]]
    end

	local tree = require'nvim-tree'
	local view = require'nvim-tree.view'
	local lib = require'nvim-tree.lib'

	if view.win_open() then
		require'bufferline.state'.set_offset(0)
		view.close()
	else
		if vim.g.nvim_tree_follow == 1 then
			require'bufferline.state'.set_offset(31, 'File Explorer')
			tree.find_files(true)
		end
		if not view.win_open() then
			require'bufferline.state'.set_offset(31, 'File Explorer')
			lib.open()
		end
	end
end

extend.debug_toggle = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[PackerLoad nvim-dap]]
		require("plugins.debug.config").dap()
	end
	require'dap'.toggle_breakpoint()
end

extend.debug_continue = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[PackerLoad nvim-dap]]
		require("plugins.debug.config").dap()
	end
	vim.cmd [[echo "debug continue"]]
	require'dap'.continue()
end

extend.debug_step_over = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.step_over()
end

extend.debug_step_into = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.step_into()
end

extend.debug_step_out = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.step_out()
end

extend.debug_set_cond_breakpoint = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

extend.debug_repl_open = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.repl.open()
end

extend.debug_run_last = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.run_last()
end

extend.debug_pause = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.pause()
end

extend.debug_stop = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.disconnect()
	require'dap'.close()
end

extend.debug_run_to_cursor = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.run_to_cursor()
end

extend.debug_restart = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.cmd [[echo "'nvim-dap' not loaded"]]
		return
	end
	require'dap'.restart()
end

return extend
