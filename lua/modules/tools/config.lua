local config = {}

function config.telescope()
  if not packer_plugins['telescope-fzy-native.nvim'].loaded then
	vim.cmd [[PackerLoad telescope-fzy-native.nvim]]
	vim.cmd [[PackerLoad telescope-file-browser.nvim]]
  end

  local actions = require "telescope.actions"
  local actions_layout = require "telescope.actions.layout"
	require('telescope').setup {
		defaults = {
			prompt_prefix = '🔭 ',
			selection_caret = " ",
			sorting_strategy = 'ascending',
			scroll_strategy = "limit",
			set_env = { ['COLORTERM'] = 'truecolor'},
			path_display = {
				'smart',
				'truncate',
			},
			results_title = true,
			color_devicons = true,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim" -- add this value
			},
			layout_strategy = "flex",
			layout_config = {
				horizontal = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 120,
					preview_width = 0.6,
					prompt_position = "top"
				},
				vertical = {
					width = 0.9,
					height = 0.9,
				}
			},
			preview = {
				hide_on_startup = true
			},
			default_mappings = {
				i = {
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					-- ["<Down>"] = actions.move_selection_next,
					-- ["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,
					["<C-s>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-b>"] = actions.preview_scrolling_up,
					["<C-f>"] = actions.preview_scrolling_down,

					["<C-u>"] = actions.results_scrolling_up,
					["<C-d>"] = actions.results_scrolling_down,

					["<Tab>"] = actions_layout.toggle_preview,
					-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					-- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					-- ["<C-l>"] = actions.complete_tag,
					-- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					["<C-w>"] = { "<c-s-w>", type = "command" },
				},
				n = {
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					-- ["<Down>"] = actions.move_selection_next,
					-- ["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,
					["<C-s>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-b>"] = actions.preview_scrolling_up,
					["<C-f>"] = actions.preview_scrolling_down,

					["<C-u>"] = actions.results_scrolling_up,
					["<C-d>"] = actions.results_scrolling_down,

					["<Tab>"] = actions_layout.toggle_preview,
					-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					-- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					-- ["<C-l>"] = actions.complete_tag,
					-- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					["<C-w>"] = { "<c-s-w>", type = "command" },
				},
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = true,
					override_file_sorter = true,
				},
			},
		},
	}

	require('telescope').load_extension('fzy_native')
	require('telescope').load_extension('file_browser')
	require('telescope').load_extension('todo-comments')
	require('telescope').load_extension('projects')
end

function config.nvim_tree()
	vim.g.nvim_tree_respect_buf_cwd = 1
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
	  auto_reload_on_write = true,
	  open_on_tab         = false,
	  -- hijack the cursor in the tree to put it at the start of the filename
	  hijack_cursor       = true,
	  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	  update_cwd          = true,
	  -- show lsp diagnostics in the signcolumn
	  update_to_buf_dir   = {
		enable = true,
		auto_open = true,
	  },
	  diagnostics = {
		enable = false,
		icons = {
		  hint = "",
		  info = "",
		  warning = "",
		  error = "",
		}
	  },
	  git = {
		enable = true,
		ignore = false,
		timeout = 500,
	  },
	  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	  update_focused_file = {
		-- enables the feature
		enable      = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd  = true,
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
		width = 31,
		side = 'left',
		-- if true the tree will resize itself after opening a file
		auto_resize = false,
		mappings = {
		  -- custom only false will merge the list with the default mappings
		  -- if true, it will only use your list to set the mappings
		  custom_only = false,
		  -- list of mappings to set on the tree manually
		  list = {}
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes"
	  }
	}
end

function config.vista()
  vim.g["vista#renderer#enable_icon"] = 1
  vim.g.vista_close_on_jump = 1
  vim.g.vista_stay_on_open = 0
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_vimwiki_executive = 'markdown'
  vim.g.vista_executive_for = {
    vimwiki =  'markdown',
    pandoc = 'markdown',
    markdown = 'toc',
  }
  vim.g.vista_icon_indent = {"╰─▸ ","├─▸ "}
  vim.g.vista_sidebar_width = 40
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

function config.floaterm()
	vim.g.floaterm_width = 0.9
	vim.g.floaterm_height = 0.9
	vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
	vim.g.floaterm_opener = "edit"
end

function config.translator()
	vim.g.translator_window_borderchars = {"─","│","─","│","╭","╮","╯","╰"}
end

function config.project()
	require("project_nvim").setup {
		-- Manual mode doesn't automatically change your root directory, so you have
		-- the option to manually do so using `:ProjectRoot` command.
		manual_mode = false,

		-- Methods of detecting the root directory. **"lsp"** uses the native neovim
		-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
		-- order matters: if one is not detected, the other is used as fallback. You
		-- can also delete or rearangne the detection methods.
		detection_methods = { "lsp", "pattern" },

		-- All the patterns used to detect root dir, when **"pattern"** is in
		-- detection_methods
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

		-- Table of lsp clients to ignore by name
		-- eg: { "efm", ... }
		ignore_lsp = {},

		-- Don't calculate root dir on specific directories
		-- Ex: { "~/.cargo/*", ... }
		exclude_dirs = {},

		-- Show hidden files in telescope
		show_hidden = false,

		-- When set to false, you will get a message when project.nvim changes your
		-- directory.
		silent_chdir = false,

		-- Path where project.nvim will store the project history for use in
		-- telescope
		datapath = vim.fn.stdpath("data"),
	}
end

return config
