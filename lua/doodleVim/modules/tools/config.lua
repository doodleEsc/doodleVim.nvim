local config = {}

function config.telescope()
    require("doodleVim.utils.defer").immediate_load({
        "telescope-fzf-native.nvim",
        "telescope-file-browser.nvim",
        "nvim-neoclip.lua",
        "project.nvim",
        "telescope-ui-select.nvim",
    })

    local icons = require("doodleVim.utils.icons")
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")

    require("telescope").setup({
        defaults = {
            initial_mode = "insert",
            wrap_results = false,
            prompt_prefix = "",
            selection_caret = icons.arrow.caret .. " ",
            sorting_strategy = "ascending",
            scroll_strategy = "cycle",
            set_env = { ["COLORTERM"] = "truecolor" },
            path_display = {
                shorten = { len = 2, exclude = { -2, -1 } },
            },
            results_title = "Results",
            prompt_title = "Prompt",
            color_devicons = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim", -- add this value
            },
            layout_strategy = "flex",
            layout_config = {
                horizontal = {
                    width = 0.9,
                    height = 0.9,
                    preview_cutoff = 120,
                    preview_width = 0.45,
                    prompt_position = "top",
                },
                vertical = {
                    height = 0.9,
                    width = 0.9,
                    preview_cutoff = 40,
                    prompt_position = "top",
                },
            },
            preview = {
                hide_on_startup = false,
            },
            default_mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,

                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<C-b>"] = actions.results_scrolling_up,
                    ["<C-f>"] = actions.results_scrolling_down,

                    ["<Tab>"] = actions_layout.toggle_preview,
                    ["<C-Space>"] = actions.which_key,
                    ["<C-c>"] = actions.close,
                },
                n = {
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,

                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<C-b>"] = actions.results_scrolling_up,
                    ["<C-f>"] = actions.results_scrolling_down,

                    ["<Tab>"] = actions_layout.toggle_preview,
                    ["<C-Space>"] = actions.which_key,
                    ["<C-c>"] = actions.close,
                    ["q"] = actions.close,
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({
                    initial_mode = "normal",
                }),
            },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            },
        },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("todo-comments")
    require("telescope").load_extension("projects")
    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("ui-select")
end

function config.nvim_tree()
    local icons = require("doodleVim.utils.icons")
    require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
        auto_reload_on_write = true,
        create_in_closed_folder = true,
        disable_netrw = true,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        update_cwd = true,
        reload_on_bufenter = true,
        respect_buf_cwd = true,
        prefer_startup_root = false,
        sync_root_with_cwd = true,
        view = {
            adaptive_size = false,
            centralize_selection = true,
            width = 30,
            hide_root_folder = false,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            mappings = {
                custom_only = true,
                list = {
                    { key = { "<CR>", "o" }, action = "edit" },
                    { key = "<C-v>", action = "vsplit" },
                    { key = "<C-x>", action = "split" },
                    { key = "<C-t>", action = "tabnew" },
                    { key = "P", action = "parent_node" },
                    { key = "<BS>", action = "close_node" },
                    { key = "K", action = "first_sibling" },
                    { key = "J", action = "last_sibling" },
                    { key = "I", action = "toggle_git_ignored" },
                    { key = "H", action = "toggle_dotfiles" },
                    { key = "<C-r>", action = "refresh" },
                    { key = "a", action = "create" },
                    { key = "d", action = "remove" },
                    { key = "D", action = "trash" },
                    { key = "r", action = "rename" },
                    { key = "R", action = "full_rename" },
                    { key = "x", action = "cut" },
                    { key = "c", action = "copy" },
                    { key = "p", action = "paste" },
                    { key = "y", action = "copy_name" },
                    { key = "yp", action = "copy_path" },
                    { key = "ya", action = "copy_absolute_path" },
                    { key = "-", action = "dir_up" },
                    { key = "s", action = "system_open" },
                    { key = "f", action = "live_filter" },
                    { key = "F", action = "clear_live_filter" },
                    { key = "q", action = "close" },
                    { key = "C", action = "collapse_all" },
                    { key = "E", action = "expand_all" },
                    { key = "/", action = "search_node" },
                    { key = ".", action = "run_file_command" },
                    { key = "<Tab>", action = "toggle_file_info" },
                    { key = "?", action = "toggle_help" },
                    { key = "m", action = "toggle_mark" },
                    { key = "bmv", action = "bulk_move" },

                },
            },
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = true,
            highlight_opened_files = "all",
            root_folder_modifier = ":~",
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    none = " ",
                },
            },
            icons = {
                webdev_colors = true,
                git_placement = "signcolumn",
                padding = " ",
                symlink_arrow = "  ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = icons.file.default,
                    symlink = icons.file.symlink,
                    bookmark = icons.file.bookmark,
                    folder = {
                        arrow_closed = icons.arrow.right,
                        arrow_open = icons.arrow.down,
                        default = icons.folder.default,
                        open = icons.folder.open,
                        empty = icons.folder.empty,
                        empty_open = icons.folder.empty_open,
                        symlink = icons.folder.symlink,
                        symlink_open = icons.folder.symlink_open,
                    },
                    git = {
                        unstaged = icons.git.unstaged,
                        staged = icons.git.staged,
                        unmerged = icons.git.unmerged,
                        renamed = icons.git.renamed,
                        untracked = icons.git.untracked,
                        deleted = icons.git.deleted,
                        ignored = icons.git.ignored,
                    },
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        ignore_ft_on_setup = {},
        system_open = {
            cmd = "",
            args = {},
        },
        diagnostics = {
            enable = true,
            show_on_dirs = false,
            icons = {
                hint = icons.diagnostics.hint_sign,
                info = icons.diagnostics.infor_sign,
                warning = icons.diagnostics.warn_sign,
                error = icons.diagnostics.error_sign,
            },
        },
        filters = {
            dotfiles = false,
            custom = {},
            exclude = {},
        },
        filesystem_watchers = {
            enable = true,
            debounce_delay = 100,
        },
        git = {
            enable = true,
            ignore = false,
            timeout = 200,
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false,
            },
            expand_all = {
                max_folder_discovery = 300,
            },
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
            remove_file = {
                close_window = true,
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = false,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                diagnostics = false,
                git = false,
                profile = false,
            },
        },
    })

    local api = require('nvim-tree.api')
    local Event = require('nvim-tree.api').events.Event
    local bufferline_api = require('bufferline.api')

    api.events.subscribe(Event.Resize, function(size)
        bufferline_api.set_offset(size)
    end)

    api.events.subscribe(Event.TreeClose, function()
        bufferline_api.set_offset(0)
    end)

