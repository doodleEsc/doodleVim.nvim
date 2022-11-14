local H = {}
H.hydras = {}

H.add = function(key, value)
    H.hydras[key] = value
end

H.remove = function(key)
    H.hydras[key] = nil
end

H.contain = function(key)
    return H.hydras[key] ~= nil
end

H.run = function(key)
    if not H.contain(key) then
        vim.notify("No Such Hydra Factory: " .. key, vim.log.levels.ERROR)
        return
    end

    local hydra_factory = H.hydras[key]
    local hydra = hydra_factory()
    -- local ok, hydra = pcall(hydra_factory)
    -- if not ok then
    --     vim.notify("Generate Hydra " .. key .. " Failed", vim.log.levels.ERROR)
    --     return
    -- end

    hydra:activate()

    -- hydra_obj:activate()
    -- local ok, _ = pcall(function() hydra_obj:activate() end)
    -- if not ok then
    --     vim.notify("Call " .. key .. " Failed", vim.log.levels.ERROR)
    -- end
end

return H
