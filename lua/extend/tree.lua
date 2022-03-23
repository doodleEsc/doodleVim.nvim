local tree = {}

tree.toggle = function()
	require('utils.defer').load_immediately({'nvim-tree.lua', 'barbar.nvim'})

	local view = require'nvim-tree.view'

	if view.is_visible() then
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
