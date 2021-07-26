local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
  event = 'BufReadPre',
  config = conf.nvim_lsp,
}

completion['glepnir/lspsaga.nvim'] = {
  cmd = 'Lspsaga',
}

completion['hrsh7th/nvim-compe'] = {
  event = 'InsertEnter',
  config = conf.nvim_compe,
}

completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf.vim_vsnip,
  requires = 'hrsh7th/vim-vsnip-integ'
}

completion['rafamadriz/friendly-snippets'] = {
	after = "vim-vsnip"
}

completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-lua/plenary.nvim',opt = true},
    {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
  }
}

completion['glepnir/smartinput.nvim'] = {
  ft = 'go',
  config = conf.smart_input
}

completion['tzachar/compe-tabnine'] = {
	run = "./install.sh",
	after = "nvim-compe"
}

--completion['mattn/vim-sonictemplate'] = {
--  cmd = 'Template',
--  ft = {'go','python','rust','markdown'},
--  config = conf.vim_sonictemplate,
--}

return completion
