local vim = vim
local config = {}

function config.telescope()
	local actions = require("telescope.actions")
	local actions_layout = require("telescope.actions.layout")

	-- disable binary preview
	local previewers = require("telescope.previewers")
	local Job = require("plenary.job")
	local new_maker = function(filepath, bufnr, opts)
		filepath = vim.fn.expand(filepath)
		Job:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
					end)
				end
			end,
		}):sync()
	end

	require("telescope").setup({
		defaults = {
			initial_mode = "insert",
			wrap_results = false,
			prompt_prefix = "",
			-- selection_caret = codicons.get("telescope") .. " ",
			buffer_previewer_maker = new_maker,
			selection_caret = "" .. " ",
			sorting_strategy = "ascending",
			scroll_strategy = "cycle",
			set_env = { ["COLORTERM"] = "truecolor" },
			path_display = {
				shorten = { len = 2, exclude = { -2, -1 } },
			},
			results_title = "Results",
			prompt_title = "Prompt",
			color_devicons = true,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim", -- add this value
			},
			layout_strategy = "flex",
			layout_config = {
				horizontal = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 120,
					preview_width = 0.45,
					prompt_position = "top",
				},
				vertical = {
					height = 0.9,
					width = 0.9,
					preview_cutoff = 40,
					prompt_position = "top",
				},
			},
			preview = {
				hide_on_startup = false,
				filesize_limit = 0.2, -- MB
			},
			default_mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,
					["<C-b>"] = actions.preview_scrolling_up,
					["<C-f>"] = actions.preview_scrolling_down,
					["<C-u>"] = actions.results_scrolling_up,
					["<C-d>"] = actions.results_scrolling_down,
					["<Tab>"] = actions_layout.toggle_preview,
					["<C-Space>"] = actions.which_key,
					["<C-c>"] = actions.close,
				},
				n = {
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,
					["<C-b>"] = actions.preview_scrolling_up,
					["<C-f>"] = actions.preview_scrolling_down,
					["<C-u>"] = actions.results_scrolling_up,
					["<C-d>"] = actions.results_scrolling_down,
					["<Tab>"] = actions_layout.toggle_preview,
					["<C-Space>"] = actions.which_key,
					["<C-c>"] = actions.close,
					["q"] = actions.close,
				},
			},
		},
		extensions = {
			["telescope-tabs"] = {
				show_preview = false,
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
		pickers = {
			find_files = {
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
		},
	})
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("projects")
	require("telescope").load_extension("neoclip")
	require("telescope").load_extension("telescope-tabs")
end

function config.nvim_tree()
	local codicons = require("codicons")
	local on_attach = require("doodleVim.extend.tree").on_attach
	local sort_by = require("doodleVim.extend.tree").get_sort_by
	require("nvim-tree").setup({
		-- BEGIN_DEFAULT_OPTS
		auto_reload_on_write = true,
		disable_netrw = true,
		hijack_cursor = true,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		sort_by = sort_by,
		root_dirs = {},
		prefer_startup_root = false,
		sync_root_with_cwd = true,
		reload_on_bufenter = false,
		respect_buf_cwd = true,
		on_attach = on_attach,
		select_prompts = false,
		view = {
			cursorline = true,
			debounce_delay = 15,
			adaptive_size = false,
			centralize_selection = true,
			width = 30,
			side = "left",
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			float = {
				enable = false,
				quit_on_focus_loss = true,
				open_win_config = {
					relative = "editor",
					border = "rounded",
					width = 30,
					height = 30,
					row = 1,
					col = 1,
				},
			},
		},
		renderer = {
			full_name = false,
			highlight_modified = "none",
			root_folder_label = ":~:s?$?/..?",
			indent_width = 2,
			add_trailing = false,
			group_empty = false,
			highlight_git = true,
			highlight_opened_files = "all",
			root_folder_modifier = ":~",
			highlight_diagnostics = false,
			highlight_bookmarks = "none",
			highlight_clipboard = "name",
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
			symlink_destination = true,
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
				},
			},
			icons = {
				webdev_colors = true,
				git_placement = "signcolumn",
				modified_placement = "after",
				padding = " ",
				symlink_arrow = codicons.get("arrow-small-right"),
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
				},
				glyphs = {
					default = codicons.get("file"),
					symlink = codicons.get("file-symlink-file"),
					bookmark = codicons.get("bookmark"),
					modified = "●",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = codicons.get("folder"),
						open = codicons.get("folder-opened"),
						empty = codicons.get("folder"),
						empty_open = codicons.get("folder-opened"),
						symlink = codicons.get("file-symlink-directory"),
						symlink_open = codicons.get("folder-opened"),
					},
					git = {
						unstaged = codicons.get("diff"),
						staged = codicons.get("diff-added"),
						unmerged = codicons.get("diff-modified"),
						renamed = codicons.get("diff-renamed"),
						untracked = codicons.get("zoom-in"),
						deleted = codicons.get("diff-removed"),
						ignored = codicons.get("diff-ignored"),
					},
				},
			},
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = false,
			update_cwd = false,
			ignore_list = {},
		},
		system_open = {
			cmd = "",
			args = {},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = {
				-- min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = codicons.get("question"),
				info = codicons.get("info"),
				warning = codicons.get("warning"),
				error = codicons.get("error"),
			},
		},
		filters = {
			dotfiles = false,
			git_clean = false,
			no_buffer = false,
			custom = {},
			exclude = {},
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 100,
			ignore_dirs = {},
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 200,
			show_on_dirs = true,
			show_on_open_dirs = true,
		},
		modified = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			expand_all = {
				max_folder_discovery = 300,
				exclude = {},
			},
			file_popup = {
				open_win_config = {
					col = 1,
					row = 1,
					relative = "cursor",
					border = "shadow",
					style = "minimal",
				},
			},
			open_file = {
				quit_on_open = false,
				resize_window = true,
				window_picker = {
					enable = true,
					picker = "default",
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
			remove_file = {
				close_window = true,
			},
		},
		trash = {
			cmd = "git trash",
		},
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = true,
		},
		tab = {
			sync = {
				open = false,
				close = false,
				ignore = {},
			},
		},
		notify = {
			threshold = vim.log.levels.INFO,
		},
		ui = {
			confirm = {
				remove = true,
				trash = true,
			},
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				dev = false,
				diagnostics = false,
				git = false,
				profile = false,
				watcher = false,
			},
		},
	})

	-- local api = require("nvim-tree.api")
	-- local Event = require("nvim-tree.api").events.Event
	-- local bufferline_api = require("bufferline.api")
	--
	-- api.events.subscribe(Event.Resize, function(size)
	-- 	bufferline_api.set_offset(size)
	-- end)
	--
	-- api.events.subscribe(Event.TreeClose, function()
	-- 	bufferline_api.set_offset(0)
	-- end)
