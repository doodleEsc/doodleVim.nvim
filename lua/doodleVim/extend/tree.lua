local tree = {}

tree.toggle = function()
    if vim.bo.filetype == 'alpha' then
        return
    end

    -- require('doodleVim.utils.defer').immediate_load({ 'barbar.nvim', 'nvim-tree.lua' })
    local api = require('nvim-tree.api')
    api.tree.toggle()
end

tree.find_file = function()
    if vim.bo.filetype == 'alpha' then
        return
    end

    -- require('doodleVim.utils.defer').immediate_load({ 'nvim-tree.lua' })
    local view = require("nvim-tree.view")
    local api = require('nvim-tree.api')
    if view.is_visible() then
        api.tree.find_file(vim.fn.expand("%:p"))
    else
        api.tree.toggle(true, false)
    end
    api.tree.focus()
end

return tree
