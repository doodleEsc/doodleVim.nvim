local M = {
    lazy = {},
    defer_packages = {},
    mod_plug_map = {},
}

local do_load = function()
    -- local lazy = require("lazy")
    local lazy_plugins = require("lazy").plugins()

    if not lazy_plugins then
        return
    end

    -- if not lazy_plugins['plenary.nvim'].loaded then
    --     M.lazy.load('plenary.nvim')
    -- end
    table.sort(M.defer_packages, function(a, b) return a.priority > b.priority end)
    for _, item in pairs(M.defer_packages) do
        M.lazy.load(item.plugin)
    end
end

function M.add(plugin, priority)
    local lazy_plugins = M.lazy.plugins()

    if not lazy_plugins then
        return
    end
    local p = {
        priority = priority,
        plugin = plugin,
    }
    table.insert(M.defer_packages, p)
end

function M.load(delay)
    local lazy_plugins = require("lazy").plugins()

    if not lazy_plugins then
        return
    end
    vim.defer_fn(do_load, delay)
end

function M.defer_load(plugin, timer)
    local lazy_plugins = M.lazy.plugins()

    if not lazy_plugins then
        return
    end
    if plugin then
        timer = timer or 0
        vim.defer_fn(function()
            M.lazy.load(plugin)
        end, timer)
    end
end

function M.immediate_load(plugins)
    local lazy_plugins = require("lazy").plugins()

    if not lazy_plugins then
        return
    end
    if type(plugins) == "string" then
        if not lazy_plugins[plugins].loaded then
            M.lazy.load(plugins)
        end
    elseif type(plugins) == "table" then
        for _, value in pairs(plugins) do
            if not lazy_plugins[value].loaded then
                M.lazy.load(value)
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

    M.lazy = require("lazy")

    _G.ensure_require = function(module)
        if not require("lazy").plugins then
            return
        end
        local ok, local_lazy = pcall(require, "lazy")
        if not ok then
            return
        end

        local major_mod = module:match("^([a-z0-9_-]+)%.?")
        if not require("doodleVim.utils.defer").mod_plug_map[major_mod] then
            return
        end

        local plugin = require("doodleVim.utils.defer").mod_plug_map[major_mod]
        if not require("lazy").plugins[plugin].loaded then
            local_lazy.load(plugin)
        end

        local module_loaded_ok, module_loaded = pcall(require, module)
        if not module_loaded_ok then
            return
        end

        return module_loaded
    end
end

return M
