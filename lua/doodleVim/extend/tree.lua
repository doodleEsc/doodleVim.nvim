local tree = {}

tree.toggle = function()
    if vim.bo.filetype == 'alpha' then
        return
    end

    require('doodleVim.utils.defer').immediate_load({ 'barbar.nvim', 'nvim-tree.lua' })
    local api = require('nvim-tree.api')
    api.tree.toggle()
end

return tree
