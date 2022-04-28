local config = {}

function config.dapui()
  require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
    },
    sidebar = {
      -- You can change the order of elements in the sidebar
      elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      { id = "scopes",size = 0.25 },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left", -- Can be "left", "right", "top", "bottom"
    },
    tray = {
      elements = { "repl" },
      size = 10,
      position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
    floating = {
      max_height = 0.4, -- These can be integers or a float between 0 and 1.
      max_width = 0.4, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
      close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  })

  local dap, dapui = require "dap", require "dapui"
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    -- vim.api.nvim_command("DapVirtualTextEnable")
    -- dapui.close("tray")
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    -- vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    -- vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
  end
  -- for some debug adapter, terminate or exit events will no fire, use disconnect reuest instead
  dap.listeners.before.disconnect["dapui_config"] = function()
    -- vim.api.nvim_command("DapVirtualTextDisable")
    dapui.close()
 end
end

function config.dap()
  vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text = '', texthl = '', linehl = '', numhl = ''})
  vim.fn.sign_define('DapBreakpointRejected', { text = '⭐️', texthl = '',linehl = '',numhl = ''})

  require("doodleVim.extend.debugger").load_debuggers({
    "go",
	"python"
  })

end

return config
