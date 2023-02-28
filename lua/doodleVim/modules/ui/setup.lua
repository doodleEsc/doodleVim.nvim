local ui = {}

function ui.treesitter(plugin)
    require("doodleVim.extend.lazy").add("nvim-treesitter", function()
        require("doodleVim.utils.defer").immediate_load("nvim-treesitter")
        local vendor = {
            "bash",
            "cmake",
            "comment",
            "c",
            "cpp",
            "dot",
            "dockerfile",
            "go",
            "gomod",
            "gowork",
            "json",
            "html",
            "lua",
            "make",
            "python",
            "regex",
            "rust",
            "toml",
            "vim",
            "yaml",
            "solidity",
            "markdown",
            "org",
        }

        -- HACK: add norg and norg_meta parser_info to nvim-treesitter

        local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
        parser_configs.org = {
            install_info = {
                url = 'https://github.com/milisims/tree-sitter-org',
                revision = "081179c52b3e8175af62b9b91dc099d010c38770",
                files = { 'src/parser.c', 'src/scanner.cc' },
            },
            filetype = 'org',
        }

        local langs = {}
        local utils = require("doodleVim.utils.utils")
        for _, lang in ipairs(vendor) do
            if not utils.ts_is_installed(lang) then
                table.insert(langs, lang)
            end
        end
        if #langs > 0 then
            local update = require("nvim-treesitter.install").update { with_sync = true }
            local ok, _ = pcall(update, langs)
            if not ok then
                vim.notify("TSUpdate Failed...")
            end
        end
    end)
end

function ui.barbar(plugin)
    vim.g.bufferline = {
        -- Enable/disable animations
        animation = true,
        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = false,
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
        icon_separator_active = "│",
        icon_separator_inactive = "│",
        icon_close_tab = "",
        icon_close_tab_modified = "",
        icon_pinned = "",
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

return ui
