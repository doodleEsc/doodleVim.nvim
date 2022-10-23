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
            pattern = [[.*<(KEYWORDS)\v(\s?\(.*\)|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
            -- pattern = [[.*<(KEYWORDS)\v(\s|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
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

function config.autopairs()
    require('doodleVim.utils.defer').immediate_load('nvim-cmp')

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
    filetypes = {md = true, rmd = true, markdown = true},
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
            text = os.date('%Y-%m-%d_')..text
            return(text)
        end
    },
    to_do = {
        symbols = {' ', '-', 'X'},
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
        MkdnEnter = {{'n', 'v'}, '<CR>'},
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = {'n', '<Tab>'},
        MkdnPrevLink = {'n', '<S-Tab>'},
        MkdnNextHeading = {'n', ']]'},
        MkdnPrevHeading = {'n', '[['},
        MkdnGoBack = {'n', '<BS>'},
        MkdnGoForward = {'n', '<Del>'},
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnDestroyLink = {'n', '<M-CR>'},
        MkdnTagSpan = {'v', '<M-CR>'},
        MkdnMoveSource = {'n', '<F2>'},
        MkdnYankAnchorLink = {'n', 'ya'},
        MkdnYankFileAnchorLink = {'n', 'yfa'},
        MkdnIncreaseHeading = {'n', '+'},
        MkdnDecreaseHeading = {'n', '-'},
        MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = {'n', 'o'},
        MkdnNewListItemAboveInsert = {'n', 'O'},
        MkdnExtendList = false,
        MkdnUpdateNumbering = {'n', '<leader>nn'},
        MkdnTableNextCell = {'i', '<Tab>'},
        MkdnTablePrevCell = {'i', '<S-Tab>'},
        MkdnTableNextRow = false,
        MkdnTablePrevRow = {'i', '<M-CR>'},
        MkdnTableNewRowBelow = {'n', '<leader>ir'},
        MkdnTableNewRowAbove = {'n', '<leader>iR'},
        MkdnTableNewColAfter = {'n', '<leader>ic'},
        MkdnTableNewColBefore = {'n', '<leader>iC'},
        MkdnFoldSection = {'n', '<leader>f'},
        MkdnUnfoldSection = {'n', '<leader>F'}
    }
})





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
            format_on_move = true
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
            MkdnMoveSource = { 'n', '<F2>' },
            MkdnYankAnchorLink = { 'n', 'ya' },
            MkdnYankFileAnchorLink = { 'n', 'yfa' },
            MkdnIncreaseHeading = { 'n', '+' },
            MkdnDecreaseHeading = { 'n', '-' },
            MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
            MkdnNewListItem = false,
            MkdnExtendList = false,
            MkdnUpdateNumbering = { 'n', '<leader>nn' },
            MkdnTableNextCell = { 'i', '<M-l>' },
            MkdnTablePrevCell = { 'i', '<M-h>' },
            MkdnTableNextRow = false,
            MkdnTablePrevRow = { 'i', '<M-CR>' },
            MkdnTableNewRowBelow = { { 'n', 'i' }, '<leader>ir' },
            MkdnTableNewRowAbove = { { 'n', 'i' }, '<leader>iR' },
            MkdnTableNewColAfter = { { 'n', 'i' }, '<leader>ic' },
            MkdnTableNewColBefore = { { 'n', 'i' }, '<leader>iC' },
            MkdnFoldSection = { 'n', '<leader>f' },
            MkdnUnfoldSection = { 'n', '<leader>F' }
        }
    })
end

function config.nvim_surround()
    require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
    })
end

