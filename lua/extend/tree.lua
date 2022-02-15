local tree = {}

-- tree.toggle = function()
-- 	if (not packer_plugins['barbar.nvim'].loaded) or (not packer_plugins['nvim-tree.lua'].loaded) then
-- 		vim.cmd [[PackerLoad barbar.nvim]]
-- 		vim.cmd [[PackerLoad nvim-tree.lua]]
-- 	end
--
-- 	local ntree = require'nvim-tree'
-- 	local view = require'nvim-tree.view'
-- 	local lib = require'nvim-tree.lib'
--
-- 	if view.win_open() then
-- 		require'bufferline.state'.set_offset(0)
-- 		view.close()
-- 	else
-- 		if vim.g.nvim_tree_follow == 1 then
-- 			require'bufferline.state'.set_offset(31, 'File Explorer')
-- 			ntree.find_file(true)
-- 		end
-- 		if not view.win_open() then
-- 			require'bufferline.state'.set_offset(31, 'File Explorer')
-- 			lib.open()
-- 		end
-- 	end
-- end

tree.toggle = function()
	if (not packer_plugins['barbar.nvim'].loaded) or (not packer_plugins['nvim-tree.lua'].loaded) then
		vim.cmd [[PackerLoad barbar.nvim]]
		vim.cmd [[PackerLoad nvim-tree.lua]]
	end

	local view = require'nvim-tree.view'

	if view.is_visible() then
	  -- require'nvim-tree.view'.close()
	  require'bufferline.state'.set_offset(0)
	  view.close()
	else
	  require'bufferline.state'.set_offset(31, 'File Explorer')
	  if vim.bo.filetype == "" then
		require'nvim-tree'.open()
	  else
		require'nvim-tree'.find_file(true)
	  end
	end
end

return tree
