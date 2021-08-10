vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- base plugin
  use {'neoclide/coc.nvim', branch = 'release'}
  use {'dstein64/vim-startuptime'}
end)
