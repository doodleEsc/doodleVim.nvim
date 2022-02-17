local scroll = {}

scroll.scroll_up = function()
	if (not packer_plugins['neoscroll.nvim'].loaded) or (not packer_plugins['lsp-action.nvim'].loaded) then
		vim.cmd [[PackerLoad neoscroll.nvim]]
		vim.cmd [[PackerLoad lsp-action.nvim]]
	end

	local hover = require("lspaction.hover")
	local action = require("lspaction.action")
	local neoscroll = require("neoscroll")

	if hover.has_saga_hover() then 
		action.smart_scroll_with_saga(-1)
	else
		neoscroll.scroll(-vim.wo.scroll, true, 250)
	end
end

scroll.scroll_down = function()
	if (not packer_plugins['neoscroll.nvim'].loaded) or (not packer_plugins['lsp-action.nvim'].loaded) then
		vim.cmd [[PackerLoad neoscroll.nvim]]
		vim.cmd [[PackerLoad lsp-action.nvim]]
	end

	local hover = require("lspaction.hover")
	local action = require("lspaction.action")
	local neoscroll = require("neoscroll")

	if hover.has_saga_hover() then 
		action.smart_scroll_with_saga(1)
	else
		neoscroll.scroll(vim.wo.scroll, true, 250)
	end
end

return scroll
