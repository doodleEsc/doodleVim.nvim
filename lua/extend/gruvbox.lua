local gruvbox = {}

gruvbox.dump = function()
	if (not packer_plugins['lush.nvim'].loaded) then
		vim.cmd [[PackerLoad lush.nvim]]
	end

	if (not packer_plugins['gruvbox.nvim'].loaded) then
		vim.cmd [[PackerLoad gruvbox.nvim]]
	end
	require('lush').export_to_buffer(require("gruvbox"))

end

return gruvbox
