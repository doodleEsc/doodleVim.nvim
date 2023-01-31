local base = {}
local conf = require("doodleVim.modules.base.config")
local setup = require("doodleVim.modules.base.setup")

base['nvim-tree/nvim-web-devicons'] = { lazy = true }

base['nvim-lua/plenary.nvim'] = { lazy = true }

base['nathom/filetype.nvim'] = {
    init = function(plugin) vim.g.did_load_filetypes = 1 end
}

base['MunifTanjim/nui.nvim'] = {
    lazy = true,
    event = "VeryLazy",
    config = conf.nui
}

base['rcarriga/nvim-notify'] = {
    lazy = true,
    event = "VeryLazy",
    config = conf.notify
}

base['NvChad/nvim-colorizer.lua'] = {
    ft = { "lua", "vim", "markdown" },
    config = conf.color,
}

base['nvim-treesitter/nvim-treesitter'] = {
    event = "BufReadPost",
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    init = setup.treesitter,
    config = conf.treesitter
}

return base
