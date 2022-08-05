local tree = {}

tree.toggle = function()
    require('doodleVim.utils.defer').immediate_load({ 'barbar.nvim', 'nvim-tree.lua' })
    local api = require('nvim-tree.api')
    api.tree.toggle()
    -- local view = require('nvim-tree.view')
    -- local api = require('nvim-tree.api')
    --
    -- if view.is_visible() then
    --     require('bufferline.state').set_offset(0)
    --     api.tree.close()
    -- else
    --     require('bufferline.state').set_offset(30, 'File Explorer')
    --     api.tree.open()
    -- end
end

return tree
