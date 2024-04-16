local base = {}
local conf = require("doodleVim.modules.base.config")

base["nvim-tree/nvim-web-devicons"] = {
	lazy = true,
	config = conf.nvim_web_devicons,
}

base["mortepau/codicons.nvim"] = { lazy = true }

base["nvim-lua/plenary.nvim"] = { lazy = true }

base["stevearc/dressing.nvim"] = {
	lazy = true,
	-- event = "User LazyVimStarted",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = conf.dressing,
}

-- base['nathom/filetype.nvim'] = {}

base["MunifTanjim/nui.nvim"] = {
	lazy = true,
}

base["rcarriga/nvim-notify"] = {
	lazy = true,
	-- event = "VeryLazy",
	event = "User LazyVimStarted",
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.notify,
}

base["NvChad/nvim-colorizer.lua"] = {
	lazy = true,
	ft = { "lua", "vim", "markdown" },
	config = conf.color,
}

base["nvim-neotest/nvim-nio"] = {
	lazy = true,
}

return base
