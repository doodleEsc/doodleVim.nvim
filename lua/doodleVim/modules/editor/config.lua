local config = {}

function config.comment()
    require('Comment').setup {
        padding = true,
        sticky = true,
        ignore = nil,
    }
end

function config.neoscroll()
    require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-f>', '<C-b>' },
        hide_cursor = false,         -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false
    })
end

function config.hop()
    require 'hop'.setup()
end

function config.nvim_surround()
    require("nvim-surround").setup({
        keymaps = {
            insert = "<C-y>s",
            insert_line = "<C-y>l",
            normal = "ys",
            normal_cur = "yss",
            normal_line = "yl",
            normal_cur_line = "yll",
            visual = "s",
            visual_line = "gl",
            delete = "ds",
            change = "cs",
        },
    })
end

function config.codewindow(plugin)
    require('codewindow').setup({
        active_in_terminals = false, -- Should the minimap activate for terminal buffers
        auto_enable = false,         -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
        exclude_filetypes = {
            "NvimTree",
            "Outline",
        },                        -- Choose certain filetypes to not show minimap on
        max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
        max_lines = nil,          -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
        minimap_width = 20,       -- The width of the text part of the minimap
        use_lsp = true,           -- Use the builtin LSP to show errors and warnings
        use_treesitter = true,    -- Use nvim-treesitter to highlight the code
        use_git = true,           -- Show small dots to indicate git additions and deletions
        width_multiplier = 4,     -- How many characters one dot represents
        z_index = 1,              -- The z-index the floating window will be on
        show_cursor = true,       -- Show the cursor position in the minimap
        window_border = 'single'  -- The border style of the floating window (accepts all usual options)
    })
end

return config
