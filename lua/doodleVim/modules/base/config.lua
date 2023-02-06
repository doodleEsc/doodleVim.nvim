local config = {}

function config.nui(plugin, opts)
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local UIInput = Input:extend("UIInput")

    local function get_label_text(label, default_label)
        local label_text = label or default_label
        if label_text:sub(-1) == ":" then
            label_text = "[" .. label_text:sub(1, -2) .. "]"
        end
        return label_text
    end

    -- local opts = {
    --     label = "border_top_text",
    --     prompt = ">",
    --     default = "box default value",
    -- }

    function UIInput:init(opts, on_done)
        local border_top_text = get_label_text(opts.label, "[Input]")
        local default_value = tostring(opts.default)
        local prompt = opts.prompt or "➤ " 

        UIInput.super.init(self, {
            relative = "cursor",
            position = {
                row = 1,
                col = 0,
            },
            size = {
                -- minimum width 20
                width = math.max(20, vim.api.nvim_strwidth(default_value)),
            },
            border = {
                style = "rounded",
                text = {
                    top = border_top_text,
                    top_align = "left",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
        }, {
            prompt = prompt,
            default_value = default_value,
            on_close = function()
                on_done(nil)
            end,
            on_submit = function(value)
                on_done(value)
            end,
        })

        -- cancel operation if cursor leaves input
        self:on(event.BufLeave, function()
            on_done(nil)
        end, { once = true })

        -- cancel operation if <Esc> is pressed
        self:map("n", "<Esc>", function()
            on_done(nil)
        end, { noremap = true, nowait = true })

        self:map("i", "<Esc>", function()
            on_done(nil)
        end, { noremap = true, nowait = true })

        self:map("n", "<C-c>", function()
            on_done(nil)
        end, { noremap = true, nowait = true })

        self:map("i", "<C-c>", function()
            on_done(nil)
        end, { noremap = true, nowait = true })
    end

    local input_ui
    vim.ui.input = function(opts, on_confirm)
        assert(type(on_confirm) == "function", "missing on_confirm function")

        if input_ui then
            -- ensure single ui.input operation
            vim.api.nvim_err_writeln("busy: another input is pending!")
            return
        end

        input_ui = UIInput(opts, function(value)
            if input_ui then
                -- if it's still mounted, unmount it
                input_ui:unmount()
            end
            -- pass the input value
            on_confirm(value)
            -- indicate the operation is done
            input_ui = nil
        end)

        input_ui:mount()
    end
end

function config.color(plugin, opts)
    require('colorizer').setup()
end

function config.notify(plugin, opts)
    local codicons = require("codicons")
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
            ERROR = codicons.get("error"),
            WARN = codicons.get("warning"),
            INFO = codicons.get("info"),
            DEBUG = codicons.get("debug"),
            TRACE = codicons.get("search"),
        },
    })
    vim.notify = require("doodleVim.extend.misc").wrapped_notify
end

return config
