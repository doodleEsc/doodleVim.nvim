local config = {}

function config.comment()
	require("Comment").setup({
		padding = true,
		sticky = true,
		ignore = nil,
	})
end

function config.neoscroll()
	require("neoscroll").setup({
		-- All these keys will be mapped to their corresponding default scrolling animation
		mappings = { "<C-f>", "<C-b>" },
		hide_cursor = false, -- Hide cursor while scrolling
		stop_eof = true, -- Stop at <EOF> when scrolling downwards
		use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
		respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
		cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
		easing_function = nil, -- Default easing function
		pre_hook = nil, -- Function to run before the scrolling animation starts
		post_hook = nil, -- Function to run after the scrolling animation ends
		performance_mode = false,
	})
end

function config.hop()
	require("hop").setup()
end

function config.nvim_surround()
	require("nvim-surround").setup({
		keymaps = {
			insert = "<C-y>s",
			insert_line = "<C-y>l",
			normal = "ys",
			normal_cur = "yss",
			normal_line = "yl",
			normal_cur_line = "yll",
			visual = "s",
			visual_line = "gl",
			delete = "ds",
			change = "cs",
		},
	})
end

function config.codewindow(plugin)
	require("codewindow").setup({
		active_in_terminals = false, -- Should the minimap activate for terminal buffers
		auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
		exclude_filetypes = {
			"NvimTree",
			"Outline",
		}, -- Choose certain filetypes to not show minimap on
		max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
		max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
		minimap_width = 20, -- The width of the text part of the minimap
		use_lsp = true, -- Use the builtin LSP to show errors and warnings
		use_treesitter = true, -- Use nvim-treesitter to highlight the code
		use_git = true, -- Show small dots to indicate git additions and deletions
		width_multiplier = 4, -- How many characters one dot represents
		z_index = 1, -- The z-index the floating window will be on
		show_cursor = true, -- Show the cursor position in the minimap
		window_border = "single", -- The border style of the floating window (accepts all usual options)
	})
end

function config.treesitter(plugin, opts)
	require("nvim-treesitter.configs").setup({
		sync_install = true,
		auto_install = false,
		highlight = {
			enable = true,
			disable = {
				"lua",
				"help",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["as"] = "@statement.outer",
					["ah"] = "@call.outer",
					["ih"] = "@call.inner",
				},
			},
		},
	})
end

function config.barbar(plugin, opts)
	-- Set barbar's options
	require("barbar").setup({
		-- Enable/disable animations
		animation = true,

		-- Enable/disable auto-hiding the tab bar when there is a single buffer
		auto_hide = false,

		-- Enable/disable current/total tabpages indicator (top right corner)
		tabpages = true,

		-- Enables/disable clickable tabs
		--  - left-click: go to buffer
		--  - middle-click: delete buffer
		clickable = true,

		-- Excludes buffers from the tabline
		exclude_ft = {
			"alpha",
			"dap-repl",
		},
		exclude_name = { "alpha" },

		-- A buffer to this direction will be focused (if it exists) when closing the current buffer.
		-- Valid options are 'left' (the default) and 'right'
		focus_on_close = "left",

		-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
		hide = {
			extensions = true,
			inactive = false,
		},

		-- Disable highlighting alternate buffers
		highlight_alternate = false,

		-- Disable highlighting file icons in inactive buffers
		highlight_inactive_file_icons = false,

		-- Enable highlighting visible buffers
		highlight_visible = true,

		icons = {
			-- Configure the base icons on the bufferline.
			buffer_index = true,
			buffer_number = false,
			button = "×",
			-- Enables / disables diagnostic symbols
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = false, icon = " " },
				[vim.diagnostic.severity.WARN] = { enabled = false },
				[vim.diagnostic.severity.INFO] = { enabled = false },
				[vim.diagnostic.severity.HINT] = { enabled = false },
			},
			filetype = {
				-- Sets the icon's highlight group.
				-- If false, will use nvim-web-devicons colors
				custom_colors = false,
				-- Requires `nvim-web-devicons` if `true`
				enabled = true,
			},
			separator = { left = "│", right = "" },
			separator_at_end = true,
			-- Configure the icons on the bufferline when modified or pinned.
			-- Supports all the base icon options.
			modified = { button = "●" },
			pinned = { button = "車" },
			-- Configure the icons on the bufferline based on the visibility of a buffer.
			-- Supports all the base icon options, plus `modified` and `pinned`.
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = true },
			inactive = { button = "×", buffer_index = true },
			visible = { modified = { buffer_number = false } },
		},

		-- If true, new buffers will be inserted at the start/end of the list.
		-- Default is to insert after current buffer.
		insert_at_end = true,
		insert_at_start = false,

		-- Sets the maximum padding width with which to surround each tab
		maximum_padding = 1,

		-- Sets the minimum padding width with which to surround each tab
		minimum_padding = 1,

		-- Sets the maximum buffer name length.
		maximum_length = 30,

		-- If set, the letters for each buffer in buffer-pick mode will be
		-- assigned based on their name. Otherwise or in case all letters are
		-- already assigned, the behavior is to assign letters in order of
		-- usability (see order below)
		semantic_letters = true,

		-- Set the filetypes which barbar will offset itself for
		sidebar_filetypes = {
			-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
			NvimTree = true,
			-- Or, specify the text used for the offset:
			undotree = {
				text = "undotree",
				align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
			},
			-- Or, specify the event which the sidebar executes when leaving:
			["neo-tree"] = { event = "BufWipeout" },
			-- Or, specify all three
			Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
		},

		-- New buffer letters are assigned in this order. This order is
		-- optimal for the qwerty keyboard layout but might need adjustment
		-- for other layouts.
		letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

		-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
		-- where X is the buffer number. But only a static string is accepted here.
		no_name_title = nil,
	})
