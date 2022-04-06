local gruvbox = {}

gruvbox.dump = function()
  -- if (not packer_plugins['gruvbox.nvim'].loaded) then
  --   vim.cmd [[PackerLoad gruvbox.nvim]]
  -- end
  require('doodleVim.utils.defer').load_immediately('gruvbox.nvim')
  require("gruvbox").export_to_buffer()

end

return gruvbox
