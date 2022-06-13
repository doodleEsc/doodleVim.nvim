local config = {}

function config.nvim_lsp_installer()

    local handler = require("doodleVim.modules.completion.handler")
    handler.lsp_hover()
    handler.lsp_diagnostic()
    handler.null_ls_depress()

    require("nvim-lsp-installer").setup {
        automatic_installation = false,
    }

    local servers = {}
    local installed_servers = require("nvim-lsp-installer").get_installed_servers()
    for _, item in ipairs(installed_servers) do
        table.insert(servers, item.name)
    end

    require('doodleVim.utils.defer').load_immediately('cmp-nvim-lsp')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        -- require "doodleVim.modules.completion.handler".lsp_highlight_document(client)
        require "lsp_signature".on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            floating_window_above_cur_line = true,
            handler_opts = { border = "rounded" }
        }, bufnr)
    end

    local lspconfig = require 'lspconfig'
    for _, lsp in ipairs(servers) do
        local server_available, server = require("nvim-lsp-installer.servers").get_server(lsp)
        if not server_available then
            server:install()
        end
        local default_opts = server:get_default_options()
        lspconfig[lsp].setup {
            cmd_env = default_opts.cmd_env,
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end

end

function config.nvim_cmp()
    require('doodleVim.utils.defer').load_immediately({ 'LuaSnip', 'neogen' })

    local cmp = require('cmp')
    local types = require('cmp.types')
    -- local luasnip = require("luasnip")
    -- local neogen = require('neogen')

    cmp.setup({
        enabled = function()
            local disabled = false
            disabled = disabled or (vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt')
            disabled = disabled or (vim.fn.reg_recording() ~= '')
            disabled = disabled or (vim.fn.reg_executing() ~= '')
            return not disabled
        end,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered({
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
            }),
            documentation = cmp.config.window.bordered({
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
            }),
        },
        sources = cmp.config.sources({
            { name = 'luasnip', priority = 100 },
            { name = 'nvim_lsp', priority = 99 },
            { name = 'cmp_tabnine' },
            { name = 'buffer' },
            { name = 'path' },
            {
                name = 'look',
                keyword_length = 2,
                option = { convert_case = true, loud = true },
            },
        }),
        mapping = cmp.mapping.preset.insert({
            ['<Down>'] = {
                i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
            },
            ['<Up>'] = {
                i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
            },
            ['<C-n>'] = {
                i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
            },
            ['<C-p>'] = {
                i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
            },
            ['<CR>'] = {
                i = cmp.mapping.confirm({ select = true }),
            },
            ['<C-e>'] = {
                i = cmp.mapping.abort(),
            },
            ["<C-k>"] = cmp.mapping(function(fallback)
                if require('luasnip').jumpable(-1) then
                    require('luasnip').jump(-1)
                elseif require('neogen').jumpable(true) then
                    require('neogen').jump_prev()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if require('luasnip').expand_or_jumpable() then
                    require('luasnip').expand_or_jump()
                elseif require('neogen').jumpable() then
                    require('neogen').jump_next()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ['<C-d>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ['<C-u>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(-2)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        view = {
            entries = { name = 'custom', selection_order = 'top_down' },
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
                    vim_item.abbr = string.sub(word, 0, -2)
                end

                local icons = require "doodleVim.utils.icons"
                vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)

                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[BUF]",
                    cmp_tabnine = "[TAB]",
                    luasnip = "[SNP]",
                    path = "[PATH]",
                    look = "[LOOK]",
                })[entry.source.name]

                return vim_item
            end,
        }
    })

    cmp.setup.filetype('TelescopePrompt', {
        sources = cmp.config.sources({ { name = 'path' } })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            ['<Down>'] = {
                c = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
            },
        }),
        sources = cmp.config.sources({
            { name = 'cmdline' }
        }, {
            { name = 'path' }
        })
    })
end

function config.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            "~/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
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
        on_init = nil,
        on_exit = nil,
        sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.black,
            null_ls.builtins.code_actions.gitsigns,
        },
        update_in_insert = false,
    })
end

function config.neogen()
    require('neogen').setup({ snippet_engine = "luasnip" })
end

function config.rename()
    require('rename').setup({
        rename = {
            border = {
                highlight = 'FloatBorder',
                style = 'rounded',
                title = ' Rename ',
                title_align = 'left',
                title_hl = 'FloatBorder',
            },
            prompt = '➤ ',
            prompt_hl = 'Comment',
        },
    })
end

return config
