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
    }
  }
end

return config
