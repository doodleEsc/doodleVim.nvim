local tools = {}
local conf = require("doodleVim.modules.tools.config")

tools['dstein64/vim-startuptime'] = {
    cmd = 'StartupTime'
}

tools['nvim-telescope/telescope.nvim'] = {
    cmd = { "Telescope" },
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        'kkharji/sqlite.lua',
        'LukasPietzschmann/telescope-tabs',
        'folke/todo-comments.nvim',
        'doodleEsc/project.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        {
            'AckslD/nvim-neoclip.lua',
            dependencies = { 'kkharji/sqlite.lua' },
            config = conf.neoclip
        },
    },
    config = conf.telescope
}

tools['folke/todo-comments.nvim'] = {
    lazy = true,
    init = function()
        require("doodleVim.utils.defer").add("todo-comments.nvim", 90)
    end,
    config = conf.todo
}

tools['doodleEsc/project.nvim'] = {
    lazy = true,
    init = function()
        require("doodleVim.utils.defer").add("project.nvim", 80)
    end,
    dependencies = {
        { 'rmagatti/auto-session', config = conf.autosession }
    },
    config = conf.project
}

-- tools['rmagatti/auto-session'] = {
--     opt = true,
--     setup = function()
--         require("doodleVim.utils.defer").add("auto-session", 90)
--     end,
--     config = conf.autosession
-- }

tools['kyazdani42/nvim-tree.lua'] = {
    cmd = {
        'ToggleTree',
        'FindTreeFile',
    },
    dependencies = {
        {
            'romgrk/barbar.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            init = function()
                require("doodleVim.modules.tools.config").barbar()
            end,
        }
    },
    config = conf.nvim_tree
}

tools['iamcco/markdown-preview.nvim'] = {
    ft = 'markdown',
    init = conf.mkdp,
    build = ":call mkdp#util#install()",
}

tools['simrat39/symbols-outline.nvim'] = {
    cmd    = { 'SymbolsOutline' },
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
    init = function()
        require("doodleVim.utils.defer").defer_load("hydra.nvim", 200)
    end,
    config = conf.hydra
}

tools['jbyuki/venn.nvim'] = {
    lazy = true
}

tools['towolf/vim-helm'] = {
    ft = 'yaml'
}

tools['nvim-lua/plenary.nvim'] = {
    lazy = true
}

-- tools['bfredl/nvim-luadev'] = {}

tools['folke/which-key.nvim'] = {
    lazy = true,
    init = function()
        require("doodleVim.utils.defer").add("which-key.nvim", 50)
    end,
    config = conf.which_key
}

tools['nathom/filetype.nvim'] = {
    init = function()
        vim.g.did_load_filetypes = 1
    end
}

tools['rcarriga/nvim-notify'] = {
    lazy = true,
    init = function()
        require("doodleVim.utils.defer").add("nvim-notify", 100)
    end,
    config = conf.notify
}

-- -- HACK: Start by telescope config
-- tools['AckslD/nvim-neoclip.lua'] = {
--     opt = true,
--     config = conf.neoclip
-- }

-- tools['kkharji/sqlite.lua'] = {
--     opt = true,
--     setup = function() require("doodleVim.utils.defer").add("sqlite.lua", 90) end,
-- }

tools['aserowy/tmux.nvim'] = {
    lazy = true,
    init = function()
        require("doodleVim.utils.defer").add("tmux.nvim", 50)
    end,
    config = conf.tmux
}

-- tools['nvim-neorg/neorg'] = {
--     opt = true,
--     after = { "nvim-treesitter", "telescope.nvim", "nvim-cmp" },
--     config = conf.neorg
-- }

tools['lewis6991/gitsigns.nvim'] = {
    lazy = true,
    init = function()
        require("doodleVim.utils.defer").add("gitsigns.nvim", 100)
    end,
    config = conf.gitsigns,
}

tools['sindrets/diffview.nvim'] = {
    cmd = { 'DiffviewOpen' },
    config = conf.diffview,
}

tools['mfussenegger/nvim-dap'] = {
    lazy = true,
    dependencies = {
        "williamboman/mason.nvim",
        { 'rcarriga/nvim-dap-ui', config = conf.dapui }
    },
    config = conf.dap
}

return tools
