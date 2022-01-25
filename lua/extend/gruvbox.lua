local gruvbox = {}

gruvbox.dump = function()
	if (not packer_plugins['gruvbox.nvim'].loaded) then
		vim.cmd [[PackerLoad gruvbox.nvim]]
	end
	require("gruvbox").export_to_buffer()

end

return gruvbox
