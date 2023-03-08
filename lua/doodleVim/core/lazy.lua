local fn, api = vim.fn, vim.api
local vim_path = require('doodleVim.core.global').vim_path
local data_dir = require('doodleVim.core.global').data_dir
local modules_dir = vim_path .. '/lua/doodleVim/modules'
local lazy = nil

local Lazy = {}
Lazy.__index = Lazy

local plugins = setmetatable({}, {
    __index = function(_, key)
        if not lazy then
            Lazy:load_packer()
        end
        return lazy[key]
    end
})

function Lazy:load_plugins()
    self.repos = {}

    local get_plugins_list = function()
        local list = {}
        local tmp = vim.split(fn.globpath(modules_dir, '*/plugins.lua'), '\n')
        for _, f in ipairs(tmp) do
            list[#list + 1] = f:sub(#modules_dir - 16, -1)
        end
        return list
    end

    local plugins_file = get_plugins_list()
    for _, m in ipairs(plugins_file) do
        local repos = require(m:sub(0, #m - 4))
        for repo, conf in pairs(repos) do
            self.repos[#self.repos + 1] = vim.tbl_extend('force', { repo }, conf)
        end
    end
end

function Lazy:load_lazy(install)
    local should_install = install or false
    if not lazy then
        api.nvim_command('packadd lazy.nvim')
        lazy = require("lazy")
    end

    self:load_plugins()
    lazy.setup(self.repos, {
        root = data_dir .. '/site/pack/lazy/opt',
        lockfile = data_dir .. "/lazy-lock.json",
        concurrency = 20,
        git = {
            log = { "--since=3 days ago" }, -- show commits from the last 3 days
            timeout = 120,                  -- kill processes that take more than 2 minutes
            url_format = "https://github.com/%s.git",
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
                disable_events = { "VimEnter", "BufReadPre" },
                ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
            },
            reset_packpath = true,   -- reset the package path to improve startup time
            rtp = {
                reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
                ---@type string[]
                paths = {},          -- add any custom paths here that you want to indluce in the rtp
                ---@type string[] list any plugins you want to disable here
                disabled_plugins = {
                    -- "gzip",
                    -- "tar",
                    -- "tarPlugin",
                    -- "zip",
                    -- "zipPlugin",
                    -- "getscript",
                    -- "getscriptPlugin",
                    -- "vimball",
                    -- "vimballPlugin",
                    -- "matchit",
                    -- "matchparen",
                    -- "2html_plugin",
                    -- "logiPat",
                    -- "rrhelper",
                    -- "netrw",
                    -- "netrwPlugin",
                    -- "netrwSettings",
                    -- "netrwFileHandlers",
                    -- "tutor_mode_plugin",
                    -- "remote_plugins",
                    -- "spellfile_plugin",
                    -- "shada_plugin",
                    -- "tohtml",
                    -- "spellfile",
                    -- "tutor",
                },
            },
        }
    })

    if should_install then
        lazy.install()
    end
end

function Lazy:init_ensure_plugins()
    local lazy_path = data_dir .. '/site/pack/lazy/opt/lazy.nvim'
    local should_install = false
    if not vim.loop.fs_stat(lazy_path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazy_path,
        })
        should_install = true
    end
    self:load_lazy(should_install)
    vim.opt.rtp:prepend(lazy_path)
end

function plugins.ensure_plugins()
    Lazy:init_ensure_plugins()
end

return plugins
