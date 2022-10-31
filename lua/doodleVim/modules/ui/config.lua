local config = {}

function config.lualine()
    require('doodleVim.modules.ui.lualine_config')
end

function config.treesitter()
    require('doodleVim.utils.defer').immediate_load('nvim-treesitter-textobjects')
    require('nvim-treesitter.configs').setup {
        sync_install = true,
        auto_install = false,
        highlight = {
            enable = true
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["as"] = "@statement.outer",
                    ["ah"] = "@call.outer",
                    ["ih"] = "@call.inner",
                },
            },
        },
    }
end

function config.alpha()
    require("doodleVim.modules.ui.alpha")
end

function config.nui()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event
    local default_size = 20

    local popup_options = {
        relative = "cursor",
        position = {
            row = 1,
            col = 0,
        },
        border = {
            style = "rounded",
            text = {
                top = "Input",
                top_align = "left",
            }
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
    }

    local custom_input = function(opts, on_confirm)
        -- local opts = {
        --     prompt = "",
        --     default = "",
        --     completion = "",
        --     label = "",
        -- }
        popup_options.border.text.top = opts and opts.label or "Input"
        popup_options.size = default_size

        local default_opts = {
            prompt = opts and opts.prompt or "➤ ",
            on_submit = function(value)
                local ok, _ = pcall(on_confirm, value)
                if not ok then
                    vim.notify("Failed to run function", vim.log.levels.ERROR)
                end
            end
        }

        if opts and opts.default then
            default_opts.default_value = opts.default

            local width = default_size + #opts.default
            if width > vim.o.columns - 10 then
                width = vim.o.columns - 10
            end
            popup_options.size = width
        end

        print(vim.inspect(popup_options))

        local input = Input(popup_options, default_opts)
        input:map("i", "<Esc>", input.input_props.on_close, { noremap = true })
        input:map("i", "<C-c>", input.input_props.on_close, { noremap = true })
        input:mount()
        input:on(event.BufLeave, function()
            input:unmount()
        end)
    end
    vim.ui.input = custom_input
end

return config
