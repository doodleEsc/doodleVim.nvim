local editor = {}
local conf = require("doodleVim.modules.editor.config")

editor['numToStr/Comment.nvim'] = {
    lazy = true,
    config = conf.comment,
}

editor['phaazon/hop.nvim'] = {
    lazy = true,
    config = conf.hop
}

editor['andymass/vim-matchup'] = {
    lazy = true,
    event = "User DeferStart",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
}

editor['junegunn/vim-easy-align'] = {
    lazy = true,
    event = "User DeferStart",
}

editor['karb94/neoscroll.nvim'] = {
    lazy = true,
    config = conf.neoscroll,
}

editor['jakewvincent/mkdnflow.nvim'] = {
    lazy = true,
    ft = "markdown",
    config = conf.mkdnflow
}

editor['kylechui/nvim-surround'] = {
    lazy = true,
    event = "User DeferStart",
    config = conf.nvim_surround
}

editor['gorbit99/codewindow.nvim'] = {
    lazy = true,
    config = conf.codewindow
}

return editor
