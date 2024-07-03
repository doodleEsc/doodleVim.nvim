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
		"folke/todo-comments.nvim",
		"AckslD/nvim-neoclip.lua",
		{
			"doodleEsc/project.nvim",
			lazy = true,
			init = lazy.register_defer_load_helper("DeferStart", 80, "project.nvim", "project_nvim"),
			dependencies = { "rmagatti/auto-session", lazy = true, config = conf.autosession },
			config = conf.project,
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = conf.telescope,
}

tools["AckslD/nvim-neoclip.lua"] = {
	lazy = true,
	dependencies = { "kkharji/sqlite.lua", lazy = true },
	config = conf.neoclip,
}

tools["kyazdani42/nvim-tree.lua"] = {
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

tools["simrat39/symbols-outline.nvim"] = {
	lazy = true,
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.symbols_outline,
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
	init = lazy.register_defer_load_helper("DeferStart", 80, "which-key.nvim", "which-key"),
	config = conf.which_key,
}

tools["aserowy/tmux.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 80, "tmux.nvim", "tmux"),
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
	init = lazy.register_defer_load_helper("DeferStartWithFile", 80, "nvim-ufo", "ufo"),
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

return tools
