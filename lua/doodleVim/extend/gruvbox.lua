local gruvbox = {}

local vim_path = require('doodleVim.core.global').vim_path
local colors_path = vim_path .. "/colors"

gruvbox.dump = function()
    -- require('doodleVim.utils.defer').immediate_load('gruvbox.nvim')
    local groups = require("gruvbox.groups").setup()
    local color_file_path = colors_path .. "/gruvbox.lua"


    if vim.fn.filereadable(color_file_path) == 1 then
        os.remove(color_file_path)
    end

    local file = io.open(color_file_path, "w")
    for group, settings in pairs(groups) do
        local line = "vim.api.nvim_set_hl(0,'" .. group .. "', " .. vim.inspect(settings) .. ")\n"
        if file ~= nil then
            file:write(line)
        else
            vim.notify("Can't open file " .. color_file_path .."'", vim.log.levels.ERROR)
            return
        end

    end

    if file ~= nil then
        file:close()
        return
    else
        vim.notify("Can't close file " .. color_file_path .."'", vim.log.levels.ERROR)
    end
end

return gruvbox
