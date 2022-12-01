local config = {}

function config.dapui()
    local icons = require("doodleVim.utils.icons")
    require("dapui").setup({
        icons = { expanded = icons.arrow.down, collapsed = icons.arrow.right },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t"
        },
        expand_lines = vim.fn.has("nvim-0.7"),
        layouts = {
            {
                elements = {
                    -- Elements can be strings or table with id and size keys.
                    { id = "scopes", size = 0.25 },
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                size = 40,
                position = "left",
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom",
            },
        },
        controls = {
            -- Requires Neovim nightly (or 0.8 when released)
            enabled = true,
            -- Display controls in this element
            element = "repl",
            icons = {
                pause = " ",
                play = "契",
                step_into = " ",
                step_over = " ",
                step_out = " ",
                step_back = "玲",
                run_last = "↻ ",
                terminate = "栗",
            },
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "rounded", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100
        }
    })

    local dap, dapui = require "dap", require "dapui"
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
    -- for some debug adapter, terminate or exit events will no fire, use disconnect reuest instead
    dap.listeners.before.disconnect["dapui_config"] = function()
        dapui.close()
    end
end

function config.dap()
    local icons = require("doodleVim.utils.icons")

    require("doodleVim.extend.debugger").load_debuggers({
        "go",
        "python"
    })

    vim.fn.sign_define('DapBreakpoint',
        { text = icons.dap.breakpoint, texthl = 'GruvboxRedSign', linehl = '', numhl = '' })
    vim.fn.sign_define("DapBreakpointCondition",
        { text = icons.dap.breakpoint_condition, texthl = "GruvboxRedSign", linehl = "", numhl = "" })
    vim.fn.sign_define('DapBreakpointRejected',
        { text = icons.dap.breakpoint_rejected, texthl = "GruvboxRedSign", linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint',
        { text = icons.dap.log_point, texthl = 'GruvboxYellowSign', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = icons.dap.stopped, texthl = 'GruvboxYellowSign', linehl = '', numhl = '' })
end

return config
