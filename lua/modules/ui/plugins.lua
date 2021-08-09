local ui = {}
local conf = require('modules.ui.config')

ui['cinuor/monokai.nvim'] = {
	config = function()
		vim.cmd[[colorscheme monokai_pro]]
	end
}

ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen'},
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons'
}


ui['norcalli/nvim-colorizer.lua'] = {
	config = function()
		require('colorizer').setup()
	end
}

return ui
