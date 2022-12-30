local editor = {}
local conf = require("doodleVim.modules.editor.config")

editor['numToStr/Comment.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("Comment.nvim", 200) end,
    config = conf.comment,
}

editor['andymass/vim-matchup'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("vim-matchup", 200) end,
}

editor['junegunn/vim-easy-align'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("vim-easy-align", 200) end,
}

editor['karb94/neoscroll.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").register("neoscroll", "neoscroll.nvim") end,
    config = conf.neoscroll,
}

editor['phaazon/hop.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").register("hop", "hop.nvim") end,
    config = conf.hop
}


editor['romgrk/barbar.nvim'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("barbar.nvim", 89)
        require("doodleVim.modules.editor.config").barbar()
    end,
}

editor['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("indent-blankline.nvim", 89) end,
    config = conf.blankline,
}

editor['jakewvincent/mkdnflow.nvim'] = {
    ft = "markdown",
    config = conf.mkdnflow
}

editor['nvim-lualine/lualine.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("lualine.nvim", 89) end,
    config = conf.lualine,
}

editor['lewis6991/gitsigns.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("gitsigns.nvim", 89) end,
    config = conf.gitsigns,
}

editor['goolord/alpha-nvim'] = {
    config = conf.alpha
}

return editor
