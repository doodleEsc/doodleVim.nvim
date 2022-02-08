local debug = {}
local conf = require("modules.debug.config")

debug['mfussenegger/nvim-dap'] = {
	opt = true,
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

return debug
