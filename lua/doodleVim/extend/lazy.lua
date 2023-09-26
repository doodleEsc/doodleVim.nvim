local M = {}

M.fns = {}

M.add = function(name, fn)
	M.fns[name] = fn
end

M.PostInstall = function()
	for name, fn in pairs(M.fns) do
		local ok, _ = pcall(fn)
		if not ok then
			vim.notify("Function: '" .. name .. "' Runs Failed")
		end
		-- fn()
	end
	vim.api.nvim_exec_autocmds("User", { pattern = "BinInstallDone", modeline = false })
end

M.loaded = function(plugin)
	return require("lazy.core.config").plugins[plugin]._.loaded
end

return M
