local M = {
    defer_packages = {},
    mod_plug_map = {},
}

function M.add(plugin, priority)
    local p = {
        priority = priority,
        plugin = plugin,
    }
    table.insert(M.defer_packages, p)
end

function M.load(delay)
    table.sort(M.defer_packages, function(a, b) return a.priority > b.priority end)
    vim.defer_fn(function()
        for _, item in ipairs(M.defer_packages) do
            if not packer_plugins[item.plugin].loaded then
                require("packer").loader(item.plugin)
            end
        end
    end, delay)
end

function M.defer_load(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function()
            if not packer_plugins[plugin].loaded then
                require("packer").loader(plugin)
            end
        end, timer)
    end
end

function M.immediate_load(plugins)
    if type(plugins) == "string" then
        if not packer_plugins[plugins].loaded then
            require("packer").loader(plugins)
        end
    elseif type(plugins) == "table" then
        for _, plugin in ipairs(plugins) do
            if not packer_plugins[plugin].loaded then
                require("packer").loader(plugin)
            end
        end
    end
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
        if not packer_plugins[plugin].loaded then
            require("packer").loader(plugin)
        end

        local module_loaded_ok, module_loaded = pcall(require, module)
        if not module_loaded_ok then
            return
        end

        return module_loaded
    end
end

return M
