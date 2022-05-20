local config = {}

function config.todo()
    local icons = require("doodleVim.utils.icons")
    require("todo-comments").setup {
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
            FIX = {
                icon = icons.todo.fix, -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = {
                    "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR",
                }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = icons.todo.todo, color = "info" },
            HACK = { icon = icons.todo.hack, color = "warning" },
            WARN = { icon = icons.todo.warn, color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = icons.todo.perf, color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = icons.todo.note, color = "hint", alt = { "INFO" } },
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
            before = "", -- "fg" or "bg" or empty
            keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)\v(\s+\(.*\)|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
            -- pattern = [[.*<(KEYWORDS)\v(\s|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
            error = { "#fb4934" },
            hack = {"#fe8019"},
            warning = { "#fabd2f" },
            info = { "#458588" },
            hint = { "#10B981" },
            default = { "#7C3AED" },
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS)(\s+\(.*\)|:)+]], -- ripgrep regex
        },
    }
end

function config.comment()
    require('Comment').setup {
        padding = true,
        sticky = true,
        ignore = nil,
    }
end

function config.autopairs()
    require('doodleVim.utils.defer').load_immediately('nvim-cmp')

    local cmp = require("cmp")
    require('nvim-autopairs').setup {}
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
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
        exclude_name = {},

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
        icon_separator_active = '│',
        icon_separator_inactive = '│',
        icon_close_tab = '',
        icon_close_tab_modified = '●',
        icon_pinned = '車',

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

function config.gitsigns()
    require('gitsigns').setup {
        signs                        = {
            add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            interval = 2000,
            follow_files = true
        },
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 100,
            ignore_whitespace = false,
        },
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    }
end

function config.blankline()
    require("indent_blankline").setup {
        show_end_of_line = true,
    }
end

function config.mkdnflow()
    -- ** DEFAULT SETTINGS; TO USE THESE, PASS AN EMPTY TABLE TO THE SETUP FUNCTION **
    require('mkdnflow').setup({
        filetypes = { md = true, rmd = true, markdown = true },
        create_dirs = true,
        perspective = {
            priority = 'first',
            fallback = 'current',
            root_tell = false
        },
        wrap = false,
        default_bib_path = '',
        silent = false,
        use_mappings_table = true,
        mappings = {
            MkdnNextLink = { 'n', '<Tab>' },
            MkdnPrevLink = { 'n', '<S-Tab>' },
            MkdnNextHeading = { 'n', ']' },
            MkdnPrevHeading = { 'n', '[' },
            MkdnGoBack = { 'n', '\\' },
            MkdnGoForward = { 'n', '<BS>' },
            MkdnFollowLink = { { 'n', 'v' }, '<CR>' },
            MkdnDestroyLink = { 'n', '<M-CR>' },
            MkdnYankAnchorLink = { 'n', 'ma' },
            MkdnYankFileAnchorLink = { 'n', 'mfa' },
            MkdnIncreaseHeading = { 'n', '=' },
            MkdnDecreaseHeading = { 'n', '-' },
            MkdnToggleToDo = { 'n', '<C-t>' },
            MkdnNewListItem = false
        },
        links = {
            style = 'markdown',
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
        }
    })
end

return config
