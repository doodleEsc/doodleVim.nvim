local coc = {}

coc.on_enter = function()
	if not packer_plugins['coc.nvim'].loaded then
		vim.cmd [[PackerLoad coc.nvim]]
	end
	vim.cmd [[call coc#on_enter()]]
end

coc.toggle_word = function()
	if not packer_plugins['coc.nvim'].loaded then
		vim.cmd [[PackerLoad coc.nvim]]
	end
	local word_config = vim.call("coc#util#get_config", "coc.source.word")
	if word_config.enable then
		vim.call("coc#config", "coc.source.word.enable", false)
		vim.g.enable_coc_word = false
	else
		vim.call("coc#config", "coc.source.word.enable", true)
		vim.g.enable_coc_word = true
	end
end

return coc
