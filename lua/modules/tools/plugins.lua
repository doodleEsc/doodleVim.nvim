local tools = {}
local conf = require("modules.tools.config")

tools['dstein64/vim-startuptime'] = {
	cmd = 'StartupTime'
}

tools['nvim-telescope/telescope.nvim'] = {
	opt = true,
	setup = function() require("utils.defer").add("telescope.nvim", 80) end,
	config = conf.telescope,
	requires = {
		{'nvim-telescope/telescope-fzy-native.nvim', opt = true},
		{'nvim-telescope/telescope-file-browser.nvim', opt = true},
	}
}

tools['kyazdani42/nvim-tree.lua'] = {
	opt = true,
	config = conf.nvim_tree,
	requires = 'kyazdani42/nvim-web-devicons'
}

tools['iamcco/markdown-preview.nvim'] = {
	ft = 'markdown',
	setup = conf.mkdp,
	run = function() vim.cmd [[:call mkdp#util#install()]] end,
}

tools['simrat39/symbols-outline.nvim'] = {
	opt = true,
	setup = function()
		require("modules.tools.config").symbols_outline()
		require("utils.defer").packer_defer_load("symbols-outline.nvim", 500)
	end
}

tools['voldikss/vim-floaterm'] = {
	opt = true,
	setup = function()
		require("modules.tools.config").floaterm()
		require("utils.defer").packer_defer_load("vim-floaterm", 500)
	end
}

tools['voldikss/vim-translator'] = {
	cmd = {'TranslateW'},
	setup = conf.translator()
}

tools['jbyuki/venn.nvim'] = {
	cmd = {'VBox', 'VFill'}
}

tools['TovarishFin/vim-solidity'] = {
	ft = 'solidity'
}

tools['towolf/vim-helm'] = {
	ft='helm'
}

tools['nvim-lua/plenary.nvim'] = {}

tools['kyazdani42/nvim-web-devicons'] = {}

-- tools['bfredl/nvim-luadev'] = {}

tools['cinuor/gotests.nvim'] = {
	opt = true,
	ft = 'go',
	setup = function()
		if vim.bo.filetype == 'go' then
			require("utils.defer").packer_defer_load("gotests.nvim", 1000)
		end
	end
}

tools["cinuor/project.nvim"] = {
	opt = true,
	setup = function() require("utils.defer").add("project.nvim", 90) end,
	config = conf.project
}

tools['rmagatti/auto-session'] = {
	opt = true,
	setup = function()
		require("utils.defer").add("auto-session", 70)
	end,
	config = conf.autosession
}

tools['cinuor/which-key.nvim'] = {
	opt = true,
	setup = function() require("utils.defer").packer_defer_load("which-key.nvim", 100) end,
	config = conf.which_key
}

return tools
