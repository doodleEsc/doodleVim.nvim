local config = {}
local vim_path = require('doodleVim.core.global').vim_path

function config.lspconfig(plugin, opts)
    local handler = require("doodleVim.modules.lsp.handler")
    handler.lsp_hover()
    handler.lsp_diagnostic()
    handler.null_ls_depress()

    local servers = opts.servers or {}
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.offsetEncoding = { "utf-16" }

    local function setup(server)
        local server_opts = servers[server] or {}
        server_opts.capabilities = capabilities
        if opts.setup then
            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                    return
                end
            elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then
                    return
                end
            end
        end
        require("lspconfig")[server].setup(server_opts)
    end

    local mlsp = require("mason-lspconfig")
    local available = mlsp.get_available_servers()
    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
        if server_opts then
            server_opts = server_opts == true and {} or server_opts
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(available, server) then
                setup(server)
            else
                ensure_installed[#ensure_installed + 1] = server
            end
        end
    end
    require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup_handlers({ setup })
end

function config.mason()
    require("mason").setup({
        ui = {
            check_outdated_packages_on_open = true,
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = "rounded",
            icons = {
                -- The list icon to use for installed packages.
                package_installed = "◍",
                -- The list icon to use for packages that are installing, or queued for installation.
                package_pending = "◍",
                -- The list icon to use for packages that are not installed.
                package_uninstalled = "◍",
            },
            keymaps = {
                -- Keymap to expand a package
                toggle_package_expand = "<CR>",
                -- Keymap to install the package under the current cursor position
                install_package = "i",
                -- Keymap to reinstall/update the package under the current cursor position
                update_package = "u",
                -- Keymap to check for new version for the package under the current cursor position
                check_package_version = "c",
                -- Keymap to update all installed packages
                update_all_packages = "U",
                -- Keymap to check which installed packages are outdated
                check_outdated_packages = "C",
                -- Keymap to uninstall a package
                uninstall_package = "X",
                -- Keymap to cancel a package installation
                cancel_installation = "<C-c>",
                -- Keymap to apply language filter
                apply_language_filter = "<C-f>",
            },
        },
        -- The directory in which to install packages.
        install_root_dir = require("mason-core.path").concat({ vim.fn.stdpath("data"), "mason" }),
        PATH = "prepend",
        pip = {
            -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
            -- and is not recommended.
            --
            -- Example: { "--proxy", "https://proxyserver" }
            install_args = {},
        },
        -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
        -- debugging issues with package installations.
        log_level = vim.log.levels.INFO,
        -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
        -- packages that are requested to be installed will be put in a queue.
        max_concurrent_installers = 4,
        github = {
            -- The template URL to use when downloading assets from GitHub.
            -- The placeholders are the following (in order):
            -- 1. The repository (e.g. "rust-lang/rust-analyzer")
            -- 2. The release version (e.g. "v0.3.0")
            -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
            download_url_template = "https://github.com/%s/releases/download/%s/%s",
        },
        providers = {
            "mason.providers.registry-api",
        },
    })
end

function config.nlsp_settings()
    require("nlspsettings").setup({
        config_home = vim_path .. "/nlsp-settings",
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers = { ".git" },
        append_default_schemas = true,
        loader = "json",
    })
end

function config.gotools()
    require("gotools").setup({
        tools = {
            gotests = {
                bin = require "mason-core.path".bin_prefix() .. "/" .. "gotests",
            },
            gomodifytags = {
                bin = require "mason-core.path".bin_prefix() .. "/" .. "gomodifytags",
                skip_unexported = true,
            },
            impl = {
                bin = require "mason-core.path".bin_prefix() .. "/" .. "impl",
            }
        },
        select_opts = {
            prompt = 'Select An Action',
            kind = 'gotools'
        },
    })
end

function config.null_ls()
    local null_ls = require("null-ls")

    null_ls.setup({
        cmd = { "nvim" },
        debounce = 250,
        debug = false,
        default_timeout = 5000,
        diagnostics_format = "#{m}",
        fallback_severity = vim.diagnostic.severity.ERROR,
        log = {
            enable = true,
            level = "warn",
            use_console = "async",
        },
        on_attach = nil,
        -- on_init = function(new_client, _)
        --     print(vim.inspect(new_client))
        --     new_client.offset_encoding = 'utf-32'
        -- end,
        on_exit = nil,
        sources = {
            null_ls.builtins.code_actions.gitsigns,
            -- null_ls.builtins.formatting.stylua,
            require("gotools").code_actions.gotests,
            require("gotools").code_actions.gomodifytags,
            require("gotools").code_actions.impl,
        },
        update_in_insert = false,
    })
end

function config.lightbulb()
    local codicons = require("codicons")

    vim.fn.sign_define("LightBulbSign", { text = codicons.get("lightbulb"), texthl = "GruvboxYellowSign" })

    -- Showing defaults
    require('nvim-lightbulb').setup({
        -- LSP client names to ignore
        -- Example: {"sumneko_lua", "null-ls"}
        ignore = { "null-ls" },
        sign = {
            enabled = true,
            -- Priority of the gutter sign
            priority = 10,
        },
        float = {
            enabled = false,
            -- Text to show in the popup float
            text = "💡",
            -- Available keys for window options:
            -- - height     of floating window
            -- - width      of floating window
            -- - wrap_at    character to wrap at for computing height
            -- - max_width  maximal width of floating window
            -- - max_height maximal height of floating window
            -- - pad_left   number of columns to pad contents at left
            -- - pad_right  number of columns to pad contents at right
            -- - pad_top    number of lines to pad contents at top
            -- - pad_bottom number of lines to pad contents at bottom
            -- - offset_x   x-axis offset of the floating window
            -- - offset_y   y-axis offset of the floating window
            -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
            -- - winblend   transparency of the window (0-100)
            win_opts = {},
        },
        virtual_text = {
            enabled = false,
            -- Text to show at virtual text
            text = "💡",
            -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
            hl_mode = "replace",
        },
        status_text = {
            enabled = false,
            -- Text to provide when code actions are available
            text = "💡",
            -- Text to provide when no actions are available
            text_unavailable = ""
        },
        autocmd = {
            enabled = true,
            -- see :help autocmd-pattern
            pattern = { "*" },
            -- see :help autocmd-events
            events = { "CursorHold", "CursorHoldI" }
        }
    })
end

function config.fidget(plugin, opts)
    require "fidget".setup({
        text = {
            spinner = "pipe", -- animation shown when tasks are ongoing
            done = "✔", -- character shown when all tasks are complete
            commenced = "Started", -- message shown when task starts
            completed = "Completed", -- message shown when task completes
        },
        align = {
            bottom = true, -- align fidgets along bottom edge of buffer
            right = true, -- align fidgets along right edge of buffer
        },
        timer = {
            spinner_rate = 125, -- frame rate of spinner animation, in ms
            fidget_decay = 2000, -- how long to keep around empty fidget, in ms
            task_decay = 1000, -- how long to keep around completed task, in ms
        },
        window = {
            relative = "win", -- where to anchor, either "win" or "editor"
            blend = 100, -- &winblend for the window
            zindex = nil, -- the zindex value for the window
            border = "none", -- style of border for the fidget window
        },
        fmt = {
            leftpad = true, -- right-justify text in fidget box
            stack_upwards = true, -- list of tasks grows upwards
            max_width = 0, -- maximum width of the fidget box
            fidget = -- function to format fidget title
            function(fidget_name, spinner)
                return string.format("%s %s", spinner, fidget_name)
            end,
            task = -- function to format each task line
            function(task_name, message, percentage)
                return string.format(
                        "%s%s [%s]",
                        message,
                        percentage and string.format(" (%s%%)", percentage) or "",
                        task_name
                    )
            end,
        }
    })
end

return config