end

function config.symbols_outline()
    local icons = require("doodleVim.utils.icons")
    require("symbols-outline").setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 30,
        auto_close = true,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { icons.arrow.right, icons.arrow.down },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = { "<Esc>", "q" },
            goto_location = "<CR>",
            focus_location = "o",
            hover_symbol = "gh",
            toggle_preview = "gp",
            rename_symbol = "gn",
            code_actions = "ga",
            fold = "h",
            unfold = "l",
            fold_all = "W",
            unfold_all = "E",
            fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
            File = { icon = icons.cmp.File, hl = "@text.uri" },
            Module = { icon = icons.cmp.Module, hl = "@namespace" },
            Namespace = { icon = icons.cmp.Namespace, hl = "@namespace" },
            Package = { icon = icons.cmp.Package, hl = "@namespace" },
            Class = { icon = icons.cmp.Class, hl = "@type" },
            Method = { icon = icons.cmp.Method, hl = "@method" },
            Property = { icon = icons.cmp.Property, hl = "@property" },
            Field = { icon = icons.cmp.Field, hl = "@field" },
            Constructor = { icon = icons.cmp.Constructor, hl = "@constructor" },
            Enum = { icon = icons.cmp.Enum, hl = "@constant" },
            Interface = { icon = icons.cmp.Interface, hl = "@type" },
            Function = { icon = icons.cmp.Function, hl = "@function" },
            Variable = { icon = icons.cmp.Variable, hl = "@variable" },
            Constant = { icon = icons.cmp.Constant, hl = "@constant" },
            String = { icon = icons.cmp.String, hl = "@string" },
            Number = { icon = icons.cmp.Number, hl = "@number" },
            Boolean = { icon = icons.cmp.Boolean, hl = "@boolean" },
            Array = { icon = icons.cmp.Array, hl = "@variable" },
            Object = { icon = icons.cmp.Object, hl = "@type.definition" },
            Key = { icon = icons.cmp.Keyword, hl = "@field" },
            Null = { icon = icons.cmp.Null, hl = "@none" },
            EnumMember = { icon = icons.cmp.EnumMember, hl = "@constant" },
            Struct = { icon = icons.cmp.Struct, hl = "@type.definition" },
            Event = { icon = icons.cmp.Event, hl = "@text.note" },
            Operator = { icon = icons.cmp.Operator, hl = "@operator" },
            TypeParameter = { icon = icons.cmp.TypeParameter, hl = "@parameter" },
        }
    })

