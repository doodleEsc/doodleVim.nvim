local debugger = {}

debugger.load_debuggers = function(opts)
    -- INFO: Make sure nvim-lsp-installer loaded, case we need dap binary
    -- installed in lsp_servers
    require('doodleVim.utils.defer').immediate_load('nvim-lsp-installer')
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
