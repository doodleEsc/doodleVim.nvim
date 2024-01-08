local api = vim.api

local M = {
	fns = {},
	event_handlers = {},
}

M.register_post_install = function(name, fn)
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

local function emit_user_event(event)
	if type(event) == "string" then
		api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
	elseif type(event) == "function" then
		pcall(event)
	end
end

M.defer_emit_user_event = function(delay, events)
	vim.defer_fn(function()
		for _, event in ipairs(events) do
			emit_user_event(event)
		end
	end, delay)
end

M.register_defer_load = function(event, priority, label, fn)
	if M.event_handlers[event] == nil then
		M.event_handlers[event] = {}
	end
	table.insert(M.event_handlers[event], { priority = priority, f = fn, label = label })
end

M.start_event_handlers = function(event)
	if M.event_handlers[event] == nil then
		return
	end
	-- Sort the table in descending order of priority
	table.sort(M.event_handlers[event], function(a, b)
		return a.priority > b.priority
	end)
	-- Execute the functions in order
	for _, handler in ipairs(M.event_handlers[event]) do
		local ok, err = pcall(handler.f)
		if not ok then
			print("Error executing function for " .. handler.label .. ":" .. err)
		end
	end
end

M.show_event_handlers = function()
	print(vim.inspect(M.event_handlers))
end

M.register_defer_load_helper = function(event, priority, label, module)
	return function()
		if type(module) == "function" then
			require("doodleVim.extend.lazy").register_defer_load(event, priority, label, module)
		else
			require("doodleVim.extend.lazy").register_defer_load(event, priority, label, function()
				local ok, _ = pcall(require, module)
				if not ok then
					vim.notify(module .. " load failed", vim.log.levels.ERROR)
					return
				end
			end)
		end
	end
end

return M
