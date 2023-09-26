local M = {}

M.enhanced = function(cmd)
    local api = require("nvim-tree.api")
    if api.tree.is_tree_buf() then
        vim.cmd("wincmd l")
    end
    vim.cmd(cmd)
end

return M
