local config = {}

function config.dap()
	vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
end

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
end

function config.dapinstall()
	local dap_install = require("dap-install")
	dap_install.setup({
		installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	})

	dap_install.config("go_delve", {})
	dap_install.config("python", {})
end

return config
