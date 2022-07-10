local debugger = {}

debugger.load_debuggers = function(opts)
    require('doodleVim.utils.defer').immediate_load('nvim-dap')
    local dap = require('dap')
    for _, v in ipairs(opts) do
        local status_ok, d = pcall(require, "doodleVim.extend.debugger." .. v)
        if status_ok then
            d.setup(dap)
        end
    end
end

debugger.DapToggleBreakpoint = function()
    require('doodleVim.utils.defer').immediate_load('nvim-dap')
    vim.api.nvim_command("DapToggleBreakpoint")
end


return debugger
