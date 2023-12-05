local api = vim.api
local vim = vim
local autocmd = {}

local UserDefinedEvent = {
    "DeferStart",
    function()
        if next(vim.fn.argv()) ~= nil then
            api.nvim_exec_autocmds("User", { pattern = "DeferStartWithFile", modeline = false })
        end
    end,
    function()
        pcall(require, "lspconfig")
        vim.cmd("LspStart")
    end
}

local function create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        if type(group_name) == "string" and group_name ~= "" then
            local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = group_name })
            if not exists then
                vim.api.nvim_create_augroup(group_name, { clear = true })
            end
        end

        for _, def in ipairs(definition) do
            local opts = def.opts
            opts.group = group_name
            api.nvim_create_autocmd(def.event, opts)
        end
    end
end

function autocmd.load_autocmds()
    local definitions = {
        _filetype_settings = {
            {
                event = "FileType",
                opts = {
                    pattern = "Outline",
                    command = "setlocal signcolumn=no",
                },
            },
            {
                event = "FileType",
                opts = {
                    pattern = "python",
                    command = "setlocal colorcolumn=80",
                },
            },
            {
                event = "FileType",
                opts = {
                    pattern = { "markdown", "gitcommit" },
                    command = "setlocal wrap",
                },
            },
            {
                event = "FileType",
                opts = {
                    pattern = { "markdown", "gitcommit" },
                    command = "setlocal spell",
                },
            },
            {
                event = "FileType",
                opts = {
                    pattern = "dap-repl",
                    command = "set nobuflisted",
                },
            },
            {
                event = "FileType",
                opts = {
                    pattern = { "lua" },
                    callback = function()
                        vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
                        vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
                        vim.opt_local.suffixesadd:prepend(".lua")
                        vim.opt_local.suffixesadd:prepend("init.lua")
                        for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
                            vim.opt_local.path:append(path .. "/lua")
                        end
                    end,
                },
            },
            {
                event = "FileType",
                opts = {
                    pattern = {
                        "qf",
                        "help",
                        "man",
                        "floaterm",
                        "lspinfo",
                        "lir",
                        "lsp-installer",
                        "null-ls-info",
                        "tsplayground",
                        "DressingSelect",
                        "Jaq",
                        "neoai-input",
                        "neoai-output",
                    },
                    callback = function()
                        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
                        vim.opt_local.buflisted = false
                    end,
                },
            },
        },

        _general_settings = {
            {
                event = "TextYankPost",
                opts = {
                    pattern = "*",
                    callback = function()
                        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
                    end,
                },
            },
            {
                event = "VimResized",
                opts = {
                    pattern = "*",
                    command = "tabdo wincmd =",
                },
            },
            {
                event = { "BufReadPost", "BufNewFile" },
                opts = {
                    pattern = "sol",
                    command = "setf solidity",
                    desc = "Set Solidity FileType",
                },
            },
        },

        _lazy = {
            {
                event = "User",
                opts = {
                    pattern = { "LazySync", "LazyUpdate" },
                    once = true,
                    callback = function()
                        require("doodleVim.extend.lazy").PostInstall()
                    end,
                },
            },
        },

        _defer_start = {
            {
                event = "UIEnter",
                opts = {
                    pattern = "*",
                    callback = function()
                        require("doodleVim.utils.defer").defer_emit_user_event(100, UserDefinedEvent)
                    end,
                },
            },
        },

        _file_opened = {
            {
                -- event = { "BufRead", "BufReadPost", "BufWinEnter", "BufNewFile" },
                event = "BufReadPost",
                opts = {
                    pattern = "*",
                    nested = true,
                    callback = function(args)
                        local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
                        if not (vim.fn.expand("%") == "" or buftype == "nofile") then
                            api.nvim_exec_autocmds("User", { pattern = "FileOpened", modeline = false })
                        end
                    end,
                },
            },
        },
    }

    create_augroups(definitions)
end

return autocmd
