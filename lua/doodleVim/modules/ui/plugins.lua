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
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    init = setup.treesitter,
    config = conf.treesitter
}

ui['goolord/alpha-nvim'] = {
    lazy = true,
    event = "VimEnter",
    config = conf.alpha
}

ui['nvim-lualine/lualine.nvim'] = {
    lazy = true,
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = conf.lualine,
}

ui['folke/todo-comments.nvim'] = {
    lazy = true,
    event = "VeryLazy",
    config = conf.todo
}

ui['lewis6991/gitsigns.nvim'] = {
    lazy = true,
    event = "VeryLazy",
    config = conf.gitsigns,
}

ui['romgrk/barbar.nvim'] = {
    lazy = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    init = setup.barbar,
}

ui['lukas-reineke/indent-blankline.nvim'] = {
    lazy = true,
    event = "VeryLazy",
    config = conf.blankline,
}

return ui
