local config = {}

function config.telescope()
  if not packer_plugins['telescope-coc.nvim'].loaded then
	-- vim.cmd [[PackerLoad telescope-fzy-native.nvim]]
	vim.cmd [[PackerLoad telescope-file-browser.nvim]]
	vim.cmd [[PackerLoad telescope-coc.nvim]]
  end

  require('telescope').setup {
    defaults = {
      prompt_prefix = '🔭 ',
      selection_caret = " ",
      sorting_strategy = 'ascending',
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    }
  }

  require('telescope').load_extension('file_browser')
  require('telescope').load_extension('coc')
  require('telescope').load_extension('todo-comments')
end

function config.nvim_tree()
	require'nvim-tree'.setup {
	  -- disables netrw completely
	  disable_netrw       = true,
	  -- hijack netrw window on startup
	  hijack_netrw        = true,
	  -- open the tree when running this setup function
	  open_on_setup       = false,
	  -- will not open on setup if the filetype is in this list
	  ignore_ft_on_setup  = {},
	  -- closes neovim automatically when the tree is the last **WINDOW** in the view
	  auto_close          = false,
	  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	  open_on_tab         = false,
	  -- hijack the cursor in the tree to put it at the start of the filename
	  hijack_cursor       = true,
	  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually) 
	  update_cwd          = false,
	  -- show lsp diagnostics in the signcolumn
	  diagnostics = {
		enable = true,
		icons = {
		  hint = "",
		  info = "",
		  warning = "",
		  error = "",
		}
	  },
	  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	  update_focused_file = {
		-- enables the feature
		enable      = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd  = false,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {}
	  },
	  -- configuration options for the system open command (`s` in the tree by default)
	  system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd  = nil,
		-- the command arguments as a list
		args = {}
	  },
	  view = {
		-- width of the window, can be either a number (columns) or a string in `%`
		width = 31,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = 'left',
		-- if true the tree will resize itself after opening a file
		auto_resize = false,
		mappings = {
		  -- custom only false will merge the list with the default mappings
		  -- if true, it will only use your list to set the mappings
		  custom_only = false,
		  -- list of mappings to set on the tree manually
		  list = {}
		}
	  }
	}
end

function config.vista()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_close_on_jump = 1
  vim.g.vista_stay_on_open = 0
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = 'coc'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_vimwiki_executive = 'markdown'
  vim.g.vista_executive_for = {
    vimwiki =  'markdown',
    pandoc = 'markdown',
    markdown = 'toc',
    typescript = 'coc',
    typescriptreact =  'coc',
  }
end

function config.mkdp()
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_open_to_the_world  = 1
  vim.g.mkdp_open_ip = '0.0.0.0'
  vim.g.mkdp_port = 9096
  vim.g.mkdp_echo_preview_url = 1
  vim.g.mkdp_command_for_global = 1
  vim.g.mkdp_auto_close = 0
end

function config.fterm()
	require'FTerm'.setup({
		border = 'rounded',
		dimensions  = {
			height = 0.9,
			width = 0.9,
		},
		blend = 15,
	})
end

function config.gitsigns()
	require('gitsigns').setup{
		keymaps = {},
		watch_gitdir = {
			interval = 2000,
			follow_files = true
		},
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter_opts = {
			relative_time = false
		},
	}
end

function config.comment()
	require('Comment').setup{
		padding = true,
		sticky = true,
		ignore = nil,
	}
end

return config
