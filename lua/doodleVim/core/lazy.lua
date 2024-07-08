local vim = vim
local vim_path = require("doodleVim.core.global").vim_path
local data_dir = require("doodleVim.core.global").data_dir
local modules_dir = vim_path .. "/lua/doodleVim/modules"

local Lazy = {}
local load_plugins = function()
	local repos = {}

	local get_plugins_list = function()
		local list = {}
		local tmp = vim.split(vim.fn.globpath(modules_dir, "*/plugins.lua"), "\n")
		for _, f in ipairs(tmp) do
			list[#list + 1] = f:sub(#modules_dir - 16, -1)
		end
		return list
	end

	local plugins_file = get_plugins_list()
	for _, m in ipairs(plugins_file) do
		local mrepos = require(m:sub(0, #m - 4))
		for repo, conf in pairs(mrepos) do
			repos[#repos + 1] = vim.tbl_extend("force", { repo }, conf)
		end
	end

	return repos
end

function Lazy.ensure_lazy_installed()
	local lazypath = vim.fn.stdpath("data") .. "/site/pack/lazy/opt/lazy.nvim"
	vim.print(lazypath)
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)
end

function Lazy.setup_lazy()
	local repos = load_plugins()

	require("lazy").setup({
		root = data_dir .. "/site/pack/lazy/opt",
		lockfile = data_dir .. "/lazy-lock.json",
		concurrency = 20,
		spec = repos,
		git = {
			log = { "--since=5 days ago" }, -- show commits from the last 5 days
			timeout = 120, -- kill processes that take more than 2 minutes
			url_format = "https://github.com/%s.git",
		},
		dev = {
			-- directory where you store your local plugin projects
			path = "~/Projects",
			---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
			patterns = {}, -- For example {"folke"}
			fallback = false, -- Fallback to git when local plugin doesn't exist
		},
		install = {
			-- install missing plugins on startup. This doesn't increase startup time.
			missing = true,
		},
		ui = {
			wrap = true, -- wrap the lines in the ui
			border = "rounded",
		},
		performance = {
			cache = {
				enabled = true,
				path = vim.fn.stdpath("cache") .. "/lazy/cache",
				-- Once one of the following events triggers, caching will be disabled.
				-- To cache all modules, set this to `{}`, but that is not recommended.
				-- The default is to disable on:
				--  * VimEnter: not useful to cache anything else beyond startup
				--  * BufReadPre: this will be triggered early when opening a file from the command line directly
				-- disable_events = { "VimEnter", "BufReadPre" },
				disable_events = {},
				ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
			},
			reset_packpath = true, -- reset the package path to improve startup time
			rtp = {
				reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
				---@type string[]
				paths = {}, -- add any custom paths here that you want to indluce in the rtp
				---@type string[] list any plugins you want to disable here
				disabled_plugins = {
					"gzip",
					"tar",
					"tarPlugin",
					"zip",
					"zipPlugin",
					"getscript",
					"getscriptPlugin",
					"vimball",
					"vimballPlugin",
					"matchit",
					"matchparen",
					"2html_plugin",
					"logiPat",
					"rrhelper",
					"netrw",
					"netrwPlugin",
					"netrwSettings",
					"netrwFileHandlers",
					"tutor_mode_plugin",
					"remote_plugins",
					"spellfile_plugin",
					"shada_plugin",
					"tohtml",
					"spellfile",
					"tutor",
				},
			},
		},
		checker = { enabled = true },
	})
end

return Lazy
