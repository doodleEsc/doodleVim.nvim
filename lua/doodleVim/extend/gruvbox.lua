local gruvbox = {}

gruvbox.dump = function()
    require('doodleVim.utils.defer').load_immediately('gruvbox.nvim')
    require("gruvbox").export_to_buffer()

end

return gruvbox
