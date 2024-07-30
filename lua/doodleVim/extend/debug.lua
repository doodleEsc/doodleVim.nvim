local M = {}
local defer = require("doodleVim.utils.defer")

M.workersMap = {}
M.testDebugFns = {}

function M.register_worker(ft, worker)
	if M.workersMap[ft] == nil then
		M.workersMap[ft] = { worker }
	end
	table.insert(M.workersMap[ft], worker)
end

function M.load_worker()
	local fts = { "*" }
	table.insert(fts, vim.bo.filetype)
	for _, ft in ipairs(fts) do
		if M.workersMap[ft] ~= nil then
			local workers = M.workersMap[ft]
			for _, worker in ipairs(workers) do
				require("doodleVim.utils.defer").optimisticLoad(worker)
			end
		end
	end
end

function M.register_test_fn_debug(ft, fn)
	if M.testDebugFns[ft] == nil then
		M.testDebugFns[ft] = fn
	end
end

function M.debug_test()
	local ft = vim.bo.filetype
	local fn = M.testDebugFns[ft]
	if fn ~= nil and type(fn) == "function" then
		pcall(fn)
		return
	end
	vim.notify("No Test Debug Function Found For FileType: " .. ft, vim.log.levels.WARN)
end

function M.wrapped_command(cmd)
	require("doodleVim.utils.defer").optimisticLoad("nvim-dap")
	vim.defer_fn(function()
		vim.cmd(cmd)
	end, 100)
end

return M
