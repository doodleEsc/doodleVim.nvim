local gruvbox = {}

local vim_path = require('doodleVim.core.global').vim_path
local colors_path = vim_path .. "/colors"

gruvbox.palette_overrides = {

}

gruvbox.overrides = {
    LightBulb               = { link = "GruvboxYellowSign" },
    FloatBorder             = { link = "GruvboxBlue" },
    FloatermBorder          = { link = "GruvboxOrange" },
    CodewindowBorder        = { fg = "#665c54" },
    RenamerNormal           = { link = "Normal" },
    RenamerBorder           = { link = "GruvboxBlue" },
    RenamerTitle            = { link = "Title" },
    Pmenu                   = { link = "Normal" },
    -- Telescope
    TelescopeNormal         = { link = "GruvboxBlue" },
    TelescopeSelection      = { link = "GruvboxYellowBold" },
    TelescopeMultiSelection = { link = "GruvboxGray" },
    TelescopeSelectionCaret = { link = "GruvboxRed" },
    TelescopeBorder         = { link = "TelescopeNormal" },
    TelescopePromptBorder   = { link = "TelescopeNormal" },
    TelescopeResultsBorder  = { link = "TelescopeNormal" },
    TelescopePreviewBorder  = { link = "TelescopeNormal" },
    TelescopeMatching       = { link = "GruvboxRedBold" },
    TelescopePromptPrefix   = { link = "GruvboxRed" },
    TelescopePrompt         = { link = "TelescopeNormal" },
    -- NvimTree
    NvimTreeOpenedFile      = { fg = "#b8bb26", bold = true },
    -- Diagnostic
    DiagnosticHeader        = { link = "GruvboxBlue" },
    -- marks
    MarkSignHL              = { link = "GruvboxPurpleSign" },
    -- LspReference
    LspReferenceRead        = { bold = true, bg = "#504945", },
    LspReferenceText        = { bold = true, bg = "#504945", },
    LspReferenceWrite       = { bold = true, bg = "#504945", },
}


gruvbox.dump = function()
    require("gruvbox").setup({
        overrides = require("doodleVim.Extend.gruvbox").overrides,
        palette_overrides = require("doodleVim.Extend.gruvbox").palette_overrides
    })

    local groups = require("gruvbox.groups").setup()
    local color_file_path = colors_path .. "/gruvbox.lua"


    if vim.fn.filereadable(color_file_path) == 1 then
        os.remove(color_file_path)
    end

    local file = io.open(color_file_path, "w")

    local import = "local api = vim.api\n"
    if file ~= nil then
        file:write(import)
    else
        vim.notify("Can't open file " .. color_file_path .. "'", vim.log.levels.ERROR)
        return
    end
    for group, hl in pairs(groups) do
        local line = "api.nvim_set_hl(0, '" .. group .. "', " .. vim.inspect(hl, { newline = "", indent = " " }) .. ")\n"
        if file ~= nil then
            file:write(line)
        else
            vim.notify("Can't open file " .. color_file_path .. "'", vim.log.levels.ERROR)
            return
        end
    end

    if file ~= nil then
        file:close()
        return
    else
        vim.notify("Can't close file " .. color_file_path .. "'", vim.log.levels.ERROR)
    end
end

return gruvbox
