local config = {}

function config.lspconfig()
	require('plugins.completion.lspconfig')
end

function config.nvim_lsp_installer()

	if not packer_plugins['cmp-nvim-lsp'].loaded then
	  vim.cmd [[PackerLoad cmp-nvim-lsp]]
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

	local lsp_installer = require("nvim-lsp-installer")
	lsp_installer.on_server_ready(function(server)
	  local opts = {
		  -- on_attach = enhance_attach,
		  capabilities = capabilities,
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

function config.lspsage()
	local saga = require 'lspsaga'
	saga.init_lsp_saga({
	  code_action_icon = '💡'
	})
end

function config.nvim_cmp()
	local cmp = require('cmp')
	cmp.setup({
		-- snippet = {
		-- 	expand = function(args)
		-- 		require('luasnip').lsp_expand(args.body)
		-- 	end,
		-- },
		sources =  cmp.config.sources({
			{ name = 'nvim_lsp' },
			-- { name = 'buffer' },
			-- { name = 'path' },
			-- { name = 'cmp_tabnine' },
			-- { name = 'luasnip' },
		}),
		-- formatting = {
		-- 	format = function(entry, vim_item)
		-- 		vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. " " .. vim_item.kind
		-- 		return vim_item
		-- 	end
		-- }
	})
end

function config.lspkind_nvim()
	require("lspkind").init({
		with_text = true,

		-- default symbol map
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		--
		-- default: 'default'
		preset = 'codicons',

		-- override preset symbols
		--
		-- default: {}
		symbol_map = {
		  Text = "",
		  Method = "",
		  Function = "",
		  Constructor = "",
		  Field = "ﰠ",
		  Variable = "",
		  Class = "ﴯ",
		  Interface = "",
		  Module = "",
		  Property = "ﰠ",
		  Unit = "塞",
		  Value = "",
		  Enum = "",
		  Keyword = "",
		  Snippet = "",
		  Color = "",
		  File = "",
		  Reference = "",
		  Folder = "",
		  EnumMember = "",
		  Constant = "",
		  Struct = "פּ",
		  Event = "",
		  Operator = "",
		  TypeParameter = ""
		},
	})
end

return config
