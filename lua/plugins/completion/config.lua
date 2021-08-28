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
	}
end

function config.lspinstall()
  require'lspinstall'.setup()
end

return config
