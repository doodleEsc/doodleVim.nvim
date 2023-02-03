local config = {}

function config.nvim_cmp(plugin, opts)
    require("codicons.extensions.completion_item_kind").set({
        include_icon = true,
        include_label = true,
        monospaced = true,
        override = {}
    })

    local cmp = require("cmp")
    local under_comparator = require("cmp-under-comparator").under
    local WIDE_HEIGHT = 40

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

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
                -- require("cmp-under-comparator").under,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        PreselectMode = "none",
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
        mapping = {
            ["<CR>"] = {
                i = cmp.mapping.confirm({ select = false }),
            },
            ['<C-e>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end),
            ["<C-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-n>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            -- when menu is visible, navigate to next item
            -- when line is empty, insert a tab character
            -- else, activate completion
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif check_back_space() then
                    fallback()
                else
                    cmp.complete()
                end
            end, { 'i', 's' }),
            -- when menu is visible, navigate to previous item on list
            -- else, revert to default behavior
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
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
                    cmp.select_next_item({
                        behavior = cmp.SelectBehavior.Select,
                        count = 6
                    })
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({
                        behavior = cmp.SelectBehavior.Select,
                        count = 6
                    })
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-f>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-b>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
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

                local cmd = require("cmp")
                vim_item.kind = vim.lsp.protocol.CompletionItemKind[cmp.lsp.CompletionItemKind[vim_item.kind]]

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
                c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            },
            ["<Down>"] = {
                c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            },
        }),
        sources = cmp.config.sources({
            { name = "cmdline" },
        }, {
            { name = "path" },
        }),
    })

    require('nvim-autopairs').setup {}
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

function config.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            "~/.local/share/nvim/site/pack/lazy/opt/friendly-snippets",
        },
    })
end

function config.neogen()
    require("neogen").setup({ snippet_engine = "luasnip" })
end

return config
