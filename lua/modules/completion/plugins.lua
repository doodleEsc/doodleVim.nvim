local completion = {}
local conf = require('modules.completion.config')

-- COMPLETION
completion['hrsh7th/nvim-cmp'] = {
	opt = true,
	setup = function()
		require("utils.defer").packer_defer_load("nvim-cmp", 175)
	end,
	config = conf.nvim_cmp
}

 completion['hrsh7th/cmp-nvim-lsp'] = {
	after = "nvim-cmp"
 }

 completion['saadparwaiz1/cmp_luasnip'] = {
	after = "nvim-cmp"
 }

 completion['hrsh7th/cmp-buffer'] = {
	after = 'nvim-cmp'
 }

 completion['hrsh7th/cmp-path'] = {
	after = 'nvim-cmp'
 }

 completion['tzachar/cmp-tabnine'] = {
	after = 'nvim-cmp', run='./install.sh'
 }

 completion['L3MON4D3/LuaSnip'] = {
	after = "nvim-cmp", config = conf.luasnip
 }

 completion['rafamadriz/friendly-snippets'] = {
	 opt = true
 }

completion['neovim/nvim-lspconfig'] = {
	after = "nvim-cmp",
}

completion['ray-x/lsp_signature.nvim'] = {
	after = 'nvim-lspconfig',
}

completion['williamboman/nvim-lsp-installer'] = {
	after={'nvim-lspconfig', 'lsp_signature.nvim'},
	config = conf.nvim_lsp_installer
}

 return completion
