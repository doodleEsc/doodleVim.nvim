local H = {}
H.factories = {}
H.hydras = {}

H.add = function(key, value)
    H.factories[key] = value
end

H.remove = function(key)
    H.factories[key] = nil
end

H.contain = function(key)
    return H.factories[key] ~= nil
end

H.run = function(key)
    if not H.contain(key) then
        vim.notify("No Such Hydra Factory: " .. key, vim.log.levels.ERROR)
        return
    end

    local hydra, ok = nil, false
    if H.hydras[key] ~= nil then
        hydra = H.hydras[key]
    else
        local hydra_factory = H.factories[key]
        ok, hydra = pcall(hydra_factory)
        if not ok then
            vim.notify("Generate Hydra " .. key .. " Failed", vim.log.levels.ERROR)
            return
        end
        H.hydras[key] = hydra
    end

    local ok2, _ = pcall(function() hydra:activate() end)
    if not ok2 then
        vim.notify("Call " .. key .. " Failed", vim.log.levels.ERROR)
    end
end

return H
