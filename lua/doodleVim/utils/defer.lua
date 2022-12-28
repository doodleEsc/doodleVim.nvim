local M = {
    defer_packages = {},
    mod_plug_map = {},
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

function M.setup()

    _G.ensure_require = function(module)
        local major_mod = module:match("^([a-z0-9_-]+)%.?")
        if not M.mod_plug_map[major_mod] then
            return
        end

        local plugin = M.mod_plug_map[major_mod]
        local item = {plugins = plugin}
        require("lazy").load(item)

        local module_loaded_ok, module_loaded = pcall(require, module)
        if not module_loaded_ok then
            return
        end

        return module_loaded
    end
end

return M
