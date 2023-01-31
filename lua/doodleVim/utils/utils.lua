local M = {}

local function splitWords(Lines, limit)
    while #Lines[#Lines] > limit do
        Lines[#Lines + 1] = Lines[#Lines]:sub(limit + 1)
        Lines[#Lines - 1] = Lines[#Lines - 1]:sub(1, limit)
    end
end

M.wrap = function(str, limit)
    local Lines, here, limit, found = {}, 1, limit or 72, str:find("(%s+)()(%S+)()")

    if found then
        Lines[1] = string.sub(str, 1, found - 1)
    else
        Lines[1] = str
    end
    str:gsub("(%s+)()(%S+)()",
        function(sp, st, word, fi)
            splitWords(Lines, limit)
            if fi - here > limit then
                here = st
                Lines[#Lines + 1] = word
            else
                Lines[#Lines] = Lines[#Lines] .. " " .. word
            end
        end)
    splitWords(Lines, limit)
    return Lines
end

M.wrap2 = function(str, limit)
    local limit = limit or 36
    local here = 1
    local wrapped_msg = "" .. str:gsub("(%s+)()(%S+)()",
        function(sp, st, word, fi)
            if fi - here > limit then
                here = st
                return "\n" .. word
            end
        end)
    return wrapped_msg
end

M.remove_cached_package = function(module)
    for name, _ in pairs(package.loaded) do
        if name:match(module) then
            package.loaded[name] = nil
        end
    end
end

M.feedkeys = function(key, mode)
    if not key:match('<[A-Za-z0-9\\%-%[%]%^@]->', 1) then
        vim.notify(string.format("Unsupported Key: %s, See Invalid Keys With Command :help keycodes", key),
            vim.log.levels.ERROR)
        return
    end

    local feedkey = vim.api.nvim_replace_termcodes(key, true, false, true)
    vim.api.nvim_feedkeys(feedkey, mode, false)
end

M.ts_is_installed = function(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
end

function M.contains(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

return M
