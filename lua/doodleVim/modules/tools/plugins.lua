local tools = {}
local conf = require("doodleVim.modules.tools.config")
local setup = require("doodleVim.modules.tools.setup")

tools["nvim-telescope/telescope.nvim"] = {
    lazy = true,
    cmd = { "Telescope" },
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        -- 'nvim-telescope/telescope-ui-select.nvim',
        "LukasPietzschmann/telescope-tabs",
        "folke/todo-comments.nvim",
        "doodleEsc/project.nvim",
        "AckslD/nvim-neoclip.lua",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = conf.telescope,
}

tools["AckslD/nvim-neoclip.lua"] = {
    lazy = true,
    dependencies = { "kkharji/sqlite.lua" },
    config = conf.neoclip,
}

tools["kkharji/sqlite.lua"] = {
    lazy = true,
}

tools["doodleEsc/project.nvim"] = {
    lazy = true,
    event = "User DeferStart",
    dependencies = { "rmagatti/auto-session" },
    config = conf.project,
}

tools["rmagatti/auto-session"] = {
    lazy = true,
    config = conf.autosession,
}

tools["kyazdani42/nvim-tree.lua"] = {
    lazy = true,
    dependencies = {
        "romgrk/barbar.nvim",
        "mortepau/codicons.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = conf.nvim_tree,
}

tools["iamcco/markdown-preview.nvim"] = {
    lazy = true,
    ft = "markdown",
    init = conf.mkdp,
    build = ":call mkdp#util#install()",
}

tools["simrat39/symbols-outline.nvim"] = {
    lazy = true,
    dependencies = {
        "mortepau/codicons.nvim",
    },
    config = conf.symbols_outline,
}

tools["voldikss/vim-floaterm"] = {
    cmd = {
        "FloatermNew",
        "FloatermToggle",
    },
    init = function()
        require("doodleVim.modules.tools.config").floaterm()
    end,
}

tools["anuvyklack/hydra.nvim"] = {
    lazy = true,
    dependencies = {
        "jbyuki/venn.nvim",
        "nvim-telescope/telescope.nvim",
        "lewis6991/gitsigns.nvim",
    },
    config = conf.hydra,
}

tools["jbyuki/venn.nvim"] = {
    lazy = true,
}

tools["towolf/vim-helm"] = {
    ft = "yaml",
}

tools["folke/which-key.nvim"] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    config = conf.which_key,
}

tools["aserowy/tmux.nvim"] = {
    lazy = true,
    event = "User DeferStart",
    config = conf.tmux,
}

-- tools['nvim-neorg/neorg'] = {
--     lazy = true,
--     cmd = "Neorg",
--     ft = "norg",
--     config = conf.neorg
-- }

tools["sindrets/diffview.nvim"] = {
    lazy = true,
    cmd = { "DiffviewOpen" },
    dependencies = {
        "mortepau/codicons.nvim",
    },
    config = conf.diffview,
}

tools["mfussenegger/nvim-dap"] = {
    lazy = true,
    event = { "User StartDebug" },
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mortepau/codicons.nvim",
        -- { "mfussenegger/nvim-dap-python", lazy = true, ft = "python" },
        -- { "leoluz/nvim-dap-go",           lazy = true, ft = "go" },
    },
    config = conf.dap,
}

tools["rcarriga/nvim-dap-ui"] = {
    lazy = true,
    init = function(plugin)
        vim.g.dapui_setup = false
    end,
}

tools["mfussenegger/nvim-dap-python"] = {
    lazy = true,
    init = setup.dap_python,
    ft = "python",
    config = conf.dap_python,
}

tools["leoluz/nvim-dap-go"] = {
    lazy = true,
    init = setup.dap_go,
    ft = "go",
    config = conf.dap_go,
}

tools["Weissle/persistent-breakpoints.nvim"] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    init = setup.persistent_breakpoints,
    config = conf.breakpoints,
}

tools["dstein64/vim-startuptime"] = {
    cmd = "StartupTime",
    init = function()
        vim.g.startuptime_tries = 10
    end,
}

tools["kevinhwang91/promise-async"] = {
    lazy = true,
}

tools["kevinhwang91/nvim-ufo"] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "kevinhwang91/promise-async",
    },
    config = conf.nvim_ufo,
}

tools["nvim-orgmode/orgmode"] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    config = conf.orgmode,
}

tools["LunarVim/bigfile.nvim"] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    -- cond = function()
    --     if vim.fn.argc() == 0 then
    --         return false
    --     else
    --         return true
    --     end
    -- end,
    config = conf.bigfile,
}

return tools
