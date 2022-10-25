local vim = vim
local autocmd = {}

local function create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function autocmd.load_autocmds()
    local definitions = {
        ft = {
            { "BufReadPost,BufNewFile", "*.sol", " setf solidity" },
            { "FileType", "Outline", " setlocal signcolumn=no" },
            { "FileType", "python", " setlocal colorcolumn=80" }
        },

        _general_settings = {
            { "FileType", "qf,help,man,lspinfo", "nnoremap <silent> <buffer> q :close<CR>" },
            { "TextYankPost", "*", "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=200})" },
            { "VimResized", "*", "tabdo wincmd =" },
        },

        _markdown = {
            { "FileType", "markdown", "setlocal wrap" },
            { "FileType", "markdown", "setlocal spell" }
        },

        _git = {
            { "FileType", "gitcommit", "setlocal wrap" },
            { "FileType", "gitcommit", "setlocal spell" }
        },
        _packer = {
            { "User", "PackerCompileDone", "++once", "lua require('doodleVim.extend.packer').PostPackerCompileDone()" }
        }
    }

    create_augroups(definitions)
end

return autocmd
