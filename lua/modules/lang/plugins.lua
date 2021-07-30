local lang = {}
local conf = require('modules.lang.config')

lang['nvim-treesitter/nvim-treesitter'] = {
  event = 'BufRead',
  --after = 'telescope.nvim',
  config = conf.nvim_treesitter,
}

lang['p00f/nvim-ts-rainbow'] = {
	after = 'nvim-treesitter'
}

return lang
