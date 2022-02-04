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
		mappings = {'<C-u>', '<C-d>'},
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

function config.lspaction()
	require("lspaction").setup()
end

return config
