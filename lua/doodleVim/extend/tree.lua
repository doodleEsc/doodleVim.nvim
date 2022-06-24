local tree = {}

tree.toggle = function()
    require('doodleVim.utils.defer').immediate_load('barbar.nvim')
    local view = ensure_require('nvim-tree.view')

    if view.is_visible() then
        require('bufferline.state').set_offset(0)
        view.close()
    else
        require('bufferline.state').set_offset(31, 'File Explorer')
        if vim.bo.filetype == "" then
            ensure_require('nvim-tree').open()
        else
            ensure_require('nvim-tree').find_file(true)
        end
    end
end

return tree
