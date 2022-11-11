local M = {}

M.new = function(dir)
    dir = dir or "<buffer>"
    vim.cmd("FloatermHide")
    vim.cmd("FloatermNew --cwd=" .. dir)
end

M.kill = function(all)
    all = all or false
    if all then
        vim.cmd("FloatermKill!")
        return
    end

    local term_count = vim.api.nvim_exec([[
        let buffers = floaterm#buflist#gather()
        echo len(buffers)
    ]], true)

    vim.cmd("FloatermKill")
    if tonumber(term_count) > 1 then
        vim.cmd("FloatermShow")
    end
end

return M
