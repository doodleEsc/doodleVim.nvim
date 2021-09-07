local config = {}

function config.vim_sonictemplate()
  vim.g.sonictemplate_postfix_key = '<C-,>'
  vim.g.sonictemplate_vim_template_dir = os.getenv("HOME").. '/.config/nvim/template'
end

function config.nvim_lsp()
	require('plugins.completion.lspconfig')
end

function config.nvim_cmp()
	local cmp = require('cmp')
	cmp.setup{
		sources = {
			{ name = 'buffer' },
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'vsnip' },
			{ name = 'cmp_tabnine' },
		},
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. " " .. vim_item.kind
				return vim_item
			end
		  }
	}
end

function config.lspinstall()
  require'lspinstall'.setup()
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
