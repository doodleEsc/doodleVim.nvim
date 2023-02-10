local ui = {}
local conf = require("doodleVim.modules.ui.config")
local setup = require("doodleVim.modules.ui.setup")


ui['ellisonleao/gruvbox.nvim'] = {
    lazy = true,
}

ui['NvChad/nvim-colorizer.lua'] = {
    ft = { "lua", "vim", "markdown" },
    config = conf.color,
}

ui['nvim-treesitter/nvim-treesitter'] = {
    lazy = true,
    event = "BufReadPost",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground'
    },
    init = setup.treesitter,
    config = conf.treesitter
}

ui['goolord/alpha-nvim'] = {
    lazy = true,
    event = "BufWinEnter",
    config = conf.alpha
}

ui['nvim-lualine/lualine.nvim'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = conf.lualine,
}

ui['folke/todo-comments.nvim'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    dependencies = {
        'mortepau/codicons.nvim'
    },
    config = conf.todo
}

ui['lewis6991/gitsigns.nvim'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    config = conf.gitsigns,
}

ui['romgrk/barbar.nvim'] = {
    lazy = true,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    init = setup.barbar,
}

ui['lukas-reineke/indent-blankline.nvim'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    config = conf.blankline,
}

return ui
