local vim = vim
local global = require("doodleVim.core.global")

local M = {}

local function bind_option(options)
	for k, v in pairs(options) do
		if v == true then
			vim.cmd("set " .. k)
		elseif v == false then
			vim.cmd("set " .. "no" .. k)
		else
			vim.cmd("set " .. k .. "=" .. v)
		end
	end
end

M.load_options = function()
	local global_local = {
		termguicolors = true,
		mouse = "a",
		errorbells = true,
		visualbell = true,
		hidden = true,
		fileformats = "unix,mac,dos",
		magic = true,
		virtualedit = "block",
		encoding = "utf-8",
		viewoptions = "folds,cursor,curdir,slash,unix",
		clipboard = "unnamedplus",
		wildignorecase = true,
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
		backup = false,
		writebackup = false,
		directory = global.cache_dir .. "/swag/",
		undodir = global.cache_dir .. "/undo/",
		viewdir = global.cache_dir .. "/view/",
		spellfile = global.cache_dir .. "/spell/en.uft-8.add",
		history = 2000,
		smarttab = true,
		timeout = true,
		ttimeout = true,
		timeoutlen = 500,
		ttimeoutlen = 10,
		updatetime = 2000,
		redrawtime = 1500,
		ignorecase = true,
		smartcase = true,
		smartindent = true,
		infercase = true,
		incsearch = true,
		wrapscan = true,
		inccommand = "nosplit",
		grepformat = "%f:%l:%c:%m",
		grepprg = "rg --hidden --vimgrep --smart-case --",
		breakat = [[\ \	;:,!?]],
		startofline = false,
		whichwrap = "h,l,<,>,[,],~",
		splitbelow = true,
		splitright = true,
		switchbuf = "useopen",
		backspace = "indent,eol,start",
		diffopt = "filler,iwhite,internal,algorithm:patience",
		completeopt = "menu,menuone",
		complete = "",
		jumpoptions = "stack",
		showmode = false,
		shortmess = "aoOTIcF",
		scrolloff = 2,
		sidescrolloff = 5,
		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
		ruler = false,
		list = true,
		-- showtabline  = 2;
		winwidth = 30,
		winminwidth = 15,
		pumheight = 15,
		helpheight = 12,
		previewheight = 12,
		showcmd = false,
		cmdheight = 1,
		cmdwinheight = 5,
		equalalways = false,
		laststatus = 3,
		display = "lastline",
		showbreak = "↳",
		listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
		pumblend = 0,
		winblend = 0,
		fillchars = "eob: ",
		lazyredraw = true,
		synmaxcol = 200,
		foldcolumn = "0", -- '0' is not bad
		foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
		foldlevelstart = 99,
		foldenable = true,
	}

	local bw_local = {
		undofile = true,
		synmaxcol = 2500,
		formatoptions = "1jcroql",
		textwidth = 80,
		expandtab = true,
		autoindent = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = -1,
		breakindentopt = "shift:2,min:20",
		wrap = true,
		linebreak = true,
		-- colorcolumn    = "80";
		foldenable = true,
		signcolumn = "yes",
		conceallevel = 0,
		concealcursor = "niv",
	}

	vim.g.clipboard = {
		name = "myProvider",
		copy = {
			["+"] = "clipboard-provider copy",
			["*"] = "clipboard-provider copy",
		},
		paste = {
			["+"] = "clipboard-provider paste",
			["*"] = "clipboard-provider paste",
		},
		cache_enabled = 1,
	}

	vim.g.python_host_skip_check = 1
	vim.g.python3_host_skip_check = 1

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end
	bind_option(bw_local)
end

return M