end

function config.symbols_outline()
	local codicons = require("codicons")
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false,
		position = "right",
		relative_width = true,
		width = 30,
		auto_close = true,
		show_numbers = false,
		show_relative_numbers = false,
		show_symbol_details = true,
		preview_bg_highlight = "Pmenu",
		autofold_depth = nil,
		auto_unfold_hover = true,
		fold_markers = { codicons.get("arrow-small-right"), codicons.get("arrow-small-down") },
		wrap = false,
		keymaps = {
			-- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<CR>",
			focus_location = "o",
			hover_symbol = "gh",
			toggle_preview = "gp",
			rename_symbol = "gn",
			code_actions = "ga",
			fold = "h",
			unfold = "l",
			fold_all = "W",
			unfold_all = "E",
			fold_reset = "R",
		},
		lsp_blacklist = {},
		symbol_blacklist = {},
		symbols = {
			File = { icon = codicons.get("symbol-file"), hl = "@text.uri" },
			Module = { icon = codicons.get("symbol-module"), hl = "@namespace" },
			Namespace = { icon = codicons.get("symbol-namespace"), hl = "@namespace" },
			Package = { icon = codicons.get("symbol-package"), hl = "@namespace" },
			Class = { icon = codicons.get("symbol-class"), hl = "@type" },
			Method = { icon = codicons.get("symbol-method"), hl = "@method" },
			Property = { icon = codicons.get("symbol-property"), hl = "@method" },
			Field = { icon = codicons.get("symbol-field"), hl = "@field" },
			Constructor = { icon = codicons.get("symbol-constructor"), hl = "@constructor" },
			Enum = { icon = codicons.get("symbol-enum"), hl = "@type" },
			Interface = { icon = codicons.get("symbol-interface"), hl = "@type" },
			Function = { icon = codicons.get("symbol-function"), hl = "@function" },
			Variable = { icon = codicons.get("symbol-variable"), hl = "@constant" },
			Constant = { icon = codicons.get("symbol-constant"), hl = "@constant" },
			String = { icon = codicons.get("symbol-string"), hl = "@string" },
			Number = { icon = codicons.get("symbol-number"), hl = "@number" },
			Boolean = { icon = codicons.get("symbol-boolean"), hl = "@boolean" },
			Array = { icon = codicons.get("symbol-array"), hl = "@constant" },
			Object = { icon = codicons.get("symbol-object"), hl = "@type" },
			Key = { icon = codicons.get("symbol-key"), hl = "@type" },
			Null = { icon = codicons.get("symbol-null"), hl = "@type" },
			EnumMember = { icon = codicons.get("symbol-enum-member"), hl = "@field" },
			Struct = { icon = codicons.get("symbol-struct"), hl = "@type" },
			Event = { icon = codicons.get("symbol-event"), hl = "@type" },
			Operator = { icon = codicons.get("symbol-operator"), hl = "@operator" },
			TypeParameter = { icon = codicons.get("symbol-type-parameter"), hl = "@parameter" },
			Component = { icon = codicons.get("symbol-misc"), hl = "@function" },
			Fragment = { icon = codicons.get("symbol-misc"), hl = "@constant" },
		},
	})
