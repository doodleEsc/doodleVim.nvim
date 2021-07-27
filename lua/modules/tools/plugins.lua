local tools = {}
local conf = require('modules.tools.config')

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  config = conf.mkdp
}

tools['voldikss/vim-translator'] = {
	event = 'VimEnter'
}

return tools
