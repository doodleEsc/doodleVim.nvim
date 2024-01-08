local lsp = {}
local conf = require("doodleVim.modules.lsp.config")
local setup = require("doodleVim.modules.lsp.setup")
local lazy = require("doodleVim.extend.lazy")

lsp["neovim/nvim-lspconfig"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 99, "nvim-lspconfig", function()
		local ok, _ = pcall(require, "lspconfig")
		if not ok then
			vim.notify("nvim-lspconfig load failed", vim.log.levels.ERROR)
			return
		end
		vim.cmd("LspStart")
	end),
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"mortepau/codicons.nvim",
		"utilyre/barbecue.nvim",
		{ "hrsh7th/cmp-nvim-lsp", lazy = true },
		{ "tamago324/nlsp-settings.nvim", config = conf.nlsp_settings, lazy = true },
	},
	opts = {
		servers = {
			jdtls = {
				disabled = true,
			},
			lua_ls = {
				capabilities = {
					textDocument = {
						formatting = false,
					},
				},
			},
		},
	},
	config = conf.lspconfig,
}

lsp["utilyre/barbecue.nvim"] = {
	lazy = true,
	event = { "BufReadPost" },
	config = conf.barbecue,
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
}

lsp["mfussenegger/nvim-jdtls"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 98, "nvim-jdtls", function()
		if vim.bo.filetype == "java" then
			local ok, _ = pcall(require, "jdtls")
			if not ok then
				vim.notify("nvim-jdtls load failed", vim.log.levels.ERROR)
				return
			end
		end
	end),
	config = conf.jdtls,
}

lsp["williamboman/mason.nvim"] = {
	lazy = true,
	init = setup.mason,
	config = conf.mason,
}

lsp["nvimtools/none-ls.nvim"] = {
	lazy = true,
	-- init = setup.null_ls,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 98, "none-ls.nvim", "null-ls"),
	dependencies = {
		"stevearc/dressing.nvim",
		"doodleEsc/gotools.nvim",
		{
			"jay-babu/mason-null-ls.nvim",
			cmd = { "NullLsInstall", "NullLsUninstall" },
			config = conf.mason_null_ls,
		},
	},
	config = conf.null_ls,
}

lsp["doodleEsc/rename.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 80, "rename.nvim", "rename"),
	dependencies = {
		"neovim/nvim-lspconfig",
		"stevearc/dressing.nvim",
	},
}

lsp["kosayoda/nvim-lightbulb"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStartWithFile", 80, "nvim-lightbulb", "nvim-lightbulb"),
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.lightbulb,
}

lsp["ray-x/lsp_signature.nvim"] = {
	lazy = true,
	init = setup.lsp_signature,
}

return lsp
