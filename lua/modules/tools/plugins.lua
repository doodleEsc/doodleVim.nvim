local tools = {}
local conf = require('modules.tools.config')

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  config = conf.mkdp
--  config = function ()
--    vim.g.mkdp_auto_start = 0
--  end
}

return tools
