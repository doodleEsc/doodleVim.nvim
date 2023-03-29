local tools = {}

function tools.dap_python(plugin)
    require("doodleVim.extend.debug").register_worker("python", "nvim-dap-python")
end

function tools.persistent_breakpoints(plugin)
    require("doodleVim.extend.debug").register_worker("*", "persistent-breakpoints.nvim")
end

function tools.dap_go(plugin)
    require("doodleVim.extend.debug").register_worker("go", "nvim-dap-go")
end

return tools
