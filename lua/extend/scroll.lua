local scroll = {}

scroll.scroll_up = function()
	if (not packer_plugins['neoscroll.nvim'].loaded) then
		vim.cmd [[PackerLoad neoscroll.nvim]]
	end

	local neoscroll = require("neoscroll")
	neoscroll.scroll(-vim.wo.scroll, true, 150)
end

scroll.scroll_down = function()
	if (not packer_plugins['neoscroll.nvim'].loaded) then
		vim.cmd [[PackerLoad neoscroll.nvim]]
	end

	local neoscroll = require("neoscroll")
	neoscroll.scroll(vim.wo.scroll, true, 150)
end

return scroll
