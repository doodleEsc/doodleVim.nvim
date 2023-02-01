local lsp = {}

local function file_and_details_entry(opts)
    opts = opts or {}
    local displayer = require('telescope.pickers.entry_display').create {
        separator = "│ ",
        items = {
            { width = 8 },
            { width = 0.5 },
            { remaining = true },
        },
    }

    local make_display = function(entry)
        local filename = require('telescope.utils').transform_path(opts, entry.filename)
        local line_info = { table.concat({ entry.lnum, entry.col }, ":"), "TelescopeResultsLineNr" }
        return displayer {
            line_info,
            filename,
            entry.text:gsub("^%s*(.-)%s*$", "%1"):gsub(".* | ", ""),
        }
    end

    return function(entry)
        local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)
        return {
            valid = true,
            value = entry,
            ordinal = (not opts.ignore_filename and filename or "") .. " " .. entry.text,
            display = make_display,
            bufnr = entry.bufnr,
            filename = filename,
            lnum = entry.lnum,
            col = entry.col,
            text = entry.text,
            start = entry.start,
            finish = entry.finish,
        }
    end
end

function lsp.lsp_references(opts)
    opts = opts or {}
    require('telescope.builtin').lsp_references(vim.tbl_extend("force", opts, { entry_maker = file_and_details_entry() }))
end

function lsp.lsp_definitions(opts)
    opts = opts or {}
    require('telescope.builtin').lsp_definitions(vim.tbl_extend("force", opts, { entry_maker = file_and_details_entry() }))
end

function lsp.lsp_type_definition(opts)
    opts = opts or {}
    require('telescope.builtin').lsp_type_definition(vim.tbl_extend("force", opts,
        { entry_maker = file_and_details_entry() }))
end

function lsp.lsp_implementations(opts)
    opts = opts or {}
    require('telescope.builtin').lsp_implementations(vim.tbl_extend("force", opts,
        { entry_maker = file_and_details_entry() }))
end

function lsp.register_on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

return lsp