function config.diffview()
    local icons = require("doodleVim.utils.icons")
    local actions = require("diffview.actions")

    require("diffview").setup({
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" }, -- The git executable followed by default args.
        use_icons = true, -- Requires nvim-web-devicons
        icons = { -- Only applies when use_icons is true.
            folder_closed = icons.folder.default,
            folder_open = icons.folder.open,
        },
        signs = {
            fold_closed = icons.arrow.right,
            fold_open = icons.arrow.down,
        },
        file_panel = {
            listing_style = "tree", -- One of 'list' or 'tree'
            tree_options = { -- Only applies when listing_style is 'tree'
                flatten_dirs = true, -- Flatten dirs that only contain one single dir
                folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
            },
            win_config = { -- See ':h diffview-config-win_config'
                position = "left",
                width = 30,
            },
        },
        file_history_panel = {
            log_options = { -- See ':h diffview-config-log_options'
                single_file = {
                    diff_merges = "combined",
                },
                multi_file = {
                    diff_merges = "first-parent",
                },
            },
            win_config = { -- See ':h diffview-config-win_config'
                position = "bottom",
                height = 16,
            },
        },
        commit_log_panel = {
            win_config = {}, -- See ':h diffview-config-win_config'
        },
        default_args = { -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        hooks = {}, -- See ':h diffview-config-hooks'
        keymaps = {
            disable_defaults = false, -- Disable the default keymaps
            view = {
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
                ["<tab>"]      = actions.select_next_entry, -- Open the diff for the next file
                ["<s-tab>"]    = actions.select_prev_entry, -- Open the diff for the previous file
                ["gf"]         = actions.goto_file, -- Open the file in a new split in the previous tabpage
                ["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
                ["<C-w>gf"]    = actions.goto_file_tab, -- Open the file in a new tabpage
                ["<leader>e"]  = actions.focus_files, -- Bring focus to the files panel
                ["<leader>b"]  = actions.toggle_files, -- Toggle the files panel.
            },
            file_panel = {
                ["j"]             = actions.next_entry, -- Bring the cursor to the next file entry
                ["<down>"]        = actions.next_entry,
                ["k"]             = actions.prev_entry, -- Bring the cursor to the previous file entry.
                ["<up>"]          = actions.prev_entry,
                ["<cr>"]          = actions.select_entry, -- Open the diff for the selected entry.
                ["o"]             = actions.select_entry,
                ["<2-LeftMouse>"] = actions.select_entry,
                ["-"]             = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
                ["S"]             = actions.stage_all, -- Stage all entries.
                ["U"]             = actions.unstage_all, -- Unstage all entries.
                ["X"]             = actions.restore_entry, -- Restore entry to the state on the left side.
                ["R"]             = actions.refresh_files, -- Update stats and entries in the file list.
                ["L"]             = actions.open_commit_log, -- Open the commit log panel0
                ["<c-u>"]         = actions.scroll_view(-0.25), -- Scroll the view up
                ["<c-d>"]         = actions.scroll_view(0.25), -- Scroll the view down
                -- ["<tab>"]         = actions.select_next_entry,
                -- ["<s-tab>"]       = actions.select_prev_entry,
                -- ["gf"]            = actions.goto_file,
                -- ["<C-w><C-f>"]    = actions.goto_file_split,
                ["<C-o>"]       = actions.goto_file_tab,
                ["i"]             = actions.listing_style, -- Toggle between 'list' and 'tree' views
                ["f"]             = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
                ["<leader>e"]     = actions.focus_files,
                ["<leader>b"]     = actions.toggle_files,
            },
            file_history_panel = {
                ["g!"]            = actions.options, -- Open the option panel
                ["<C-A-d>"]       = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
                ["y"]             = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
                ["L"]             = actions.open_commit_log,
                ["zR"]            = actions.open_all_folds,
                ["zM"]            = actions.close_all_folds,
                ["j"]             = actions.next_entry,
                ["<down>"]        = actions.next_entry,
                ["k"]             = actions.prev_entry,
                ["<up>"]          = actions.prev_entry,
                ["<cr>"]          = actions.select_entry,
                ["o"]             = actions.select_entry,
                ["<2-LeftMouse>"] = actions.select_entry,
                ["<c-u>"]         = actions.scroll_view(-0.25),
                ["<c-d>"]         = actions.scroll_view(0.25),
                -- ["<tab>"]         = actions.select_next_entry,
                -- ["<s-tab>"]       = actions.select_prev_entry,
                -- ["gf"]            = actions.goto_file,
                -- ["<C-w><C-f>"]    = actions.goto_file_split,
                ["<C-t>"]         = actions.goto_file_tab,
                ["<leader>e"]     = actions.focus_files,
                ["<leader>b"]     = actions.toggle_files,
            },
            option_panel = {
                ["<tab>"] = actions.select_entry,
                ["q"]     = actions.close,
            },
        },
    })
end

return config
