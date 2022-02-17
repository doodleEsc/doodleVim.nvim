local tree = {}

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
