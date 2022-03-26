local debugger = {}

debugger.load_debuggers = function(opts)
  require('utils.defer').load_immediately('nvim-dap')
  local dap = require('dap')
  for _, v in ipairs(opts) do
	local status_ok, d = pcall(require, "extend.debugger." .. v)
	if status_ok then
		dap.adapters[v] = d.adapters
		dap.configurations[v] = d.configurations
	end
  end
end


return debugger
