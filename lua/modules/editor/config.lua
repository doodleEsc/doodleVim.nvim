local config = {}

function config.todo()
	-- require("todo-comments").setup {}
	require("todo-comments").setup{
	 signs = true, -- show icons in the signs column
	  sign_priority = 8, -- sign priority
	  -- keywords recognized as todo comments
	  keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = {
				"FIXME", "BUG", "FIXIT", "ISSUE", "ERROR",
				"fixme", "bug", "fixit", "issue", "error"
			}, -- a set of other keywords that all map to this FIX keywords
		  -- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info", alt = { "todo" } },
		HACK = { icon = " ", color = "warning" , alt = { "hack" }},
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warning", "xxx", "warn" } },
		PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
	  },
	  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	  -- highlighting of the line containing the todo comment
	  -- * before: highlights before the keyword (typically comment characters)
	  -- * keyword: highlights of the keyword
	  -- * after: highlights after the keyword (todo text)
	  highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:+\s*]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	  },
	  -- list of named colors where we try to extract the guifg from the
	  -- list of hilight groups or use the hex color if hl not found as a fallback
	  colors = {
		error = {"#DC2626" },
		warning = {"#FBBF24" },
		info = {"#2563EB" },
		hint = {"#10B981" },
		default = {"#7C3AED" },
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
		pattern = [[\b(KEYWORDS)\s*:]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
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

function config.autopairs()
	if not packer_plugins['nvim-cmp'].loaded then
	  vim.cmd [[PackerLoad nvim-cmp]]
	end
	local cmp = require("cmp")

	require('nvim-autopairs').setup{}
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

function config.neoscroll()
	require('neoscroll').setup({
		-- All these keys will be mapped to their corresponding default scrolling animation
		mappings = {'<C-f>', '<C-b>'},
		hide_cursor = false,          -- Hide cursor while scrolling
		stop_eof = true,             -- Stop at <EOF> when scrolling downwards
		use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
		respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
		cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
		easing_function = nil,        -- Default easing function
		pre_hook = nil,              -- Function to run before the scrolling animation starts
		post_hook = nil,              -- Function to run after the scrolling animation ends
	})
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
		icon_separator_active = '│',
		icon_separator_inactive = '│',
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

function config.hop()
	require'hop'.setup()
end

return config
