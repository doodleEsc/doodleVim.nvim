local editor = {}
local conf = require("doodleVim.modules.editor.config")
local setup = require("doodleVim.modules.editor.setup")
local lazy = require("doodleVim.extend.lazy")

editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
	},
	init = setup.treesitter,
	config = conf.treesitter,
}

editor["romgrk/barbar.nvim"] = {
	lazy = true,
	event = { "BufReadPost" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.barbar,
}

editor["andymass/vim-matchup"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}

editor["junegunn/vim-easy-align"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
}

editor["kylechui/nvim-surround"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	config = conf.nvim_surround,
}

editor["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
	main = "ibl",
	event = { "User DeferBufReadPost" },
	config = conf.blankline,
}

editor["nvim-lualine/lualine.nvim"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "AndreM222/copilot-lualine",
	},
	config = conf.lualine,
}

-- editor["AndreM222/copilot-lualine"] = {
-- 	lazy = true,
-- }
--

editor["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	config = conf.gitsigns,
}

editor["numToStr/Comment.nvim"] = {
	lazy = true,
	config = conf.comment,
}

editor["phaazon/hop.nvim"] = {
	lazy = true,
	config = conf.hop,
}

editor["karb94/neoscroll.nvim"] = {
	lazy = true,
	config = conf.neoscroll,
}

editor["gorbit99/codewindow.nvim"] = {
	lazy = true,
	config = conf.codewindow,
}

editor["doodleEsc/rename.nvim"] = {
	lazy = true,
	dependencies = {
		"neovim/nvim-lspconfig",
		"stevearc/dressing.nvim",
	},
}

editor["utilyre/barbecue.nvim"] = {
	lazy = true,
	cmd = { "Barbecue" },
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.barbecue,
}

return editor
