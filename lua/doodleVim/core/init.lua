local global = require("doodleVim.core.global")
local lazy = require("doodleVim.core.lazy")
local event = require("doodleVim.core.event")
local command = require("doodleVim.core.command")
local options = require("doodleVim.core.options")

-- Create cache dir and subs dir
local createdir = function()
	local data_dir = {
		global.cache_dir .. "/backup",
		global.cache_dir .. "/session",
		global.cache_dir .. "/swap",
		global.cache_dir .. "/tags",
		global.cache_dir .. "/undo",
	}
	-- There only check once that If cache_dir exists
	-- Then I don't want to check subs dir exists
	if not vim.loop.fs_stat(global.cache_dir) then
		vim.fn.system({ "mkdir", "-p", global.cache_dir })
		for _, v in pairs(data_dir) do
			if not vim.loop.fs_stat(v) == 0 then
				vim.fn.system({ "mkdir", "-p", v })
			end
		end
	end
end

local set_leader_map = function()
	vim.g.mapleader = " "
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("i", "<C-c>", "<esc>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<C-c>", "<esc>", { noremap = true })
	vim.api.nvim_set_keymap("v", "<C-c>", "<esc>", { noremap = true })
end

local set_colorscheme = function()
	vim.cmd.colorscheme("gruvbox")
end

local function load_nvim_config()
	createdir()
	lazy.ensure_lazy_installed()
	options.load_options()
	set_leader_map()
	set_colorscheme()
	event.load_autocmds()
	lazy.setup_lazy()
	command.load_user_command()
end

load_nvim_config()
