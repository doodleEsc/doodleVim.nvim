local debug = {}
local conf = require("modules.debug.config")

debug['mfussenegger/nvim-dap'] = {
	opt = true,
	setup = function() require("utils.defer").packer_defer_load("nvim-dap", 1000) end,
	config = conf.dap
}

debug['rcarriga/nvim-dap-ui'] = {
	after = "nvim-dap",
	config = conf.dapui
}

debug['theHamsta/nvim-dap-virtual-text'] = {
	after = "nvim-dap",
	config = function() vim.g.dap_virtual_text = true end
}

debug['Pocco81/DAPInstall.nvim'] = {
	opt = true,
	after = "nvim-dap",
	config = conf.dapinstall
}

return debug
