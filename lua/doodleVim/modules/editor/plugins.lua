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
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
}

editor['junegunn/vim-easy-align'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
}

editor['karb94/neoscroll.nvim'] = {
    lazy = true,
    config = conf.neoscroll,
}

editor['kylechui/nvim-surround'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    config = conf.nvim_surround
}

editor['gorbit99/codewindow.nvim'] = {
    lazy = true,
    config = conf.codewindow
}

return editor
