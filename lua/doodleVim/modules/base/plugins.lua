local base = {}
local conf = require("doodleVim.modules.base.config")

base["ellisonleao/gruvbox.nvim"] = { lazy = true }

base["nvim-lua/plenary.nvim"] = { lazy = true }

base["nvim-neotest/nvim-nio"] = { lazy = true }

base["NvChad/nvim-colorizer.lua"] = {
	lazy = true,
	ft = { "lua", "vim", "markdown" },
	config = conf.color,
}

base["MunifTanjim/nui.nvim"] = {
	lazy = true,
}

base["nvim-tree/nvim-web-devicons"] = {
	lazy = true,
	config = conf.nvim_web_devicons,
}

base["mortepau/codicons.nvim"] = { lazy = true }

base["stevearc/dressing.nvim"] = {
	lazy = true,
	-- event = "User LazyVimStarted",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = conf.dressing,
}

return base
