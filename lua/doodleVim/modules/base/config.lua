local config = {}

function config.nui(plugin, opts)
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

function config.color(plugin, opts)
    require('colorizer').setup()
end

function config.notify(plugin, opts)
    local icons = require("doodleVim.utils.icons")
    local nvim_notify = require("notify")
    nvim_notify.setup({
        -- Animation style (see below for details)
        stages = "slide",

        -- Function called when a new window is opened, use for changing win settings/config
        on_open = nil,

        -- Function called when a window is closed
        on_close = nil,

        -- Render function for notifications. See notify-render()
        render = "default",

        -- Default timeout for notifications
        timeout = 2000,

        -- Max number of columns for messages
        max_width = nil,
        -- Max number of lines for a message
        max_height = nil,

        -- For stages that change opacity this is treated as the highlight behind the window
        -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
        background_colour = "Normal",

        -- Minimum width for notification windows
        minimum_width = 36,

        -- Icons for the different levels
        icons = {
            ERROR = icons.diagnostics.error_sign,
            WARN = icons.diagnostics.warn_sign,
            INFO = icons.diagnostics.infor_sign,
            DEBUG = icons.diagnostics.debug_sign,
            TRACE = icons.diagnostics.trace_sign,
        },
    })
    vim.notify = require("doodleVim.extend.misc").wrapped_notify
end

function config.treesitter(plugin, opts)
    -- if plugin.after and #plugin.after > 0 then
    --     require("doodleVim.utils.defer").immediate_load(plugin.after)
    -- end
    --
    require('nvim-treesitter.configs').setup {
        sync_install = true,
        auto_install = false,
        highlight = {
            enable = true,
            disable = {
                "lua",
                "help",
            },
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

return config
