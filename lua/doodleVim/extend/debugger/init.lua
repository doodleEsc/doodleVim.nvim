local debugger = {}

debugger.load_debuggers = function(opts)
    local dap = require('dap')
    for _, v in ipairs(opts) do
        local status_ok, d = pcall(require, "doodleVim.extend.debugger." .. v)
        if status_ok then
            d.setup(dap)
        end
    end
end

return debugger
