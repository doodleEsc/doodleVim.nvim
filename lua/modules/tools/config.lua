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
			initial_mode = "normal",
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

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<C-b>"] = actions.results_scrolling_up,
					["<C-f>"] = actions.results_scrolling_down,

					["<Tab>"] = actions_layout.toggle_preview,
					-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					-- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					-- ["<C-l>"] = actions.complete_tag,
					-- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					["<C-w>"] = { "<c-s-w>", type = "command" },
				},
				n = {
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					-- ["<Down>"] = actions.move_selection_next,
					-- ["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,
					["<C-s>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<C-b>"] = actions.results_scrolling_up,
					["<C-f>"] = actions.results_scrolling_down,

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
		enable = true,
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

function config.symbols_outline()
	local icons = require("utils.icons")
	vim.g.symbols_outline = {
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false,
		position = 'right',
		relative_width = false,
		width = 50,
		auto_close = true,
		show_numbers = false,
		show_relative_numbers = false,
		show_symbol_details = true,
		preview_bg_highlight = 'LspSagaAutoPreview',
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = {"<Esc>", "q"},
			goto_location = "<CR>",
			focus_location = "o",
			hover_symbol = "gh",
			toggle_preview = "K",
			rename_symbol = "gn",
			code_actions = "ga",
		},
		lsp_blacklist = {},
		symbol_blacklist = {},
		symbols = {
			File = {icon = icons.cmp.File, hl = "TSURI"},
			Module = {icon = icons.cmp.Module, hl = "TSNamespace"},
			Namespace = {icon = icons.cmp.Namespace, hl = "TSNamespace"},
			Package = {icon = icons.cmp.Package, hl = "TSNamespace"},
			Class = {icon = icons.cmp.Class, hl = "TSType"},
			Method = {icon = icons.cmp.Method, hl = "TSMethod"},
			Property = {icon = icons.cmp.Property, hl = "TSMethod"},
			Field = {icon = icons.cmp.Field, hl = "TSField"},
			Constructor = {icon = icons.cmp.Constructor, hl = "TSConstructor"},
			Enum = {icon = icons.cmp.Enum, hl = "TSType"},
			Interface = {icon = icons.cmp.Interface, hl = "TSType"},
			Function = {icon = icons.cmp.Function, hl = "TSFunction"},
			Variable = {icon = icons.cmp.Variable, hl = "TSConstant"},
			Constant = {icon = icons.cmp.Constant, hl = "TSConstant"},
			String = {icon = icons.cmp.String, hl = "TSString"},
			Number = {icon = icons.cmp.Number, hl = "TSNumber"},
			Boolean = {icon = icons.cmp.Boolean, hl = "TSBoolean"},
			Array = {icon = icons.cmp.Array, hl = "TSConstant"},
			Object = {icon = icons.cmp.Object, hl = "TSType"},
			Key = {icon = icons.cmp.Keyword, hl = "TSType"},
			Null = {icon = icons.cmp.Null, hl = "TSType"},
			EnumMember = {icon = icons.cmp.EnumMember, hl = "TSField"},
			Struct = {icon = icons.cmp.Struct, hl = "TSType"},
			Event = {icon = icons.cmp.Event, hl = "TSType"},
			Operator = {icon = icons.cmp.Operator, hl = "TSOperator"},
			TypeParameter = {icon = icons.cmp.TypeParameter, hl = "TSParameter"}
		}
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
