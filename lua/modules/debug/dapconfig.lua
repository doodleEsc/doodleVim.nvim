local dap = require "dap"
local go = require "modules.debug.go"

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

-- golang
dap.adapters.go = go.adapter
dap.configurations.go = go.configuration
