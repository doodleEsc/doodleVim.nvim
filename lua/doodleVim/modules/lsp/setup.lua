local lsp = {}

function lsp.mason(plugin)
    require('doodleVim.extend.lazy').add('mason', function()
        local binaries = { 'gopls', 'json-lsp', 'lua-language-server', 'python-lsp-server', 'delve',
            'gotests', 'gomodifytags', 'impl', 'clangd', 'debugpy' }
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

return lsp
