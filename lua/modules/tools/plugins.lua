local tools = {}
local conf = require('modules.tools.config')

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  run = function()
	  vim.cmd [[:call mkdp#util#install()]]
  end,
  config = conf.mkdp
}

tools['voldikss/vim-translator'] = {
	event = 'GUIEnter'
}

tools['dstein64/vim-startuptime'] = {
  cmd = {'StartupTime'}
}

tools['voldikss/vim-floaterm'] = {
	cmd = {'FloatermToggle', 'FloatermNew'},
	config = conf.floaterm
}

return tools
