local tools = {}
local conf = require("doodleVim.modules.tools.config")

tools['nvim-telescope/telescope.nvim'] = {
    lazy = true,
    cmd = { "Telescope" },
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        -- 'nvim-telescope/telescope-ui-select.nvim',
        'LukasPietzschmann/telescope-tabs',
        'folke/todo-comments.nvim',
        'doodleEsc/project.nvim',
        'AckslD/nvim-neoclip.lua',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = conf.telescope
}

tools['AckslD/nvim-neoclip.lua'] = {
    lazy = true,
    dependencies = { 'kkharji/sqlite.lua' },
    config = conf.neoclip
}

tools['kkharji/sqlite.lua'] = {
    lazy = true,
}

tools['doodleEsc/project.nvim'] = {
    lazy = true,
    event = "User DeferStart",
    dependencies = { 'rmagatti/auto-session' },
    config = conf.project
}

tools['rmagatti/auto-session'] = {
    lazy = true,
    config = conf.autosession
}

tools['kyazdani42/nvim-tree.lua'] = {
    lazy = true,
    dependencies = {
        'romgrk/barbar.nvim',
        'mortepau/codicons.nvim',
    },
    config = conf.nvim_tree
}

tools['iamcco/markdown-preview.nvim'] = {
    lazy = true,
    ft = 'markdown',
    init = conf.mkdp,
    build = ":call mkdp#util#install()",
}

tools['simrat39/symbols-outline.nvim'] = {
    lazy = true,
    dependencies = {
        'mortepau/codicons.nvim',
    },
    config = conf.symbols_outline
}

tools['voldikss/vim-floaterm'] = {
    cmd = {
        'FloatermNew',
        'FloatermToggle'
    },
    init = function()
        require("doodleVim.modules.tools.config").floaterm()
    end
}

tools['anuvyklack/hydra.nvim'] = {
    lazy = true,
    dependencies = {
        'jbyuki/venn.nvim',
        'nvim-telescope/telescope.nvim',
        'mfussenegger/nvim-dap',
        'lewis6991/gitsigns.nvim',
    },
    config = conf.hydra
}

tools['jbyuki/venn.nvim'] = {
    lazy = true,
}

tools['towolf/vim-helm'] = {
    ft = 'yaml'
}

tools['folke/which-key.nvim'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    config = conf.which_key
}

tools['aserowy/tmux.nvim'] = {
    lazy = true,
    event = "User DeferStart",
    config = conf.tmux
}

-- tools['nvim-neorg/neorg'] = {
--     lazy = true,
--     cmd = "Neorg",
--     ft = "norg",
--     config = conf.neorg
-- }

tools['sindrets/diffview.nvim'] = {
    lazy = true,
    cmd = { 'DiffviewOpen' },
    dependencies = {
        'mortepau/codicons.nvim',
    },
    config = conf.diffview,
}

tools['mfussenegger/nvim-dap'] = {
    lazy = true,
    dependencies = {
        "williamboman/mason.nvim",
        'rcarriga/nvim-dap-ui',
        'mortepau/codicons.nvim',
    },
    config = conf.dap
}

tools['rcarriga/nvim-dap-ui'] = {
    lazy = true,
    init = function(plugin)
        vim.g.dapui_setup = false
    end,
}

tools["dstein64/vim-startuptime"] = {
    cmd = "StartupTime",
    init = function()
        vim.g.startuptime_tries = 10
    end,
}

return tools
