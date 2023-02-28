local global = require('doodleVim.core.global')
local lazy = require('doodleVim.core.lazy')
local event = require('doodleVim.core.event')
local command = require('doodleVim.core.command')
local options = require('doodleVim.core.options')

-- Create cache dir and subs dir
local createdir = function()
    local data_dir = {
        global.cache_dir .. '/backup',
        global.cache_dir .. '/session',
        global.cache_dir .. '/swap',
        global.cache_dir .. '/tags',
        global.cache_dir .. '/undo'
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

local disable_distribution_plugins = function()
    vim.g.loaded_gzip               = 1
    vim.g.loaded_tar                = 1
    vim.g.loaded_tarPlugin          = 1
    vim.g.loaded_zip                = 1
    vim.g.loaded_zipPlugin          = 1
    vim.g.loaded_getscript          = 1
    vim.g.loaded_getscriptPlugin    = 1
    vim.g.loaded_vimball            = 1
    vim.g.loaded_vimballPlugin      = 1
    vim.g.loaded_matchit            = 1
    vim.g.loaded_matchparen         = 1
    vim.g.loaded_2html_plugin       = 1
    vim.g.loaded_logiPat            = 1
    vim.g.loaded_rrhelper           = 1
    vim.g.loaded_netrw              = 1
    vim.g.loaded_netrwPlugin        = 1
    vim.g.loaded_netrwSettings      = 1
    vim.g.loaded_netrwFileHandlers  = 1
    vim.g.netrw_liststyle           = 3
    vim.g.loaded_tutor_mode_plugin  = 1
    vim.g.loaded_remote_plugins     = 1
    vim.g.loaded_shada_plugin       = 1
    vim.g.did_install_default_menus = 1
    vim.g.did_install_syntax_menu   = 1
    vim.g.did_load_filetypes        = 1
    vim.g.loaded_syntax_completion  = 1
    vim.g.loaded_spellfile_plugin   = 1
    vim.g.loaded_sql_completion     = 1
end

local set_leader_map = function()
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap('n', ' ', '', { noremap = true })
    vim.api.nvim_set_keymap('x', ' ', '', { noremap = true })
    vim.api.nvim_set_keymap('i', '<C-c>', '<esc>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-c>', '<esc>', { noremap = true })
    vim.api.nvim_set_keymap('v', '<C-c>', '<esc>', { noremap = true })
end

local set_colorscheme = function()
    vim.cmd [[colorscheme gruvbox]]
end

local function load_nvim_config()
    disable_distribution_plugins()
    createdir()
    set_leader_map()
    set_colorscheme()

    options.load_options()
    event.load_autocmds()
    command.load_user_command()
    lazy.ensure_plugins()
end

load_nvim_config()
