local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require('doodleVim.core.global').vim_path
local data_dir = require('doodleVim.core.global').data_dir
local doodleVim_dir = vim_path .. '/lua/doodleVim'
local modules_dir = vim_path .. '/lua/doodleVim/modules'
local packer_compiled = data_dir .. 'packer_compiled.vim'
local compile_to_lua = vim_path .. '/lua/doodleVim/compiled.lua'
local utils = require("doodleVim.utils.utils")
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_plugins()
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

function Packer:load_packer()
    if not packer then
        api.nvim_command('packadd packer.nvim')
        packer = require('packer')
    end
    packer.init({
        compile_path = packer_compiled,
        -- git = { clone_timeout = 120 },
        git = {
            cmd = 'git', -- The base command for git operations
            subcommands = { -- Format strings for git subcommands
                update         = 'pull --ff-only --progress --rebase=false',
                install        = 'clone --depth %i --no-single-branch --progress',
                fetch          = 'fetch --depth 999999 --progress',
                checkout       = 'checkout %s --',
                update_branch  = 'merge --ff-only @{u}',
                current_branch = 'branch --show-current',
                diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
                diff_fmt       = '%%h %%s (%%cr)',
                get_rev        = 'rev-parse --short HEAD',
                get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
                submodules     = 'submodule update --init --recursive --progress'
            },
            depth = 1, -- Git clone depth
            clone_timeout = 600, -- Timeout, in seconds, for git clones
            default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
        },
        disable_commands = true
    })
    packer.reset()
    local use = packer.use
    self:load_plugins()
    use { "wbthomason/packer.nvim", opt = true }
    for _, repo in ipairs(self.repos) do
        use(repo)
    end
end

function Packer:init_ensure_plugins()
    local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
    local state = uv.fs_stat(packer_dir)
    if not state then
        local cmd = "!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. packer_dir
        api.nvim_command(cmd)
        self:load_packer()
        packer.install()
    end
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        if not packer then
            Packer:load_packer()
        end
        return packer[key]
    end
})

function plugins.ensure_plugins()
    Packer:init_ensure_plugins()
end

function plugins.convert_compile_file()
    local lines = {}
    local lnum = 1
    lines[#lines + 1] = 'vim.cmd [[packadd packer.nvim]]\n'

    for line in io.lines(packer_compiled) do
        lnum = lnum + 1
        if lnum > 15 then
            lines[#lines + 1] = line .. '\n'
            if line == 'END' then
                break
            end
        end
    end
    table.remove(lines, #lines)

    if vim.fn.filereadable(compile_to_lua) == 1 then
        os.remove(compile_to_lua)
    end

    local file = io.open(compile_to_lua, "w")
    for _, line in ipairs(lines) do
        file:write(line)
    end
    file:close()

    os.remove(packer_compiled)
    vim.notify("`compiled.lua` Generated")
end

function plugins.auto_compile()
    local file = vim.fn.expand('%:p')
    if file:match(doodleVim_dir) then
        utils.remove_cached_package("^doodleVim")
        plugins.compile()
    end
end

function plugins.load_compile()
    if vim.fn.filereadable(compile_to_lua) == 1 then
        require('doodleVim.compiled')
    else
        assert('Missing packer compile file Run PackerCompile Or PackerInstall to fix')
    end
    vim.cmd [[command! PackerCompile lua require('doodleVim.core.pack').compile()]]
    vim.cmd [[command! PackerInstall lua require('doodleVim.core.pack').install()]]
    vim.cmd [[command! PackerUpdate lua require('doodleVim.core.pack').update()]]
    vim.cmd [[command! PackerSync lua require('doodleVim.core.pack').sync()]]
    vim.cmd [[command! PackerClean lua require('doodleVim.core.pack').clean()]]
    vim.cmd [[autocmd User PackerComplete lua require('doodleVim.core.pack').compile()]]
    vim.cmd [[autocmd User PackerCompileDone lua require('doodleVim.core.pack').convert_compile_file()]]
    vim.cmd [[command! PackerStatus  lua require('doodleVim.core.pack').status()]]
    vim.cmd [[command! -bang -nargs=+ -complete=customlist,v:lua.require'packer'.loader_complete PackerLoad lua require('packer').loader(<f-args>, '<bang>' == '!')]]
end

return plugins
