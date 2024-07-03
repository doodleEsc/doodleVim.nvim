local debug = {}

function debug.dap_python(plugin)
	require("doodleVim.extend.debug").register_worker("python", "nvim-dap-python")
end

function debug.persistent_breakpoints(plugin)
	require("doodleVim.extend.debug").register_worker("*", "persistent-breakpoints.nvim")
end

function debug.dap_go(plugin)
	require("doodleVim.extend.debug").register_worker("go", "nvim-dap-go")
end

return debug
