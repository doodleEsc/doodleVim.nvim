local config = {}

-- function config.easymotion()
-- 	vim.api.nvim_set_keymap('n', '<Leader>s', '<Plug>(easymotion-overwin-f2)', {})
-- end

-- function config.easyalign()
-- 	vim.api.nvim_set_keymap('x', 'ma', '<Plug>(EasyAlign)', {})
-- 	vim.api.nvim_set_keymap('n', 'ma', '<Plug>(EasyAlign)<CR>', {})
-- end

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
		  alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
		  -- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
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
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
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
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
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
	require('nvim-autopairs').setup{}
	require("nvim-autopairs.completion.cmp").setup({
	  map_cr = true, --  map <CR> on insert mode
	  map_complete = true, -- it will auto insert `(` after select function or method item
	  auto_select = true -- automatically select the first item
	})
end

function config.blankline()
  require("indent_blankline").setup {
    show_end_of_line = true,
  }
end

function config.neoscroll()
	require('neoscroll').setup({
		-- All these keys will be mapped to their corresponding default scrolling animation
		mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
					'<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
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

return config
