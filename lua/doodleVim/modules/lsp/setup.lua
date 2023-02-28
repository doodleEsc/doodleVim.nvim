local lsp = {}

function lsp.mason(plugin)
    require('doodleVim.extend.lazy').add('mason', function()
        local binaries = {
            'gopls',
            'json-lsp',
            'lua-language-server',
            'python-lsp-server',
            'delve',
            'gotests',
            'gomodifytags',
            'impl',
            'clangd',
            'debugpy',
            'ruff',
            'solhint',
        }
        local register = require('mason-registry')
        local bins = ''
        for _, bin in ipairs(binaries) do
            if not register.is_installed(bin) then
                bins = bins .. ' ' .. bin
            end
        end
        if #bins > 0 then
            vim.cmd('MasonInstall' .. bins)
        end
    end)
end

function lsp.lsp_signature(plugin)
    require("doodleVim.extend.lsp").register_on_attach(function(client, bufnr)
        require "lsp_signature".on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            handler_opts = {
                border = "rounded"
            }
        }, bufnr)
    end)
end

function lsp.nvim_lspconfig(plugin)
    -- require("doodleVim.utils.defer").defer_load("", )
end
return lsp
