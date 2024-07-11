local vim = vim
local tools = {}
local global = require("doodleVim.core.global")
local conf = require("doodleVim.modules.tools.config")
local lazy = require("doodleVim.extend.lazy")

tools["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = { "Telescope" },
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		"LukasPietzschmann/telescope-tabs",
		"AckslD/nvim-neoclip.lua",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = conf.telescope,
}

tools["doodleEsc/project.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 100, "project.nvim", "project_nvim"),
	dependencies = {
		"rmagatti/auto-session",
		"nvim-telescope/telescope.nvim",
	},
	config = conf.project,
}

tools["rmagatti/auto-session"] = {
	lazy = true,
	config = conf.autosession,
}

tools["AckslD/nvim-neoclip.lua"] = {
	lazy = true,
	dependencies = { "kkharji/sqlite.lua", lazy = true },
	config = conf.neoclip,
}

tools["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	dependencies = {
		"romgrk/barbar.nvim",
		"mortepau/codicons.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.nvim_tree,
}

tools["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	init = conf.mkdp,
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}

tools["hedyhli/outline.nvim"] = {
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	config = conf.outline,
}

tools["voldikss/vim-floaterm"] = {
	cmd = {
		"FloatermNew",
		"FloatermToggle",
	},
	init = function()
		require("doodleVim.modules.tools.config").floaterm()
	end,
}

tools["anuvyklack/hydra.nvim"] = {
	lazy = true,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"lewis6991/gitsigns.nvim",
		{ "jbyuki/venn.nvim", lazy = true },
	},
	config = conf.hydra,
}

tools["towolf/vim-helm"] = {
	lazy = true,
	ft = { "helm", "yaml" },
}

tools["folke/which-key.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 100, "which-key.nvim", "which-key"),
	config = conf.which_key,
}

tools["aserowy/tmux.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 100, "tmux.nvim", "tmux"),
	config = conf.tmux,
}

tools["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen" },
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.diffview,
}

tools["dstein64/vim-startuptime"] = {
	cmd = "StartupTime",
	init = function()
		vim.g.startuptime_tries = 10
	end,
}

tools["kevinhwang91/nvim-ufo"] = {
	lazy = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		{ "kevinhwang91/promise-async", lazy = true },
	},
	config = conf.nvim_ufo,
}

tools["LunarVim/bigfile.nvim"] = {
	config = conf.bigfile,
}

tools["doodleEsc/neoai.nvim"] = {
	lazy = true,
	cmd = {
		"NeoAI",
		"NeoAIOpen",
		"NeoAIClose",
		"NeoAIToggle",
		"NeoAIContext",
		"NeoAIContextOpen",
		"NeoAIContextClose",
		"NeoAIInject",
		"NeoAIInjectCode",
		"NeoAIInjectContext",
		"NeoAIInjectContextCode",
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = conf.neoai,
}

tools["keaising/im-select.nvim"] = {
	cond = global.is_mac,
	config = conf.im_select,
}

tools["rcarriga/nvim-notify"] = {
	lazy = true,
	event = { "User LazyVimStarted" },
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.notify,
}

tools["folke/todo-comments.nvim"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.todo,
}

return tools
