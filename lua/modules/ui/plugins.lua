local ui = {}
local conf = require("modules.ui.config")


ui['nvim-treesitter/nvim-treesitter'] = {
	opt = true,
	setup = function() require("utils.defer").packer_defer_load("nvim-treesitter", 100) end,
	config = conf.treesitter,
	requires = {'nvim-treesitter/nvim-treesitter-textobjects', opt = true},
	run = ':TSUpdate'
}

ui['norcalli/nvim-colorizer.lua'] = {
	ft={"lua", "vim", "markdown"},
	config = function() require('colorizer').setup() end
}

ui['nvim-lualine/lualine.nvim'] = {
	opt = true,
	setup = function() require("utils.defer").packer_defer_load("lualine.nvim", 100) end,
	requires = {'kyazdani42/nvim-web-devicons'},
	config = conf.lualine,
}

ui['cinuor/gruvbox.nvim'] = {
	opt = true
}

ui['lukas-reineke/indent-blankline.nvim'] = {
	opt = true,
	setup = function() require("utils.defer").add("indent-blankline.nvim", 90) end,
	config = conf.blankline,
}

ui['cinuor/lsp-action.nvim'] = {
	after = "nvim-lspconfig",
	config = conf.lspaction
}

return ui
