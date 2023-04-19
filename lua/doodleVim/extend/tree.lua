local tree = {}

tree.toggle = function()
    if vim.bo.filetype == 'alpha' then
        return
    end
    local api = require('nvim-tree.api')
    api.tree.toggle()
end

tree.find_file = function()
    if vim.bo.filetype == 'alpha' then
        return
    end
    local view = require("nvim-tree.view")
    local api = require('nvim-tree.api')
    if view.is_visible() then
        api.tree.find_file(vim.fn.expand("%:p"))
    else
        api.tree.toggle(true, false)
    end
    api.tree.focus()
end

tree.on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end


    -- Default mappings not inserted as:
    --  remove_keymaps = true
    --  OR
    --  view.mappings.custom_only = true


    -- Mappings migrated from view.mappings.list
    --
    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'R', api.fs.rename_sub, opts('Rename: Omit Filename'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'yp', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', 'ya', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'C', api.tree.collapse_all, opts('Collapse'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', '/', api.tree.search_node, opts('Search'))
    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    vim.keymap.set('n', '<Tab>', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
end

return tree
