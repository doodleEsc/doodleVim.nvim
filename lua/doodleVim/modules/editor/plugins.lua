local editor = {}
local conf = require("doodleVim.modules.editor.config")
local lazy = require("doodleVim.extend.lazy")

editor["numToStr/Comment.nvim"] = {
    lazy = true,
    config = conf.comment,
}

editor["phaazon/hop.nvim"] = {
    lazy = true,
    config = conf.hop,
}

editor["andymass/vim-matchup"] = {
    lazy = true,
    init = lazy.register_defer_load_helper("DeferStartWithFile", 80, "vim-matchup", "match-up"),
    dependencies = { "nvim-treesitter/nvim-treesitter" },
}

editor["junegunn/vim-easy-align"] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    -- init = lazy.register_defer_load_helper("DeferStartWithFile", 80, "vim-easy-align", "easy_align.vim"),
}

editor["karb94/neoscroll.nvim"] = {
    lazy = true,
    config = conf.neoscroll,
}

editor["kylechui/nvim-surround"] = {
    lazy = true,
    init = lazy.register_defer_load_helper("DeferStartWithFile", 80, "nvim-surround", "nvim-surround"),
    config = conf.nvim_surround,
}

editor["gorbit99/codewindow.nvim"] = {
    lazy = true,
    config = conf.codewindow,
}

return editor
