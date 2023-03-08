local base = {}
local conf = require("doodleVim.modules.base.config")

base['nvim-tree/nvim-web-devicons'] = { lazy = true }

base['mortepau/codicons.nvim'] = { lazy = true }

base['nvim-lua/plenary.nvim'] = { lazy = true }

base['stevearc/dressing.nvim'] = {
    lazy = true,
    event = "VeryLazy",
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    config = conf.dressing
}

base['nathom/filetype.nvim'] = {}

base['MunifTanjim/nui.nvim'] = {
    lazy = true,
    -- event = "VeryLazy",
    -- config = conf.nui
}

base['rcarriga/nvim-notify'] = {
    lazy = true,
    event = "VeryLazy",
    dependencies = {
        'mortepau/codicons.nvim'
    },
    config = conf.notify
}

base['NvChad/nvim-colorizer.lua'] = {
    ft = { "lua", "vim", "markdown" },
    config = conf.color,
}

return base
