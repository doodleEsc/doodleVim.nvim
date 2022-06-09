local M = {}

local icons = require("doodleVim.utils.icons")

M.lsp_highlight_document = function(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]       ,
            false
        )
    end
end

M.lsp_hover = function()
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
end

M.lsp_diagnostic = function()
    vim.diagnostic.config({
        underline = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = "rounded",
            focusable = false,
            header = { icons.diag.debug_sign .. ' Diagnostics:' },
            source = 'always',
        },
        virtual_text = {
            spacing = 4,
            source = 'always',
            severity = {
                min = vim.diagnostic.severity.HINT,
            },
        },
    })

    require("doodleVim.extend.diagnostics").setup({
        error_sign = icons.diag.error_sign,
        warn_sign = icons.diag.warn_sign,
        hint_sign = icons.diag.hint_sign,
        infor_sign = icons.diag.infor_sign,
        debug_sign = icons.diag.debug_sign,
        use_diagnostic_virtual_text = false,
    })
end

M.null_ls_depress = function()
    -- from null-ls to other lsp clients
    -- @see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/197#issuecomment-922792992
    local default_exe_handler = vim.lsp.handlers['workspace/executeCommand']
    vim.lsp.handlers['workspace/executeCommand'] = vim.lsp.with(function(err, result, ctx, config)
        -- supress NULL_LS error msg
        local prefix = 'NULL_LS'
        if err and ctx.params.command:sub(1, #prefix) == prefix then
            return
        end
        return default_exe_handler(err, result, ctx, config)
    end, { float = { border = "rounded" } })
end

return M
