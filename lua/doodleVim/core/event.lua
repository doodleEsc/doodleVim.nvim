local api = vim.api
local autocmd = {}

local function create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        local group = api.nvim_create_augroup(group_name, { clear = true })
        for _, def in ipairs(definition) do
            local opts = def.opts
            opts.group = group
            api.nvim_create_autocmd(def.event, opts)
        end
    end
end

function autocmd.load_autocmds()
    local definitions = {
        ft = {
            {
                event = { "BufReadPost,BufNewFile" },
                opts = {
                    pattern = "*.sol",
                    command = "setf solidity",
                    desc = "Set Solidity FileType",
                }

            },
            {
                event = "FileType",
                opts = {
                    pattern = "Outline",
                    command = "setlocal signcolumn=no",
                }
            },
            {
                event = "FileType",
                opts = {
                    pattern = "python",
                    command = "setlocal colorcolumn=80",
                }
            },
            {
                event = "FileType",
                opts = {
                    pattern = { "qf", "help", "man", "lspinfo" },
                    command = "nnoremap <silent> <buffer> q :close<CR>",
                }
            },
            {
                event = "FileType",
                opts = {
                    pattern = { "markdown", "gitcommit" },
                    command = "setlocal wrap",
                }
            },
            {
                event = "FileType",
                opts = {
                    pattern = { "markdown", "gitcommit" },
                    command = "setlocal spell",
                }
            },
        },

        _general_settings = {
            {
                event = "TextYankPost",
                opts = {
                    pattern = "*",
                    callback = function()
                        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
                    end,
                }

            },
            {
                event = "VimResized",
                opts = {
                    pattern = "*",
                    command = "tabdo wincmd ="
                }
            }
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
                }

            },
        },

        _defer_start = {
            {
                event = "VimEnter",
                opts = {
                    pattern = "*",
                    callback = function()
                        require('doodleVim.utils.defer').defer_emit_user_event(150)
                    end
                }
            },
        },
    }

    create_augroups(definitions)
end

return autocmd
