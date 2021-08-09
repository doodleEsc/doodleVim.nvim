local debug = {}
local conf = require('modules.debug.config')

debug['mfussenegger/nvim-dap'] = {
	keys = {"<F5>"},
	config = conf.dap
}

debug['rcarriga/nvim-dap-ui'] = {
	after = "nvim-dap"
}

return debug
