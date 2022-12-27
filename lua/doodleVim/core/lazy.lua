local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require('doodleVim.core.global').vim_path
local data_dir = require('doodleVim.core.global').data_dir
-- local doodleVim_dir = vim_path .. '/lua/doodleVim'
local modules_dir = vim_path .. '/lua/doodleVim/modules'
-- local packer_compiled = data_dir .. 'packer_compiled.vim'
-- local compile_to_lua = vim_path .. '/lua/doodleVim/compiled.lua'
-- local utils = require("doodleVim.utils.utils")
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

function Lazy:load_lazy()
    if not lazy then
        api.nvim_command('packadd lazy.nvim')
        lazy = require('lazy')
    end
    -- packer.init({
    --     compile_path = packer_compiled,
    --     -- git = { clone_timeout = 120 },
    --     git = {
    --         cmd = 'git', -- The base command for git operations
    --         subcommands = { -- Format strings for git subcommands
    --             update         = 'pull --ff-only --progress --rebase=false',
    --             install        = 'clone --depth %i --no-single-branch --progress',
    --             fetch          = 'fetch --depth 999999 --progress',
    --             checkout       = 'checkout %s --',
    --             update_branch  = 'merge --ff-only @{u}',
    --             current_branch = 'branch --show-current',
    --             diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
    --             diff_fmt       = '%%h %%s (%%cr)',
    --             get_rev        = 'rev-parse --short HEAD',
    --             get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
    --             submodules     = 'submodule update --init --recursive --progress'
    --         },
    --         depth = 1, -- Git clone depth
    --         clone_timeout = 60, -- Timeout, in seconds, for git clones
    --         default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
    --     },
    --     disable_commands = true
    -- })
    -- packer.reset()
    -- local use = packer.use
    -- self:load_plugins()
    -- use { "wbthomason/packer.nvim", opt = true }
    -- for _, repo in ipairs(self.repos) do
    --     use(repo)
    -- end

    self:load_plugins()
    lazy.setup(self.repos, {
        root = data_dir .. '/site/pack/lazy/opt',
        lockfile = data_dir .. "/lazy-lock.json",
        git = {
            log = { "--since=3 days ago" }, -- show commits from the last 3 days
            timeout = 120, -- kill processes that take more than 2 minutes
            url_format = "https://github.com/%s.git",
        },
    })
end

function Lazy:init_ensure_plugins()
    local lazy_dir = data_dir .. '/site/pack/lazy/opt/lazy.nvim'
    if not vim.loop.fs_stat(lazy_dir) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazy_dir,
        })
        self:load_lazy()
        lazy.install()
    end
    self:load_lazy()
end

function plugins.ensure_plugins()
    Lazy:init_ensure_plugins()
end

return plugins