end

function config.mkdp()
	vim.g.mkdp_auto_start = 0
	vim.g.mkdp_open_to_the_world = 1
	vim.g.mkdp_open_ip = "127.0.0.1"
	vim.g.mkdp_port = 9096
	vim.g.mkdp_echo_preview_url = 1
	vim.g.mkdp_command_for_global = 1
	vim.g.mkdp_auto_close = 0
	vim.g.mkdp_preview_options = {
		maid = {
			theme = "neutral",
			flowchart = {
				curve = "linear",
			},
		},
	}
end

function config.floaterm()
	vim.g.floaterm_width = 0.9
	vim.g.floaterm_height = 0.9
	vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
	vim.g.floaterm_opener = "edit"
end

function config.project()
	require("project_nvim").setup({
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
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "poetry.lock" },
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
		silent_chdir = true,
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
			local Lib = require("auto-session.lib")
			local AutoSession = require("auto-session")
			local sessions_dir = AutoSession.get_root_dir()
			local session_name = Lib.escaped_session_name_from_cwd()
			local branch_name = ""
			if AutoSession.conf.auto_session_use_git_branch then
				local out = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")
				if vim.v.shell_error ~= 0 then
					vim.api.nvim_err_writeln(string.format("git failed with: %s", table.concat(out, "\n")))
				end
				branch_name = out[1]
			end

			branch_name = Lib.escape_branch_name(branch_name ~= "" and "_" .. branch_name or "")
			session_name = string.format("%s%s", session_name, branch_name)

			local session_file = string.format(sessions_dir .. "%s.vim", session_name)

			if Lib.is_readable(session_file) then
				vim.cmd([[silent! lua require('auto-session').RestoreSession()]])
				vim.notify("Current Session Loaded")
			else
				vim.cmd([[:ene]])
				require("doodleVim.extend.tree").toggle()
				vim.notify("No Session Found, Open In Current Dir", "warn")
			end
		end,
	})
end

function config.autosession()
	vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,globals"
	require("auto-session").setup({
		log_level = "error",
		auto_session_enable_last_session = false,
		auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
		auto_session_enabled = false,
		auto_save_enabled = nil,
		auto_restore_enabled = nil,
		auto_session_suppress_dirs = nil,
		auto_session_use_git_branch = nil,
		-- the configs below are lua only
		bypass_session_save_file_types = nil,
		post_restore_cmds = { require("doodleVim.extend.tree").toggle },
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
			winblend = 0,
		},
		ignore_missing = false,
	})

	vim.defer_fn(function()
		local map = require("doodleVim.keymap.map")
		for _, mappings in pairs(map) do
			for mode, keymaps in pairs(mappings) do
				require("which-key").register(keymaps, { mode = tostring(mode) })
			end
		end
	end, 100)
end

