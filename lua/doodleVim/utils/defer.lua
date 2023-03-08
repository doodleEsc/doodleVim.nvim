local api = vim.api

local M = {
    defer_packages = {},
    mod_plug_map = {},
}

local UserDefinedEvent = {
    "DeferStart",
    function()
        if next(vim.fn.argv()) ~= nil then
            api.nvim_exec_autocmds("User", { pattern = "DeferStartWithFile", modeline = false })
        end
    end,
}

local do_load = function()
    table.sort(M.defer_packages, function(a, b) return a.priority > b.priority end)
    for _, item in pairs(M.defer_packages) do
        require("lazy").load(item)
    end
end

function M.add(plugins, priority)
    local p = {
        priority = priority,
        plugins = plugins,
    }
    table.insert(M.defer_packages, p)
end

function M.load(delay)
    vim.defer_fn(do_load, delay)
end

function M.defer_load(plugins, delay)
    if plugins then
        delay = delay or 0
        vim.defer_fn(function()
            local item = { plugins = plugins }
            require("lazy").load(item)
        end, delay)
    end
end

function M.immediate_load(plugins)
    local item = { plugins = plugins }
    require("lazy").load(item)
end

function M.register(module, plugin)
    if not M.mod_plug_map[module] then
        M.mod_plug_map[module] = plugin
    end
end

function M.emit_user_event(delay)
    vim.defer_fn(function()
        for _, event in ipairs(UserDefinedEvent) do
            if type(event) == "string" then
                api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
            elseif type(event) == "function" then
                pcall(event)
            end
        end
    end, delay)
end

function M.optimisticLoad(plugins)
    plugins = type(plugins) == "string" and { plugins } or plugins
    for _, plugin in ipairs(plugins) do
        if not require("lazy.core.config").plugins[plugin]._.loaded then
            require("lazy").load({ plugins = plugin })
        end
    end
end

return M