end

function config.blankline()
	-- local highlight = {
	-- 	"CursorColumn",
	-- 	"Whitespace",
	-- }
	-- require("ibl").setup({
	-- 	indent = { highlight = highlight, char = "" },
	-- 	whitespace = {
	-- 		highlight = highlight,
	-- 		remove_blankline_trail = false,
	-- 	},
	-- 	scope = { enabled = false },
	-- })
	require("ibl").setup({
		indent = {
			char = "▎",
			tab_char = nil,
			highlight = "IblIndent",
			smart_indent_cap = true,
			priority = 1,
			repeat_linebreak = true,
		},
		whitespace = {
			-- highlight = highlight,
			remove_blankline_trail = true,
		},
		scope = { enabled = false },
	})
end

function config.lualine()
	require("doodleVim.modules.editor.lualine")
end

function config.gitsigns()
	require("gitsigns").setup({
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
		},
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
end

function config.barbecue(plugin, opts)
	local codicons = require("codicons")
	require("barbecue").setup({
		---Whether to attach navic to language servers automatically.
		---
		---@type boolean
		attach_navic = true,
		---Whether to create winbar updater autocmd.
		---
		---@type boolean
		create_autocmd = true,
		---Buftypes to enable winbar in.
		---
		---@type string[]
		include_buftypes = { "" },
		---Filetypes not to enable winbar in.
		---
		---@type string[]
		exclude_filetypes = { "gitcommit", "toggleterm", "DressingInput" },
		modifiers = {
			---Filename modifiers applied to dirname.
			---
			---See: `:help filename-modifiers`
			---
			---@type string
			dirname = ":~:.",
			---Filename modifiers applied to basename.
			---
			---See: `:help filename-modifiers`
			---
			---@type string
			basename = "",
		},
		---Whether to display path to file.
		---
		---@type boolean
		show_dirname = false,
		---Whether to display file name.
		---
		---@type boolean
		show_basename = true,
		---Whether to replace file icon with the modified symbol when buffer is
		---modified.
		---
		---@type boolean
		show_modified = false,
		---Get modified status of file.
		---
		---NOTE: This can be used to get file modified status from SCM (e.g. git)
		---
		---@type fun(bufnr: number): boolean
		modified = function(bufnr)
			return vim.bo[bufnr].modified
		end,
		---Whether to show/use navic in the winbar.
		---
		---@type boolean
		show_navic = true,
		---Get leading custom section contents.
		---
		---NOTE: This function shouldn't do any expensive actions as it is run on each
		---render.
		---
		---@type fun(bufnr: number): barbecue.Config.custom_section
		lead_custom_section = function()
			return " "
		end,
		---@alias barbecue.Config.custom_section
		---|string # Literal string.
		---|{ [1]: string, [2]: string? }[] # List-like table of `[text, highlight?]` tuples in which `highlight` is optional.
		---
		---Get custom section contents.
		---
		---NOTE: This function shouldn't do any expensive actions as it is run on each
		---render.
		---
		---@type fun(bufnr: number): barbecue.Config.custom_section
		custom_section = function()
			return " "
		end,
		---@alias barbecue.Config.theme
		---|'"auto"' # Use your current colorscheme's theme or generate a theme based on it.
		---|string # Theme located under `barbecue.theme` module.
		---|barbecue.Theme # Same as '"auto"' but override it with the given table.
		---
		---Theme to be used for generating highlight groups dynamically.
		---
		---@type barbecue.Config.theme

		theme = {
			-- this highlight is used to override other highlights
			-- you can take advantage of its `bg` and set a background throughout your winbar
			-- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
			normal = { fg = "#bdae93", bg = "#32302f" },
			-- these highlights correspond to symbols table from config
			ellipsis = { fg = "#bdae93" },
			separator = { fg = "#737aa2" },
			modified = { fg = "#fb4934" },
			-- these highlights represent the _text_ of three main parts of barbecue
			dirname = { fg = "#83a598" },
			basename = { bold = true },
			context = {},
			-- these highlights are used for context/navic icons
			context_module = { fg = "#fe8019" },
			context_field = { fg = "#d3869b" },
			context_file = { fg = "#83a598" },
			context_boolean = { fg = "#fe8019" },
			context_string = { fg = "#b8bb26" },
			context_operator = { fg = "#fb4934" },
			context_null = { fg = "#fe8019" },
			context_event = { fg = "#fabd2f" },
			context_namespace = { fg = "#83a598" },
			context_class = { fg = "#fabd2f" },
			context_method = { fg = "#83a598" },
			context_property = { fg = "#8ec07c" },
			context_constructor = { fg = "#83a598" },
			context_enum = { fg = "#d3869b" },
			context_interface = { fg = "#b8bb26" },
			context_package = { fg = "#8ec07c" },
			context_constant = { fg = "#fe8019" },
			context_object = { fg = "#fe8019" },
			context_key = { fg = "#8ec07c" },
			context_enum_member = { fg = "#fabd2f" },
			context_struct = { fg = "#d3869b" },
			context_array = { fg = "#fe8019" },
			context_type_parameter = { fg = "#fb4934" },
			context_function = { fg = "#83a598" },
			context_variable = { fg = "#d3869b" },
			context_number = { fg = "#fe8019" },
		},
		---Whether context text should follow its icon's color.
		---
		---@type boolean
		context_follow_icon_color = false,
		symbols = {
			---Modification indicator.
			---
			---@type string
			modified = "●",
			---Truncation indicator.
			---
			---@type string
			ellipsis = "…",
			---Entry separator.
			---
			---@type string
			separator = "",
		},
		---@alias barbecue.Config.kinds
		---|false # Disable kind icons.
		---|table<string, string> # Type to icon mapping.
		---
		---Icons for different context entry kinds.
		---
		---@type barbecue.Config.kinds
		kinds = {
			File = codicons.get("symbol-file"),
			Module = codicons.get("symbol-module"),
			Namespace = codicons.get("symbol-namespace"),
			Package = codicons.get("symbol-package"),
			Class = codicons.get("symbol-class"),
			Method = codicons.get("symbol-method"),
			Property = codicons.get("symbol-property"),
			Field = codicons.get("symbol-field"),
			Constructor = codicons.get("symbol-constructor"),
			Enum = codicons.get("symbol-enum"),
			Interface = codicons.get("symbol-interface"),
			Function = codicons.get("symbol-function"),
			Variable = codicons.get("symbol-variable"),
			Constant = codicons.get("symbol-constant"),
			String = codicons.get("symbol-string"),
			Number = codicons.get("symbol-number"),
			Boolean = codicons.get("symbol-boolean"),
			Array = codicons.get("symbol-array"),
			Object = codicons.get("symbol-object"),
			Key = codicons.get("symbol-key"),
			Null = codicons.get("symbol-null"),
			EnumMember = codicons.get("symbol-enum-member"),
			Struct = codicons.get("symbol-struct"),
			Event = codicons.get("symbol-event"),
			Operator = codicons.get("symbol-operator"),
			TypeParameter = codicons.get("symbol-type-parameter"),
			Component = codicons.get("symbol-misc"),
			Fragment = codicons.get("symbol-misc"),
		},
	})
end

return config
