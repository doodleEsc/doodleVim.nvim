local debug = {}
local conf = require("modules.debug.config")

debug['mfussenegger/nvim-dap'] = {
  opt = true,
  setup = function()
    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
    require("utils.defer").packer_defer_load("nvim-dap", 1000)
  end,
}

debug['rcarriga/nvim-dap-ui'] = {
  after = "nvim-dap",
  config = conf.dapui
}

debug['Pocco81/DAPInstall.nvim'] = {
  after = "nvim-dap",
  config = conf.dapinstall
}

return debug
