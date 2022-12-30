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
        hide_cursor = false, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false
    })
end

function config.barbar()
    local icons = require("doodleVim.utils.icons")
    vim.g.bufferline = {
        -- Enable/disable animations
        animation = true,

        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = true,

        -- Enable/disable current/total tabpages indicator (top right corner)
        tabpages = true,

        -- Enable/disable close button
        closable = true,

        -- Enables/disable clickable tabs
        --  - left-click: go to buffer
        --  - middle-click: delete buffer
        clickable = true,

        -- Excludes buffers from the tabline
        exclude_ft = {
            'alpha',
            'dap-repl',
        },
        exclude_name = {
            'alpha',
        },

        -- Enable/disable icons
        -- if set to 'numbers', will show buffer index in the tabline
        -- if set to 'both', will show buffer index and icons in the tabline
        icons = true,

        -- If set, the icon color will follow its corresponding buffer
        -- highlight group. By default, the Buffer*Icon group is linked to the
        -- Buffer* group (see Highlighting below). Otherwise, it will take its
        -- default value as defined by devicons.
        icon_custom_colors = false,

        -- Configure icons on the bufferline.
        icon_separator_active = icons.misc.line_sep,
        icon_separator_inactive = icons.misc.line_sep,
        icon_close_tab = icons.misc.close,
        icon_close_tab_modified = icons.misc.circle_dot,
        icon_pinned = icons.misc.pin,

        -- If true, new buffers will be inserted at the end of the list.
        -- Default is to insert after current buffer.
        insert_at_end = false,
        insert_at_start = false,

        -- Sets the maximum padding width with which to surround each tab
        maximum_padding = 1,

        -- Sets the maximum buffer name length.
        maximum_length = 30,

        -- If set, the letters for each buffer in buffer-pick mode will be
        -- assigned based on their name. Otherwise or in case all letters are
        -- already assigned, the behavior is to assign letters in order of
        -- usability (see order below)
        semantic_letters = true,

        -- New buffer letters are assigned in this order. This order is
        -- optimal for the qwerty keyboard layout but might need adjustement
        -- for other layouts.
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

        -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
        -- where X is the buffer number. But only a static string is accepted here.
        no_name_title = nil,
    }
end

function config.hop()
    require 'hop'.setup()
end

function config.blankline()
    require("indent_blankline").setup {
        show_end_of_line = true,
    }
end

function config.mkdnflow()
    -- ** DEFAULT SETTINGS; TO USE THESE, PASS NO ARGUMENTS TO THE SETUP FUNCTION **
    require('mkdnflow').setup({
        modules = {
            bib = true,
            buffers = true,
            conceal = true,
            cursor = true,
            folds = true,
            links = true,
            lists = true,
            maps = true,
            paths = true,
            tables = true
        },
        filetypes = { md = true, rmd = true, markdown = true },
        create_dirs = true,
        perspective = {
            priority = 'first',
            fallback = 'current',
            root_tell = false,
            nvim_wd_heel = true
        },
        wrap = false,
        bib = {
            default_path = nil,
            find_in_root = true
        },
        silent = false,
        links = {
            style = 'markdown',
            name_is_source = false,
            conceal = false,
            implicit_extension = nil,
            transform_implicit = false,
            transform_explicit = function(text)
                text = text:gsub(" ", "-")
                text = text:lower()
                text = os.date('%Y-%m-%d_') .. text
                return (text)
            end
        },
        to_do = {
            symbols = { ' ', '-', 'X' },
            update_parents = true,
            not_started = ' ',
            in_progress = '-',
            complete = 'X'
        },
        tables = {
            trim_whitespace = true,
            format_on_move = true,
            auto_extend_rows = false,
            auto_extend_cols = false
        },
        mappings = {
            MkdnEnter = { { 'n', 'v' }, '<CR>' },
            MkdnTab = false,
            MkdnSTab = false,
            MkdnNextLink = { 'n', '<Tab>' },
            MkdnPrevLink = { 'n', '<S-Tab>' },
            MkdnNextHeading = { 'n', ']]' },
            MkdnPrevHeading = { 'n', '[[' },
            MkdnGoBack = { 'n', '<BS>' },
            MkdnGoForward = { 'n', '<Del>' },
            MkdnFollowLink = false, -- see MkdnEnter
            MkdnDestroyLink = { 'n', '<M-CR>' },
            MkdnTagSpan = { 'v', '<M-CR>' },
            MkdnMoveSource = { 'n', '<F2>' },
            MkdnYankAnchorLink = { 'n', 'ya' },
            MkdnYankFileAnchorLink = { 'n', 'yfa' },
            MkdnIncreaseHeading = { 'n', '+' },
            MkdnDecreaseHeading = { 'n', '-' },
            MkdnToggleToDo = { { 'n', 'v' }, '<Space><Space>' },
            MkdnNewListItem = false,
            MkdnNewListItemBelowInsert = { 'n', 'o' },
            MkdnNewListItemAboveInsert = { 'n', 'O' },
            MkdnExtendList = false,
            MkdnUpdateNumbering = false,
            MkdnTableNextCell = { 'i', '<Tab>' },
            MkdnTablePrevCell = { 'i', '<S-Tab>' },
            MkdnTableNextRow = false,
            MkdnTablePrevRow = false,
            MkdnTableNewRowBelow = { 'n', '<leader>ie' },
            MkdnTableNewRowAbove = { 'n', '<leader>ir' },
            MkdnTableNewColAfter = { 'n', '<leader>ic' },
            MkdnTableNewColBefore = { 'n', '<leader>iv' },
            MkdnFoldSection = false,
            MkdnUnfoldSection = false
        }
    })
end

function config.gitsigns()
    local gitsigns = require('gitsigns')
    gitsigns.setup {
        signs                        = {
            add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        },
        signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil, -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'rounded',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm                         = {
            enable = false
        },
    }
end

function config.lualine()
    require('doodleVim.modules.editor.lualine')
end

function config.alpha()
    require("doodleVim.modules.editor.alpha")
end

return config
