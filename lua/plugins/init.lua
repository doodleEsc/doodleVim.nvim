vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- base plugin
  use {'neoclide/coc.nvim', branch = 'release'}
end)
