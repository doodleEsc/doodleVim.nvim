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

local function range_from_selection()
    local mode = vim.api.nvim_get_mode()
    if mode == 'v' or mode == 'V' then
        local start = vim.fn.getpos('v')
        local end_ = vim.fn.getpos('.')
        local start_row = start[2]
        local start_col = start[3]
        local end_row = end_[2]
        local end_col = end_[3]

        -- A user can start visual selection at the end and move backwards
        -- Normalize the range to start < end
        if start_row == end_row and end_col < start_col then
            end_col, start_col = start_col, end_col
        elseif end_row < start_row then
            start_row, end_row = end_row, start_row
            start_col, end_col = end_col, start_col
        end
        return {
            ['start'] = { start_row, start_col - 1 },
            ['end'] = { end_row, end_col - 1 },
        }
    else
        return nil
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

return lsp
