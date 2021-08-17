local coc = {}

coc.on_enter = function()
	if not packer_plugins['coc.nvim'].loaded then
		vim.cmd [[PackerLoad coc.nvim]]
	end
	vim.cmd [[call coc#on_enter()]]
end

return coc