function config.neoclip()
	local function is_whitespace(line)
		return vim.fn.match(line, [[^\s*$]]) ~= -1
	end

	local function all(tbl, check)
		for _, entry in ipairs(tbl) do
			if not check(entry) then
				return false
			end
		end
		return true
	end

	require("neoclip").setup({
		history = 50,
		enable_persistent_history = true,
		continuous_sync = true,
		enable_system_clipboard = true,
		db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
		filter = function(data)
			return not all(data.event.regcontents, is_whitespace)
		end,
		preview = true,
		default_register = { '"', "+", "*" },
		default_register_macros = "z",
		enable_macro_history = false,
		content_spec_column = false,
		on_paste = {
			set_reg = false,
		},
		on_replay = {
			set_reg = false,
		},
		keys = {
			telescope = {
				i = {
					select = "<cr>",
					paste = "<c-p>",
					paste_behind = "<c-k>",
					replay = "<c-z>", -- replay a macro
					delete = "<c-d>", -- delete an entry
					custom = {},
				},
				n = {
					select = "<cr>",
					paste = "p",
					paste_behind = "P",
					replay = "z",
					delete = "d",
					custom = {},
				},
			},
		},
	})
end

function config.tmux()
	require("tmux").setup({
		-- overwrite default configuration
		-- here, e.g. to enable default bindings
		copy_sync = {
			-- enables copy sync and overwrites all register actions to
			-- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
			enable = false,
		},
		navigation = {
			-- cycles to opposite pane while navigating into the border
			cycle_navigation = true,
			-- enables default keybindings (C-hjkl) for normal mode
			enable_default_keybindings = true,
			-- prevents unzoom tmux when navigating beyond vim border
			persist_zoom = true,
		},
		resize = {
			-- enables default keybindings (A-hjkl) for normal mode
			enable_default_keybindings = false,
			-- sets resize steps for x axis
			resize_step_x = 1,
			-- sets resize steps for y axis
			resize_step_y = 1,
		},
	})
end

