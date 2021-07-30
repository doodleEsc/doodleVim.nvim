local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'bash',
      'c', 
      'cmake',
      'comment',
      'dockerfile',
      'go',
      'gomod',
      'html',
      'css',
      'json',
      'lua',
      'python',
      'rust',
      'yaml'

    },
    highlight = {
      enable = true,
    },
	rainbow = {
	  enable = true,
	  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	  max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	  colors = {}, -- table of hex strings
	  termcolors = {} -- table of colour name strings
	}
  }
end

return config
