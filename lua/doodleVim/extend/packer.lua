local M = {}

M.fns = {}

M.add = function(name, fn)
    M.fns[name] = fn
end

M.PostPacker = function()
    for name, fn in pairs(M.fns) do
        -- local ok, _ = pcall(fn)
        -- if not ok then
        --     vim.notify("Function: '" .. name .. "' Runs Failed")
        -- end
        fn()
    end

    vim.cmd [[doautocmd User BinInstallDone]]
end

return M