function config.diffview()
	local codicons = require("codicons")
	local actions = require("diffview.actions")

	require("diffview").setup({
		diff_binaries = false, -- Show diffs for binaries
		enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
		git_cmd = { "git" }, -- The git executable followed by default args.
		use_icons = true, -- Requires nvim-web-devicons
		icons = {
			-- Only applies when use_icons is true.
			folder_closed = codicons.get("folder"),
			folder_open = codicons.get("folder-opened"),
		},
		signs = {
			fold_closed = codicons.get("arrow-small-right"),
			fold_open = codicons.get("arrow-small-down"),
		},
		file_panel = {
			listing_style = "tree", -- One of 'list' or 'tree'
			tree_options = {
				-- Only applies when listing_style is 'tree'
				flatten_dirs = true, -- Flatten dirs that only contain one single dir
				folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
			},
			win_config = {
				-- See ':h diffview-config-win_config'
				position = "left",
				width = 30,
			},
		},
		file_history_panel = {
			log_options = {
				-- See ':h diffview-config-log_options'
				git = {
					single_file = {
						diff_merges = "combined",
					},
					multi_file = {
						diff_merges = "first-parent",
					},
				},
			},
			win_config = {
				-- See ':h diffview-config-win_config'
				position = "bottom",
				height = 16,
			},
		},
		commit_log_panel = {
			win_config = {}, -- See ':h diffview-config-win_config'
		},
		default_args = {
			-- Default args prepended to the arg-list for the listed commands
			DiffviewOpen = {},
			DiffviewFileHistory = {},
		},
		hooks = {
			view_enter = function(_)
				vim.schedule(function()
					require("doodleVim.extend.tab").disable()
				end)
			end,
			view_leave = function(_)
				vim.schedule(function()
					require("doodleVim.extend.tab").enable()
				end)
			end,
		}, -- See ':h diffview-config-hooks'
		keymaps = {
			disable_defaults = false, -- Disable the default keymaps
			view = {
				-- The `view` bindings are active in the diff buffers, only when the current
				-- tabpage is a Diffview.
				["<tab>"] = actions.select_next_entry, -- Open the diff for the next file
				["<s-tab>"] = actions.select_prev_entry, -- Open the diff for the previous file
				["ge"] = actions.goto_file_edit, -- Open the file in a new tabpage
				-- ["<C-w>gf"]    = actions.goto_file, -- Open the file in a new split in the previous tabpage
				-- ["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
				-- ["<leader>e"] = actions.focus_files, -- Bring focus to the files panel
				-- ["<leader>b"] = actions.toggle_files, -- Toggle the files panel.
			},
			file_panel = {
				["j"] = actions.next_entry, -- Bring the cursor to the next file entry
				["<down>"] = actions.next_entry,
				["k"] = actions.prev_entry, -- Bring the cursor to the previous file entry.
				["<up>"] = actions.prev_entry,
				["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
				["o"] = actions.select_entry,
				-- ["<2-LeftMouse>"] = actions.select_entry,
				["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
				["S"] = actions.stage_all, -- Stage all entries.
				["U"] = actions.unstage_all, -- Unstage all entries.
				["X"] = actions.restore_entry, -- Restore entry to the state on the left side.
				["R"] = actions.refresh_files, -- Update stats and entries in the file list.
				["L"] = actions.open_commit_log, -- Open the commit log panel0
				["<c-u>"] = actions.scroll_view(-0.25), -- Scroll the view up
				["<c-d>"] = actions.scroll_view(0.25), -- Scroll the view down
				-- ["<tab>"]         = actions.select_next_entry,
				-- ["<s-tab>"]       = actions.select_prev_entry,
				-- ["gf"]            = actions.goto_file,
				-- ["<C-w><C-f>"]    = actions.goto_file_split,
				["<C-o>"] = actions.goto_file_tab,
				["i"] = actions.listing_style, -- Toggle between 'list' and 'tree' views
				["f"] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
				["<leader>e"] = actions.focus_files,
				["<leader>b"] = actions.toggle_files,
			},
			file_history_panel = {
				["g!"] = actions.options, -- Open the option panel
				["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
				["y"] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
				["L"] = actions.open_commit_log,
				["zR"] = actions.open_all_folds,
				["zM"] = actions.close_all_folds,
				["j"] = actions.next_entry,
				["<down>"] = actions.next_entry,
				["k"] = actions.prev_entry,
				["<up>"] = actions.prev_entry,
				["<cr>"] = actions.select_entry,
				["o"] = actions.select_entry,
				["<2-LeftMouse>"] = actions.select_entry,
				["<c-u>"] = actions.scroll_view(-0.25),
				["<c-d>"] = actions.scroll_view(0.25),
				-- ["<tab>"]         = actions.select_next_entry,
				-- ["<s-tab>"]       = actions.select_prev_entry,
				-- ["gf"]            = actions.goto_file,
				-- ["<C-w><C-f>"]    = actions.goto_file_split,
				["<C-t>"] = actions.goto_file_tab,
				["<leader>e"] = actions.focus_files,
				["<leader>b"] = actions.toggle_files,
			},
			option_panel = {
				["<tab>"] = actions.select_entry,
				["q"] = actions.close,
			},
		},
	})
end

function config.hydra(plugin)
	require("doodleVim.modules.tools.hydra")
end

function config.dapui()
	local codicons = require("codicons")
	require("dapui").setup({
		icons = {
			expanded = codicons.get("arrow-small-down"),
			current_frame = codicons.get("arrow-small-right"),
			collapsed = codicons.get("arrow-small-right"),
		},
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		element_mappings = {},
		expand_lines = vim.fn.has("nvim-0.7") == 1,
		force_buffers = true,
		layouts = {
			{
				-- You can change the order of elements in the sidebar
				elements = {
					-- Provide IDs as strings or tables with "id" and "size" keys
					{
						id = "scopes",
						size = 0.25, -- Can be float or integer > 1
					},
					{ id = "breakpoints", size = 0.25 },
					{ id = "stacks", size = 0.25 },
					{ id = "watches", size = 0.25 },
				},
				size = 40,
				position = "left", -- Can be "left" or "right"
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 10,
				position = "bottom", -- Can be "bottom" or "top"
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "rounded",
			mappings = {
				["close"] = { "q", "<Esc>" },
			},
		},
		controls = {
			enabled = vim.fn.exists("+winbar") == 1,
			element = "repl",
			icons = {
				pause = codicons.get("debug-pause"),
				play = codicons.get("debug-continue"),
				step_into = codicons.get("debug-step-into"),
				step_over = codicons.get("debug-step-over"),
				step_out = codicons.get("debug-step-out"),
				step_back = codicons.get("debug-step-back"),
				run_last = codicons.get("debug-rerun"),
				terminate = codicons.get("debug-stop"),
				disconnect = codicons.get("debug-disconnect"),
			},
		},
		render = {
			max_type_length = nil, -- Can be integer or nil.
			max_value_lines = 100, -- Can be integer or nil.
			indent = 1,
		},
	})
end

function config.dap()
	local codicons = require("codicons")

	-- setup sign
	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = codicons.get("debug-breakpoint"), texthl = "GruvboxRedSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = codicons.get("debug-breakpoint-conditional"), texthl = "GruvboxRedSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = codicons.get("debug-breakpoint-unsupported"), texthl = "GruvboxRedSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = codicons.get("debug-breakpoint-log"), texthl = "GruvboxYellowSign", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapStopped",
		{ text = codicons.get("debug-continue"), texthl = "GruvboxYellowSign", linehl = "", numhl = "" }
	)

	-- setup dapui
	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.close()
	end
	-- for some debug adapter, terminate or exit events will no fire, use disconnect request instead
	dap.listeners.before.disconnect["dapui_config"] = function()
		if not vim.g.dapui_setup then
			require("doodleVim.modules.tools.config").dapui()
			vim.g.dapui_setup = true
		end
		dapui.close()
	end

	-- setup adapter
	require("doodleVim.extend.debug").load_worker()
end

function config.nvim_ufo(plugin, opts)
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	require("ufo").setup({
		fold_virt_text_handler = handler,
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	})
end

function config.orgmode(plugin, opts)
	local orgmode = require("orgmode")
	orgmode.setup_ts_grammar()
	orgmode.setup({
		org_agenda_files = { "~/Documents/Notes/agenda.org" },
		org_default_notes_file = "~/Documents/Notes/default.org",
		org_todo_keywords = { "TODO", "WAITING", "|", "DONE", "DELEGATED" },
		org_todo_keyword_faces = {
			TODO = ":background #fb4934 :foreground #ebdbb2", -- overrides builtin color for `TODO` keyword
			WAITING = ":background #fabd2f :foreground #ebdbb2 :weight bold",
			DONE = ":background #10B981 :foreground #ebdbb2",
			DELEGATED = ":background #7C3AED :foreground #ebdbb2 :slant italic :underline on",
		},
	})
end

function config.bigfile(plugin, opts)
	-- default config
	require("bigfile").setup({
		filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
		pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
		features = { -- features to disable
			"indent_blankline",
			"illuminate",
			"lsp",
			"treesitter",
			"syntax",
			"matchparen",
			"vimopts",
			"filetype",
		},
	})
end

function config.neoai(plugin, opts)
	require("neoai").setup({
		-- Below are the default options, feel free to override what you would like changed
		ui = {
			output_popup_text = "NeoAI",
			input_popup_text = "Prompt",
			width = 30, -- As percentage eg. 30%
			output_popup_height = 80, -- As percentage eg. 80%
			submit = "<Enter>", -- Key binding to submit the prompt
		},
		models = {
			{
				name = "openai",
				model = "gpt-3.5-turbo",
				params = nil,
			},
		},

		register_output = {
			["g"] = function(output)
				return output
			end,
			["c"] = require("neoai.utils").extract_code_snippets,
		},

		inject = {
			cutoff_width = 75,
		},

		prompts = {
			context_prompt = function(context)
				return "Hey, I'd like to provide some context for future "
					.. "messages. Here is the code/text that I want to refer "
					.. "to in our upcoming conversations:\n\n"
					.. context
			end,
		},
		mappings = {
			["select_up"] = "<C-k>",
			["select_down"] = "<C-j>",
		},
		open_ai = {
			api_key = {
				-- env = "OPENAI_API_KEY",
				-- value = nil,

				-- `get` is is a function that retrieves an API key, can be used to override the default method.
				-- get = function() ... end
				-- Here is some code for a function that retrieves an API key. You can use it with
				-- the Linux 'pass' application.
				get = function()
					local file_path = "~/.config/nvim/env/OPENAI_API_KEY"
					local key = vim.fn.system("cat " .. file_path)
					key = string.gsub(key, "\n$", "")
					return key
				end,
			},
			base_url = {
				get = function()
					local file_path = "~/.config/nvim/env/OPENAI_BASE_URL"
					local base_url = vim.fn.system("cat " .. file_path)
					base_url = string.gsub(base_url, "\n$", "")
					return base_url
				end,
			},
		},

		shortcuts = {
			{
				name = "textify",
				key = "<leader>as",
				desc = "fix text with AI",
				use_context = true,
				prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
				modes = { "v" },
				strip_function = nil,
			},

			{
				name = "gitcommit",
				key = "<leader>ag",
				desc = "generate git commit message",
				use_context = false,
				prompt = function()
					return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
				end,
				modes = { "n" },
				strip_function = nil,
			},
		},
	})
end

function config.im_select(plugin, opts)
	require("im_select").setup({
		-- IM will be set to `default_im_select` in `normal` mode
		-- For Windows/WSL, default: "1033", aka: English US Keyboard
		-- For macOS, default: "com.apple.keylayout.ABC", aka: US
		-- For Linux, default:
		--               "keyboard-us" for Fcitx5
		--               "1" for Fcitx
		--               "xkb:us::eng" for ibus
		-- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
		default_im_select = "com.apple.keylayout.ABC",

		-- Can be binary's name or binary's full path,
		-- e.g. 'im-select' or '/usr/local/bin/im-select'
		-- For Windows/WSL, default: "im-select.exe"
		-- For macOS, default: "im-select"
		-- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
		default_command = "im-select",

		-- Restore the default input method state when the following events are triggered
		set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

		-- Restore the previous used input method state when the following events
		-- are triggered, if you don't want to restore previous used im in Insert mode,
		-- e.g. deprecated `disable_auto_restore = 1`, just let it empty
		-- as `set_previous_events = {}`
		set_previous_events = { "InsertEnter" },

		-- Show notification about how to install executable binary when binary missed
		keep_quiet_on_no_binary = false,

		-- Async run `default_command` to switch IM or not
		async_switch_im = true,
	})
end

function config.notify(plugin, opts)
	local codicons = require("codicons")
	local nvim_notify = require("notify")
	nvim_notify.setup({
		-- Animation style (see below for details)
		stages = "slide",
		-- Function called when a new window is opened, use for changing win settings/config
		on_open = nil,
		-- Function called when a window is closed
		on_close = nil,
		-- Render function for notifications. See notify-render()
		render = "default",
		-- Default timeout for notifications
		timeout = 2000,
		-- Max number of columns for messages
		max_width = nil,
		-- Max number of lines for a message
		max_height = nil,
		-- For stages that change opacity this is treated as the highlight behind the window
		-- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
		background_colour = "Normal",
		-- Minimum width for notification windows
		minimum_width = 36,
		-- Icons for the different levels
		icons = {
			ERROR = codicons.get("error"),
			WARN = codicons.get("warning"),
			INFO = codicons.get("info"),
			DEBUG = codicons.get("debug"),
			TRACE = codicons.get("search"),
		},
	})
	vim.notify = require("doodleVim.extend.misc").wrapped_notify
end

function config.todo()
	local codicons = require("codicons")
	require("todo-comments").setup({
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		-- keywords recognized as todo comments
		keywords = {
			FIX = {
				icon = codicons.get("tools"), -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = {
					"FIXME",
					"BUG",
					"FIXIT",
					"ISSUE",
					"ERROR",
				}, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = codicons.get("checklist"), color = "info" },
			HACK = { icon = codicons.get("flame"), color = "warning" },
			WARN = { icon = codicons.get("warning"), color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = codicons.get("clock"), color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = codicons.get("note"), color = "hint", alt = { "INFO" } },
		},
		gui_style = {
			fg = "NONE", -- The gui style to use for the fg highlight group.
			bg = "BOLD", -- The gui style to use for the bg highlight group.
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			multiline = true, -- enable multine todo comments
			multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
			multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
			before = "", -- "fg" or "bg" or empty
			keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\v(\s?\(.*\)|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = {}, -- list of file types to exclude highlighting
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of highlight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "#fb4934" },
			hack = { "#fe8019" },
			warning = { "#fabd2f" },
			info = { "#458588" },
			hint = { "#10B981" },
			default = { "#7C3AED" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS)(\s?\(.*\)|:)+]], -- ripgrep regex
		},
	})
end

return config
