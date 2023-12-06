local ui = {}
local conf = require("doodleVim.modules.ui.config")
local setup = require("doodleVim.modules.ui.setup")
local lazy = require("doodleVim.extend.lazy")

ui["ellisonleao/gruvbox.nvim"] = {
	lazy = true,
}

ui["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	cmd = { "TSUpdate", "TSInstall", "TSUninstall" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
	},
	init = setup.treesitter,
	config = conf.treesitter,
}

ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	config = conf.alpha,
}

ui["nvim-lualine/lualine.nvim"] = {
	lazy = true,
	-- init = lazy.register_defer_load_helper("DeferStart", 100, "lualine.nvim", "lualine"),
	event = { "BufReadPost" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = conf.lualine,
}

ui["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 100, "gitsigns.nvim", "gitsigns"),
	config = conf.gitsigns,
}

ui["romgrk/barbar.nvim"] = {
	lazy = true,
	-- init = lazy.register_defer_load_helper("DeferStartWithFile", 100, "barbar.nvim", "barbar"),
	event = { "BufReadPost" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.barbar,
}

ui["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 100, "indent-blankline.nvim", "ibl"),
	config = conf.blankline,
}

ui["folke/todo-comments.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 100, "todo-comments.nvim", "todo-comments"),
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.todo,
}

return ui
