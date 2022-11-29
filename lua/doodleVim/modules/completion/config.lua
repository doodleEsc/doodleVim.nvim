local config = {}

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

function config.mason_lspconfig()
    require("doodleVim.utils.defer").immediate_load("mason.nvim")
    require("mason-lspconfig").setup({
        ensure_installed = {
            "gopls",
            "pylsp",
            "sumneko_lua",
            "jsonls",
            "clangd"
        },
        automatic_installation = false,
    })

    local handler = require("doodleVim.modules.completion.handler")
    handler.lsp_hover()
    handler.lsp_diagnostic()
    handler.null_ls_depress()

    local function contains(tab, val)
        for _, value in ipairs(tab) do
            if value == val then
                return true
            end
        end
        return false
    end

    local lsp_servers = {}
    local installed_servers = require("mason-registry").get_installed_packages()
    local package_to_lspconfig = require("mason-lspconfig.mappings.server").package_to_lspconfig
    for _, item in ipairs(installed_servers) do
        if contains(item.spec.categories, "LSP") then
            local lsp_server = package_to_lspconfig[item.name]
            table.insert(lsp_servers, lsp_server)
        end
    end

    require("doodleVim.utils.defer").immediate_load("cmp-nvim-lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities.offsetEncoding = { "utf-16" }

    local lspconfig = require("lspconfig")
    local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        -- require "doodleVim.modules.completion.handler".lsp_highlight_document(client)
        require("lsp_signature").on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            floating_window_above_cur_line = true,
            handler_opts = { border = "rounded" },
        }, bufnr)
    end

    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        capabilities = capabilities,
    })

    for _, lsp in ipairs(lsp_servers) do
        lspconfig[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

function config.nlsp_settings()
    local vim_path = require("doodleVim.core.global").vim_path
    require("nlspsettings").setup({
        config_home = vim_path .. "/nlsp-settings",
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers = { ".git" },
        append_default_schemas = true,
        loader = "json",
    })
end

function config.nvim_cmp()
    require("doodleVim.utils.defer").immediate_load({
        "LuaSnip",
        "neogen",
        "cmp-under-comparator",
    })

    local cmp = require("cmp")
    local types = require("cmp.types")
    local under_comparator = require "cmp-under-comparator".under
    local WIDE_HEIGHT = 40

    cmp.setup({
        enabled = function()
            local disabled = false
            disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
            -- disabled = disabled or (vim.api.nvim_buf_get_option(0, 'filetype') == 'TelescopePrompt')
            disabled = disabled or (vim.fn.reg_recording() ~= "")
            disabled = disabled or (vim.fn.reg_executing() ~= "")
            return not disabled
        end,
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered({
                border = "rounded",
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            }),
            documentation = {
                max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
                border = "rounded",
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            },
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                under_comparator,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = 'treesitter' },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            {
                name = "look",
                keyword_length = 3,
                option = { convert_case = true, loud = true },
            },
            -- { name = "cmp_tabnine" },
        }, {

        }),
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = {
                i = cmp.mapping.confirm({ select = false }),
            },
            ["<C-e>"] = {
                i = cmp.mapping.abort(),
            },
            ["<C-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end),
            ["<C-n>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end),
            ["<C-k>"] = cmp.mapping(function(fallback)
                if require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                elseif require("neogen").jumpable(true) then
                    require("neogen").jump_prev()
                else
                    require("doodleVim.utils.utils").feedkeys("<Up>", "i")
                end
            end, { "i", "s" }),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                elseif require("neogen").jumpable() then
                    require("neogen").jump_next()
                else
                    require("doodleVim.utils.utils").feedkeys("<Down>", "i")
                end
            end, { "i", "s" }),
            ["<C-d>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(-2)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        view = {
            entries = { name = "custom", selection_order = "top_down" },
        },
        formatting = {
            fields = {
                cmp.ItemField.Abbr,
                cmp.ItemField.Kind,
                cmp.ItemField.Menu,
            },
            format = function(entry, vim_item)
                local word = vim_item.abbr

                if string.sub(word, -1, -1) == "~" then
                    word = string.sub(word, 0, -2)
                end

                local width = #word
                if width >= math.ceil(vim.o.columns / 4) then
                    width = math.ceil(width / 4)
                    local offset = width - #word
                    word = string.sub(word, 0, offset)
                end
                vim_item.abbr = word

                local icons = require("doodleVim.utils.icons")
                vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)

                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[BUF]",
                    -- cmp_tabnine = "[TAB]",
                    luasnip = "[SNP]",
                    path = "[PATH]",
                    look = "[LOOK]",
                    treesitter = "[TS]"
                })[entry.source.name]

                return vim_item
            end,
        },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
            ["<Up>"] = {
                c = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
            },
            ["<Down>"] = {
                c = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
            },
        }),
        sources = cmp.config.sources({
            { name = "cmdline" },
        }, {
            { name = "path" },
        }),
    })
end

function config.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            "~/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
        },
    })
end

function config.gotools()
    require("doodleVim.utils.defer").immediate_load("mason.nvim")
    require("gotools").setup({
        tools = {
            gotests = {
                bin = require "mason-core.path".bin_prefix() .. "/" .. "gotests",
                display = {
                    prompt = 'Select An Action',
                    kind = 'gotools'
                }
            },
            gomodifytags = {
                bin = require "mason-core.path".bin_prefix() .. "/" .. "gomodifytags",
            }
        }
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

function config.neogen()
    require("neogen").setup({ snippet_engine = "luasnip" })
end

function config.lightbulb()
    local icons = require("doodleVim.utils.icons")
    require("lightbulb").setup({
        -- LSP client names to ignore
        -- Example: {"sumneko_lua", "null-ls"}
        ignore = { "null-ls" },
        sign = {
            enabled = true,
            -- Priority of the gutter sign
            priority = 20,
            text = icons.diagnostics.hint_sign,
        },
        float = {
            enabled = false,
            -- Text to show in the popup float
            text = icons.diagnostics.hint_sign,
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
            text = icons.diagnostics.hint_sign,
            -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
            hl_mode = "replace",
        },
        status_text = {
            enabled = false,
            -- Text to provide when code actions are available
            text = icons.diagnostics.hint_sign,
            -- Text to provide when no actions are available
            text_unavailable = "",
        },
    })

    vim.api.nvim_create_augroup("lightbulb", { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lightbulb",
        pattern = "*",
        command = "lua require'lightbulb'.check()",
    })
end

return config
