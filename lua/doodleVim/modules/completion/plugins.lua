local completion = {}
local conf = require('doodleVim.modules.completion.config')

-- COMPLETION
completion['hrsh7th/nvim-cmp'] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("nvim-cmp", 50)
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

completion['octaltree/cmp-look'] = {
  after = 'nvim-cmp'
}

completion['hrsh7th/cmp-cmdline'] = {
  after = 'nvim-cmp'
}

completion['L3MON4D3/LuaSnip'] = {
  after = "nvim-cmp", config = conf.luasnip
}

completion['doodleEsc/friendly-snippets'] = {
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

completion['jose-elias-alvarez/null-ls.nvim'] = {
  after='nvim-lspconfig',
  config = conf.null_ls
}

completion['danymat/neogen'] = {
  after = {"nvim-cmp", "LuaSnip"},
  config = conf.neogen
}

completion['doodleEsc/rename.nvim'] = {
  after = {'nvim-lspconfig', 'nui.nvim'},
  config = conf.rename
}

return completion
