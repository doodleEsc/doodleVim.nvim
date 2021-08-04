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
	event = 'VimEnter'
}

-- tools['mfussenegger/nvim-dap'] = {
-- 	keys = {"<F5>"},
-- 	opt = true
-- 
-- }

return tools
