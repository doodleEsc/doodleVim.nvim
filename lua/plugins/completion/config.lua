local config = {}

function config.nvim_lsp()
	require('plugins.completion.lspconfig')
end

function config.nvim_cmp()
	local cmp = require('cmp')
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
		}),
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. " " .. vim_item.kind
				return vim_item
			end
		  }
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
