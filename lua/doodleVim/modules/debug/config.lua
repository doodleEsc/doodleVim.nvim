local config = {}

function config.dap()
	local codicons = require("codicons")

	-- setup sign
	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = codicons.get("debug-breakpoint"), texthl = "GruvboxRedSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = codicons.get("debug-breakpoint-conditional"), texthl = "GruvboxRedSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = codicons.get("debug-breakpoint-unsupported"), texthl = "GruvboxRedSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = codicons.get("debug-breakpoint-log"), texthl = "GruvboxYellowSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapStopped",
		{ text = codicons.get("debug-continue"), texthl = "GruvboxYellowSign", linehl = "", numhl = "" }
	)

	-- setup dapui
	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.close()
	end
	-- for some debug adapter, terminate or exit events will no fire, use disconnect request instead
	dap.listeners.before.disconnect["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.close()
	end

	-- setup adapter
	require("doodleVim.extend.debug").load_worker()
end

function config.dap_python(plugin, opts)
	local debugpy_home = require("mason-core.path").package_prefix("debugpy")
	local python_venv_bin = debugpy_home .. "/venv/bin/python"
	require("dap-python").setup(python_venv_bin)

	for _, pyconfig in pairs(require("dap").configurations.python) do
		pyconfig.console = "internalConsole"
	end

	require("doodleVim.extend.debug").register_test_fn_debug("python", function()
		vim.ui.select({ "Method", "Class", "Selection" }, {
			prompt = "Select Test Type",
			format_item = function(item)
				return " " .. item
			end,
		}, function(choice)
			if choice == "Method" then
				require("dap-python").test_method()
			elseif choice == "Class" then
				require("dap-python").test_class()
			else
				require("dap-python").debug_selection()
			end
		end)
	end)
end

function config.dap_go(plugin, opts)
	require("dap-go").setup()
	for _, goconfig in pairs(require("dap").configurations.go) do
		goconfig.console = "internalConsole"
	end
	require("doodleVim.extend.debug").register_test_fn_debug("go", function()
		vim.ui.select({ "Nearest", "Recent" }, {
			prompt = "Select Test Type",
			format_item = function(item)
				return " " .. item
			end,
		}, function(choice)
			if choice == "Nearest" then
				require("dap-go").debug_test()
			elseif choice == "Recent" then
				require("dap-go").debug_last_test()
			end
		end)
	end)
end

function config.breakpoints(plugin, opts)
	require("persistent-breakpoints").setup({
		save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
		-- when to load the breakpoints? "BufReadPost" is recommended.
		load_breakpoints_event = { "BufReadPost" },
		-- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
		perf_record = false,
	})
end

return config
