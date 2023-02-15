local config = {}

function config.nui(plugin, opts)
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local UIInput = Input:extend("UIInput")

    local function get_label_text(label, default_label)
        local label_text = label or default_label
        if label_text:sub( -1) == ":" then
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
        local default_value = opts.default or ""
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

        vim.schedule(function()
            input_ui:mount()
        end)
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

function config.dressing(plugin, opts)
    require('dressing').setup({
        input = {
            -- Set to false to disable the vim.ui.input implementation
            enabled = true,

            -- Default prompt string
            default_prompt = "Input",

            -- Can be 'left', 'right', or 'center'
            prompt_align = "left",

            -- When true, <Esc> will close the modal
            insert_only = true,

            -- When true, input will start in insert mode.
            start_in_insert = true,

            -- These are passed to nvim_open_win
            anchor = "SW",
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "cursor",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            prefer_width = 20,
            width = nil,
            -- min_width and max_width can be a list of mixed types.
            -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
            max_width = { 140, 0.9 },
            min_width = { 10, 0.1 },

            buf_options = {},
            win_options = {
                -- Window transparency (0-100)
                winblend = 0,
                -- Disable line wrapping
                wrap = false,
            },

            -- Set to `false` to disable
            mappings = {
                n = {
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
                i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<Up>"] = "HistoryPrev",
                    ["<Down>"] = "HistoryNext",
                },
            },

            override = function(conf)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                return conf
            end,

            -- see :help dressing_get_config
            get_config = nil,
        },
        select = {
            -- Set to false to disable the vim.ui.select implementation
            enabled = true,

            -- Priority list of preferred vim.select implementations
            backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

            -- Trim trailing `:` from prompt
            trim_prompt = true,

            -- Options for telescope selector
            -- These are passed into the telescope picker directly. Can be used like:
            -- telescope = require('telescope.themes').get_ivy({...})
            telescope = nil,

            -- Options for fzf selector
            fzf = {
                window = {
                    width = 0.5,
                    height = 0.4,
                },
            },

            -- Options for fzf_lua selector
            fzf_lua = {
                winopts = {
                    width = 0.5,
                    height = 0.4,
                },
            },

            -- Options for nui Menu
            nui = {
                position = "50%",
                size = nil,
                relative = "editor",
                border = {
                    style = "rounded",
                },
                buf_options = {
                    swapfile = false,
                    filetype = "DressingSelect",
                },
                win_options = {
                    winblend = 10,
                },
                max_width = 80,
                max_height = 40,
                min_width = 40,
                min_height = 10,
            },

            -- Options for built-in selector
            builtin = {
                -- These are passed to nvim_open_win
                anchor = "NW",
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "editor",

                buf_options = {},
                win_options = {
                    -- Window transparency (0-100)
                    winblend = 10,
                },

                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- the min_ and max_ options can be a list of mixed types.
                -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                width = nil,
                max_width = { 140, 0.8 },
                min_width = { 40, 0.2 },
                height = nil,
                max_height = 0.9,
                min_height = { 10, 0.2 },

                -- Set to `false` to disable
                mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                },

                override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                end,
            },

            -- Used to override format_item. See :help dressing-format
            format_item_override = {
            },

            -- see :help dressing_get_config
            get_config = nil,
        },
    })

    local custom_kind = require("dressing.select.telescope").custom_kind
    local original_func = custom_kind["codeaction"]
    custom_kind["codeaction"] = function(opts, defaults, items)
        original_func(opts, defaults, items)
        defaults.initial_mode = "normal"
    end
end

return config
