local dap = require "dap"
local go = require "modules.debug.go"

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

-- if not packer_plugins['DAPInstall.nvim'].loaded then
--   vim.cmd [[PackerLoad DAPInstall.nvim]]
-- end

-- local dap_install = require("dap-install")
-- dap_install.setup({
-- 	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- })
--
-- dap_install.config("go_delve", {})

-- -- golang
-- dap.adapters.go = go.adapter
-- dap.configurations.go = go.configuration