end

function config.mkdp()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_open_to_the_world = 1
    vim.g.mkdp_open_ip = "0.0.0.0"
    vim.g.mkdp_port = 9096
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_command_for_global = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_preview_options = {
        maid = {
            theme = "neutral",
            flowchart = {
                curve = 'linear'
            }
        }
    }
end

function config.floaterm()
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
    vim.g.floaterm_opener = "edit"
end

function config.translator()
    vim.g.translator_window_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    vim.g.translator_proxy_url = "socks5://127.0.0.1:1080"
    vim.g.translator_default_engines = { "google" }
end

function config.project()
    require("project_nvim").setup({
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "poetry.lock" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),

        -- Function to call when you select a project from telecope
        -- Accepts:
        --    "find_project_files"        : call 'Telescope find_files' on project
        --    "browse_project_files"      : call 'Telescope file_browser' on project
        --    "search_in_project_files"   : call 'Telescope live_grep' on project
        --    "recent_project_files"      : call 'Telescope oldfiles' on project
        --    "change_working_directory"  : just change the directory
        -- Note: All will change the directory regardless
        telescope_on_project_selected = function(path, open)
            local Lib = require("auto-session-library")
            local AutoSession = require("auto-session")
            local sessions_dir = AutoSession.get_root_dir()
            local session_name = Lib.escaped_session_name_from_cwd()
            local branch_name = ""
            if AutoSession.conf.auto_session_use_git_branch then
                local out = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")
                if vim.v.shell_error ~= 0 then
                    vim.api.nvim_err_writeln(string.format("git failed with: %s", table.concat(out, "\n")))
                end
                branch_name = out[1]
            end

            branch_name = Lib.escape_branch_name(branch_name ~= "" and "_" .. branch_name or "")
            session_name = string.format("%s%s", session_name, branch_name)

            local session_file = string.format(sessions_dir .. "%s.vim", session_name)

            if Lib.is_readable(session_file) then
                vim.cmd([[silent! lua require('auto-session').RestoreSession()]])
                vim.notify("Current Session Loaded")
            else
                vim.cmd([[:ene]])
                require("doodleVim.extend.tree").toggle()
                vim.notify("No Session Found, Open In Current Dir", "warn")
            end
        end,
    })
end

function config.autosession()
    vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,globals"
    require("auto-session").setup({
        log_level = "info",
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = false,
        auto_save_enabled = false,
        auto_restore_enabled = false,
        auto_session_suppress_dirs = {},
        -- the configs below are lua only
        bypass_session_save_file_types = nil,
        post_restore_cmds = { require("doodleVim.extend.tree").toggle },
    })
end

function config.which_key()
    local wk = require("which-key")
    wk.setup({
        key_labels = {
            ["<space>"] = "SPC",
            ["<leader>"] = "SPC",
            ["<cr>"] = "ENT",
            ["<tab>"] = "TAB",
            ["<a>"] = "ALT",
            ["<s>"] = "SHI",
            ["<c>"] = "CTR",
        },
        operators = {},
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        ignore_missing = false,
    })

    -- bind common doodleVim.keymap
    -- local bind = require("doodleVim.keymap.bind")
    local map = require("doodleVim.keymap.map")

    -- bind raw doodleVim.keymap
    -- bind.nvim_load_mapping(plug_map.raw)

    -- wk.register(def_map.normal)
    -- wk.register(def_map.insert)
    -- wk.register(def_map.command)
    -- wk.register(def_map.visual)
    --
    -- wk.register(plug_map.normal)
    -- wk.register(plug_map.insert)
    -- wk.register(plug_map.visual)

    for _, mappings in pairs(map) do
        for mode, keymaps in pairs(mappings) do
            wk.register(keymaps, { mode = tostring(mode) })
        end
    end

    -- wk.register({
    --     ["<leader>tq"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
    --         noremap = true, silent = true },
    -- }, { mode = 't' })

    -- wk.register({ ["<Esc>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
    --     "Toggle Terminal", noremap = true, silent = true } },
    --     { mode = 't' })


    -- wk.register({ ["<Esc>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>"), "To normal mode" } }, { mode = "t" })
end

function config.notify()
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

