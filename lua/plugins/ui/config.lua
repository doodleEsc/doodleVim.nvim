local config = {}

function config.galaxyline()
  require('plugins.ui.eviline')
end

function config.nvim_tree()
  -- On Ready Event for Lazy Loading work
  require("nvim-tree.events").on_nvim_tree_ready(
    function()
      vim.cmd("NvimTreeRefresh")
    end
  )
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 0
  vim.g.nvim_tree_indent_markers = 1
end

function config.treesitter()
  -- vim.api.nvim_command('set foldmethod=expr')
  -- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup {
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
      additional_vim_regex_highlighting = false,
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

function config.barbar()
	vim.g.bufferline = {
	  -- Enable/disable animations
	  animation = true,

	  -- Enable/disable auto-hiding the tab bar when there is a single buffer
	  auto_hide = true,

	  -- Enable/disable current/total tabpages indicator (top right corner)
	  tabpages = true,

	  -- Enable/disable close button
	  closable = true,

	  -- Enables/disable clickable tabs
	  --  - left-click: go to buffer
	  --  - middle-click: delete buffer
	  clickable = true,

	  -- Excludes buffers from the tabline
	  exclude_ft = {},
	  exclude_name = {},

	  -- Enable/disable icons
	  -- if set to 'numbers', will show buffer index in the tabline
	  -- if set to 'both', will show buffer index and icons in the tabline
	  icons = true,

	  -- If set, the icon color will follow its corresponding buffer
	  -- highlight group. By default, the Buffer*Icon group is linked to the
	  -- Buffer* group (see Highlighting below). Otherwise, it will take its
	  -- default value as defined by devicons.
	  icon_custom_colors = false,

	  -- Configure icons on the bufferline.
	  icon_separator_active = '▎',
	  icon_separator_inactive = '▎',
	  icon_close_tab = '',
	  icon_close_tab_modified = '●',
	  icon_pinned = '車',

	  -- If true, new buffers will be inserted at the end of the list.
	  -- Default is to insert after current buffer.
	  insert_at_end = false,

	  -- Sets the maximum padding width with which to surround each tab
	  maximum_padding = 1,

	  -- Sets the maximum buffer name length.
	  maximum_length = 30,

	  -- If set, the letters for each buffer in buffer-pick mode will be
	  -- assigned based on their name. Otherwise or in case all letters are
	  -- already assigned, the behavior is to assign letters in order of
	  -- usability (see order below)
	  semantic_letters = true,

	  -- New buffer letters are assigned in this order. This order is
	  -- optimal for the qwerty keyboard layout but might need adjustement
	  -- for other layouts.
	  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

	  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
	  -- where X is the buffer number. But only a static string is accepted here.
	  no_name_title = nil,
	}
end

return config
