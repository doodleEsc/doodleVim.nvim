-- local fn = vim.fn
-- local api = vim.api
local global = require('core.global')
local defer = require('utils.defer')
-- local event = require('core.event')
local pack = require('core.pack')

-- local function check_packer()
-- 	local install_path = global.data_dir .. 'pack/packer/start/packer.nvim'
-- 	if fn.empty(fn.glob(install_path)) > 0 then
-- 	  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
-- 	  api.nvim_command 'packadd packer.nvim'
-- 	end
-- end

-- Create cache dir and subs dir
local createdir = function ()
  local data_dir = {
    global.cache_dir..'backup',
    global.cache_dir..'session',
    global.cache_dir..'swap',
    global.cache_dir..'tags',
    global.cache_dir..'undo'
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
  if vim.fn.isdirectory(global.cache_dir) == 0 then
    os.execute("mkdir -p " .. global.cache_dir)
    for _,v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

local disable_distribution_plugins= function()
  vim.g.loaded_gzip              = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_netrw             = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
end

local set_leader_map = function()
  vim.api.nvim_set_keymap('n',' ','',{noremap = true})
  vim.api.nvim_set_keymap('x',' ','',{noremap = true})
  vim.api.nvim_set_keymap('i', '<C-c>', '<esc>', {noremap=true})
  vim.api.nvim_set_keymap('n', '<C-c>', '<esc>', {noremap=true})
  vim.api.nvim_set_keymap('v', '<C-c>', '<esc>', {noremap=true})
  vim.g.mapleader = " "
end

local set_colorscheme = function()
	vim.cmd[[colorscheme gruvbox]]
end

local function load_nvim_config()
	-- check_packer()
	createdir()
	disable_distribution_plugins()
	set_leader_map()

	pack.ensure_plugins()
	pack.load_compile()
	require('core.options')
	require('core.mapping')
	require('core.event')
	require('core.command')
	require('keymap')
	set_colorscheme()
	defer.load(250)
end

load_nvim_config()
