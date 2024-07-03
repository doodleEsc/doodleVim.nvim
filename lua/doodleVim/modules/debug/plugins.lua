local debug = {}
local conf = require("doodleVim.modules.debug.config")
local setup = require("doodleVim.modules.debug.setup")
local lazy = require("doodleVim.extend.lazy")

debug["rcarriga/nvim-dap-ui"] = {
	lazy = true,
	init = function()
		vim.g.dapui_setup = false
	end,
	dependencies = {
		"nvim-neotest/nvim-nio",
	},
}

debug["leoluz/nvim-dap-go"] = {
	lazy = true,
	init = setup.dap_go,
	config = conf.dap_go,
}

debug["mfussenegger/nvim-dap-python"] = {
	lazy = true,
	init = setup.dap_python,
	config = conf.dap_python,
}

debug["mfussenegger/nvim-dap"] = {
	lazy = true,
	event = { "User StartDebug" },
	dependencies = {
		"mortepau/codicons.nvim",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
	},
	config = conf.dap,
}

debug["Weissle/persistent-breakpoints.nvim"] = {
	lazy = true,
	event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
	init = setup.persistent_breakpoints,
	config = conf.breakpoints,
}

return debug
