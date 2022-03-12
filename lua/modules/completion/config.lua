local config = {}

function config.nvim_lsp_installer()

	if not packer_plugins['cmp-nvim-lsp'].loaded then
	  vim.cmd [[PackerLoad cmp-nvim-lsp]]
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

	local lsp_installer = require("nvim-lsp-installer")
	lsp_installer.on_server_ready(function(server)
		local opts = {
			capabilities = capabilities,
			on_attach = function(client,bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				require "lsp_signature".on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					hint_enable = false,
					floating_window_above_cur_line = true,
					handler_opts = {border = "none"}
				})
			end
		}
		-- (optional) Customize the options passed to the server
		-- if server.name == "tsserver" then
		--     opts.root_dir = function() ... end
		-- end

		-- This setup() function is exactly the same as lspconfig's setup function.
		-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		server:setup(opts)
	end)
end

function config.nvim_cmp()
	if not packer_plugins['LuaSnip'].loaded then
	  vim.cmd [[PackerLoad LuaSnip]]
	end

	if not packer_plugins['neogen'].loaded then
	  vim.cmd [[PackerLoad neogen]]
	end

	local cmp = require('cmp')
	local luasnip = require("luasnip")
	local neogen = require('neogen')

	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		sources =  cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
			{ name = 'path' },
			{ name = 'cmp_tabnine' },
			{ name = 'luasnip' },
			{
				name = 'look',
				keyword_length = 2,
				option = {
					convert_case = true,
					loud = true,
					-- dict = '/usr/share/dict/words'
				},
			},
		}),
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			['<C-f>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			['<C-d>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.scroll_docs(2)
				else
					fallback()
				end
			end, {"i", "s"}),

			['<C-u>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.scroll_docs(-2)
				else
					fallback()
				end
			end, {"i", "s"}),
			["<C-k>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				elseif neogen.jumpable(true) then
					neogen.jump_prev()
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif neogen.jumpable() then
					neogen.jump_next()
                else 
                    fallback()
                end
            end, {"i", "s"}),
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

				local icons = require "utils.icons"
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
		},
		update_in_insert = false,
	})
end

function config.neogen()
	require('neogen').setup({ snippet_engine = "luasnip" })
end

return config
