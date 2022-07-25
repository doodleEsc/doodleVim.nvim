local debug = {}
local conf = require("doodleVim.modules.debug.config")

debug['mfussenegger/nvim-dap'] = {
    opt = true,
    after = "mason.nvim",
    -- setup = function()
    --     require("doodleVim.utils.defer").defer_load("nvim-dap", 500)
    -- end,
    config = conf.dap
}

debug['rcarriga/nvim-dap-ui'] = {
    after = "nvim-dap",
    config = conf.dapui
}

return debug
