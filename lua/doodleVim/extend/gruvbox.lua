local gruvbox = {}

gruvbox.dump = function()
    require('doodleVim.utils.defer').immediate_load('gruvbox.nvim')
    require("gruvbox").export_to_buffer()

end

return gruvbox