function config.neoclip()
    local function is_whitespace(line)
        return vim.fn.match(line, [[^\s*$]]) ~= -1
    end

    local function all(tbl, check)
        for _, entry in ipairs(tbl) do
            if not check(entry) then
                return false
            end
        end
        return true
    end

    require("neoclip").setup({
        history = 50,
        enable_persistent_history = true,
        continuous_sync = true,
        enable_system_clipboard = true,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        filter = function(data)
            return not all(data.event.regcontents, is_whitespace)
        end,
        preview = true,
        default_register = { '"', "+", "*" },
        default_register_macros = "z",
        enable_macro_history = false,
        content_spec_column = false,
        on_paste = {
            set_reg = false,
        },
        on_replay = {
            set_reg = false,
        },
        keys = {
            telescope = {
                i = {
                    select = "<cr>",
                    paste = "<c-p>",
                    paste_behind = "<c-k>",
                    replay = "<c-z>", -- replay a macro
                    delete = "<c-d>", -- delete an entry
                    custom = {},
                },
                n = {
                    select = "<cr>",
                    paste = "p",
                    paste_behind = "P",
                    replay = "z",
                    delete = "d",
                    custom = {},
                },
            },
        },
    })
end

function config.tmux()
    require("tmux").setup({
        -- overwrite default configuration
        -- here, e.g. to enable default bindings
        copy_sync = {
            -- enables copy sync and overwrites all register actions to
            -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
            enable = false,
        },
        navigation = {
            -- cycles to opposite pane while navigating into the border
            cycle_navigation = true,

            -- enables default keybindings (C-hjkl) for normal mode
            enable_default_keybindings = true,

            -- prevents unzoom tmux when navigating beyond vim border
            persist_zoom = true,
        },
        resize = {
            -- enables default keybindings (A-hjkl) for normal mode
            enable_default_keybindings = false,
            -- sets resize steps for x axis
            resize_step_x = 1,

            -- sets resize steps for y axis
            resize_step_y = 1,
        },
    })
end

function config.neorg()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        gtd = "~/Documents/Notes/gtd",
                    }
                }
            },
            ["core.gtd.base"] = {
                config = {
                    workspace = "gtd",
                },
            },
            ["core.norg.concealer"] = {},
            ["core.norg.completion"] = {
                config = {
                    engine = "nvim-cmp"
                }
            },
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = {
                    extensions = "all"
                }
            },
            ["core.keybinds"] = {
                config = {
                    default_keybinds = false,
                    hook = function(keybinds)

                        -- Mode: neorg
                        keybinds.map_event("norg", "n",
                            "<Leader>dd",
                            "core.norg.qol.todo_items.todo.task_done"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>du",
                            "core.norg.qol.todo_items.todo.task_undone"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>dp",
                            "core.norg.qol.todo_items.todo.task_pending"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>dh",
                            "core.norg.qol.todo_items.todo.task_on_hold"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>dc",
                            "core.norg.qol.todo_items.todo.task_cancelled"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>dr",
                            "core.norg.qol.todo_items.todo.task_recurring"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>di",
                            "core.norg.qol.todo_items.todo.task_import"
                        )
                        keybinds.map_event("norg", "n",
                            "<Space><Space>",
                            "core.norg.qol.todo_items.todo.task_cycle"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>kc",
                            "core.gtd.base.capture"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>kv",
                            "core.gtd.base.views"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>ke",
                            "core.gtd.base.edit"
                        )
                        keybinds.map_event("norg", "n",
                            "<Leader>nn",
                            "core.norg.dirman.new.note"
                        )
                        keybinds.map_event("norg", "n",
                            "<CR>",
                            "core.norg.esupports.hop.hop-link"
                        )

                        -- Mode: gtd-displays
                        keybinds.map_event("gtd-displays", "n",
                            "<CR>",
                            "core.gtd.ui.goto_task"
                        )
                        keybinds.map_event("gtd-displays", "n",
                            "q",
                            "core.gtd.ui.close"
                        )
                        keybinds.map_event("gtd-displays", "n",
                            "<Esc>",
                            "core.gtd.ui.close"
                        )
                        keybinds.map_event("gtd-displays", "n",
                            "<C-c>",
                            "core.gtd.ui.close"
                        )
                        keybinds.map_event("gtd-displays", "n",
                            "e",
                            "core.gtd.ui.edit_task"
                        )
                        keybinds.map_event("gtd-displays", "n",
                            "<Tab>",
                            "core.gtd.ui.details"
                        )
                    end
                }
            }
        }
    }
end

return config
