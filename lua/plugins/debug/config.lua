local config = {}

function config.dap()
	require('plugins.debug.dapconfig')
end

function config.dapui()
	require("dapui").setup()
end

return config
