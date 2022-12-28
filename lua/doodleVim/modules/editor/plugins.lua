local editor = {}
local conf = require("doodleVim.modules.editor.config")

editor['numToStr/Comment.nvim'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").defer_load("Comment.nvim", 200) end,
    config = conf.comment,
}

editor['phaazon/hop.nvim'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").register("hop", "hop.nvim") end,
    config = conf.hop
}

editor['andymass/vim-matchup'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").defer_load("vim-matchup", 200) end,
}

editor['junegunn/vim-easy-align'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").defer_load("vim-easy-align", 500) end,
}

editor['karb94/neoscroll.nvim'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").register("neoscroll", "neoscroll.nvim") end,
    config = conf.neoscroll,
}

-- editor['romgrk/barbar.nvim'] = {
--     lazy = true,
--     dependencies = { 'nvim-tree/nvim-web-devicons' },
--     init = function()
--         require("doodleVim.modules.editor.config").barbar()
--         require("doodleVim.utils.defer").add("barbar.nvim", 90)
--     end,
-- }

editor['lukas-reineke/indent-blankline.nvim'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").add("indent-blankline.nvim", 90) end,
    config = conf.blankline,
}

editor['jakewvincent/mkdnflow.nvim'] = {
    ft = "markdown",
    config = conf.mkdnflow
}

editor['kylechui/nvim-surround'] = {
    lazy = true,
    init = function() require("doodleVim.utils.defer").defer_load("nvim-surround", 200) end,
    config = conf.nvim_surround
}

-- editor['windwp/nvim-autopairs'] = {
--     lazy = true,
--     init = function() require("doodleVim.utils.defer").defer_load("nvim-autopairs", 200) end,
--     config = conf.autopairs
-- }
--
return editor
