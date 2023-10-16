local vim = vim
local gruvbox = require("doodleVim.extend.gruvbox")
local misc = require("doodleVim.extend.misc")
local floaterm = require("doodleVim.extend.floaterm")
local tree = require("doodleVim.extend.tree")

local M = {}

local function create_command(commands)
    for _, cmd in ipairs(commands) do
        if #cmd == 2 then
            vim.api.nvim_create_user_command(cmd[1], cmd[2], {})
        elseif #cmd == 3 then
            vim.api.nvim_create_user_command(cmd[1], cmd[2], cmd[3])
        end
    end
end

function M.load_user_command()
    local commands = {
        { "GruvboxDump",  gruvbox.dump },
        { "ReloadConfig", misc.reload },
        { "OpenTree",     tree.toggle },
        {
            "Lazygit",
            function()
                floaterm.run("lazygit", { title = "lazygit", name = "lazygit" })
            end,
        },
        {
            "PyDepInstall",
            function()
                vim.cmd("PylspInstall python-lsp-black pyls-isort python-lsp-ruff pylsp-rope")
            end,
        },
    }
    create_command(commands)
end

return M
