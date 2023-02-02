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
        gui_style = {
            fg = "NONE", -- The gui style to use for the fg highlight group.
            bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
            multiline = true, -- enable multine todo comments
            multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
            multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
            before = "", -- "fg" or "bg" or empty
            keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)\v(\s?\(.*\)|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
            error = { "#fb4934" },
            hack = { "#fe8019" },
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
            pattern = [[\b(KEYWORDS)(\s?\(.*\)|:)+]], -- ripgrep regex
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

-- function config.autopairs()
--     local cmp = require("cmp")
--     require('nvim-autopairs').setup {}
--     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--     cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
-- end

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

function config.hop()
    require 'hop'.setup()
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
        auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
        exclude_filetypes = {
            "NvimTree",
            "Outline",
        }, -- Choose certain filetypes to not show minimap on
        max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
        max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
        minimap_width = 20, -- The width of the text part of the minimap
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = true, -- Use nvim-treesitter to highlight the code
        use_git = true, -- Show small dots to indicate git additions and deletions
        width_multiplier = 4, -- How many characters one dot represents
        z_index = 1, -- The z-index the floating window will be on
        show_cursor = true, -- Show the cursor position in the minimap
        window_border = 'single' -- The border style of the floating window (accepts all usual options)
    })
end

return config
