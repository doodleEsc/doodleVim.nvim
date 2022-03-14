local config = {}

function config.telescope()
  if (not packer_plugins['telescope-fzy-native.nvim'].loaded) or (not packer_plugins['telescope-file-browser.nvim'].loaded) then
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
				shorten = { len = 2, exclude = {-2, -1}}
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
					preview_width = 0.45,
					prompt_position = "top"
				},
				vertical = {
					width = 0.9,
					height = 0.9,
				}
			},
			preview = {
				hide_on_startup = false
			},
			default_mappings = {
				i = {
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,

					-- ["<C-c>"] = actions.close,

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

					["q"] = actions.close,

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

		-- Function to call when you select a project from telecope
		-- Accepts:
		--    "find_project_files"        : call 'Telescope find_files' on project
		--    "browse_project_files"      : call 'Telescope file_browser' on project
		--    "search_in_project_files"   : call 'Telescope live_grep' on project
		--    "recent_project_files"      : call 'Telescope oldfiles' on project
		--    "change_working_directory"  : just change the directory
		-- Note: All will change the directory regardless
		telescope_on_project_selected = function(path, open)
			require("auto-session").RestoreSession()
		end
	}
end

function config.autosession()
	vim.o.sessionoptions="buffers,curdir,folds,help,tabpages,winsize,winpos"
	require('auto-session').setup({
		log_level = 'info',
		auto_session_enable_last_session = false,
		auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
		auto_session_enabled = false,
		auto_save_enabled = false,
		auto_restore_enabled = false,
		auto_session_suppress_dirs = {'~/'},
		-- the configs below are lua only
		bypass_session_save_file_types = nil,
		post_restore_cmds = { require('extend.tree').toggle }
	})
end

function config.which_key()
	local wk = require("which-key")
	wk.setup({
		key_labels = {
		["<space>"] = "SPC",
		["<leader>"] = "SPC",
		["<cr>"] = "ENT",
		["<tab>"] = "TAB",
		["<a>"] = "ALT",
		["<s>"] = "SHI",
		["<c>"] = "CTR",
	  },
	  operators = {},
	  window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0
	  },
	  ignore_missing = false,
	})

	-- bind common keymap
	local bind = require('keymap.bind')
	local def_map = require("keymap.def_map")
	local plug_map = require("keymap.plug_map")

	-- bind raw keymap
	bind.nvim_load_mapping(plug_map.raw)

	wk.register(def_map.normal)
	wk.register(def_map.insert)
	wk.register(def_map.command)
	wk.register(def_map.visual)

	wk.register(plug_map.normal)
	wk.register(plug_map.insert)
	wk.register(plug_map.visual)
end

return config
