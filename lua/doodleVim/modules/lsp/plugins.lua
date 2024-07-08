local vim = vim
local lsp = {}
local conf = require("doodleVim.modules.lsp.config")
local setup = require("doodleVim.modules.lsp.setup")
local lazy = require("doodleVim.extend.lazy")

lsp["neovim/nvim-lspconfig"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 100, "nvim-lspconfig", function()
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
		"hrsh7th/cmp-nvim-lsp",
		"tamago324/nlsp-settings.nvim",
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

-- lsp["zbirenbaum/copilot.lua"] = {
-- 	lazy = true,
-- 	cmd = "Copilot",
-- 	config = conf.copilot,
-- }

lsp["williamboman/mason.nvim"] = {
	lazy = true,
	init = setup.mason,
	config = conf.mason,
	dependencies = {
		"stevearc/dressing.nvim",
	},
}

lsp["nvimtools/none-ls.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 100, "none-ls.nvim", "null-ls"),
	config = conf.null_ls,
}

lsp["jay-babu/mason-null-ls.nvim"] = {
	lazy = true,
	init = lazy.register_defer_load_helper("DeferStart", 99, "mason-null-ls.nvim", "mason-null-ls"),
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = conf.mason_null_ls,
}

lsp["tamago324/nlsp-settings.nvim"] = {
	lazy = true,
	cmd = { "LspSettings" },
	config = conf.nlsp_settings,
}

lsp["kosayoda/nvim-lightbulb"] = {
	lazy = true,
	event = { "User DeferBufReadPost" },
	dependencies = {
		"mortepau/codicons.nvim",
	},
	config = conf.lightbulb,
}

lsp["ray-x/lsp_signature.nvim"] = {
	lazy = true,
	init = setup.lsp_signature,
}

lsp["mfussenegger/nvim-jdtls"] = {
	lazy = true,
	ft = "java",
	config = conf.jdtls,
}

return lsp
