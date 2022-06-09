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

local do_load = function()
    if not packer_plugins['plenary.nvim'].loaded then
        require("packer").loader('plenary.nvim')
    end
    table.sort(M.defer_packages, function(a, b) return a.priority > b.priority end)
    for _, item in pairs(M.defer_packages) do
        require("packer").loader(item.plugin)
    end
end

function M.load(delay)
    vim.defer_fn(do_load, delay)
end

function M.packer_defer_load(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function()
            require("packer").loader(plugin)
        end, timer)
    end
end

function M.load_immediately(plugins)
    if type(plugins) == "string" then
        if not packer_plugins[plugins].loaded then
            require("packer").loader(plugins)
        end
    elseif type(plugins) == "table" then
        for _, value in pairs(plugins) do
            if not packer_plugins[value].loaded then
                require("packer").loader(value)
            end
        end
    end
end

function M.register(module, plugin)
    if not M.mod_plug_map[module] then
        M.mod_plug_map[module] = plugin
    end
end

return M
