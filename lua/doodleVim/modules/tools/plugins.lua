local tools = {}
local conf = require("doodleVim.modules.tools.config")

tools['dstein64/vim-startuptime'] = {
    cmd = 'StartupTime'
}

tools['nvim-telescope/telescope.nvim'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("telescope.nvim", 70)
    end,
    requires = {
        { 'nvim-telescope/telescope-fzf-native.nvim', opt = true, run = 'make' },
        { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
        { 'nvim-telescope/telescope-ui-select.nvim', opt = true },
        { 'LukasPietzschmann/telescope-tabs', opt = true }
    },
    config = conf.telescope
}

tools['doodleEsc/project.nvim'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("project.nvim", 80)
    end,
    config = conf.project
}

tools['rmagatti/auto-session'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("auto-session", 90)
    end,
    config = conf.autosession
}

tools['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    after = "barbar.nvim",
    config = conf.nvim_tree
}

tools['iamcco/markdown-preview.nvim'] = {
    ft = 'markdown',
    setup = conf.mkdp,
    run = ":call mkdp#util#install()",
}

tools['simrat39/symbols-outline.nvim'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").register("symbols-outline", "symbols-outline.nvim")
    end,
    config = conf.symbols_outline
}

tools['voldikss/vim-floaterm'] = {
    opt = true,
    setup = function()
        require("doodleVim.modules.tools.config").floaterm()
        require("doodleVim.utils.defer").defer_load("vim-floaterm", 200)
    end
}

tools['anuvyklack/hydra.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("hydra.nvim", 200) end,
    config = conf.hydra
}

tools['jbyuki/venn.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("venn.nvim", 200) end,
}

tools['towolf/vim-helm'] = {
    ft = 'yaml'
}

tools['nvim-lua/plenary.nvim'] = {
    opt = true
}

-- tools['bfredl/nvim-luadev'] = {}

tools['folke/which-key.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("which-key.nvim", 100) end,
    config = conf.which_key
}

tools['nathom/filetype.nvim'] = {
    setup = function() vim.g.did_load_filetypes = 1 end
}

tools['rcarriga/nvim-notify'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").defer_load("nvim-notify", 100)
    end,
    config = conf.notify
}

-- HACK: Start by telescope config
tools['AckslD/nvim-neoclip.lua'] = {
    opt = true,
    config = conf.neoclip
}

tools['kkharji/sqlite.lua'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("sqlite.lua", 90) end,
}

tools['aserowy/tmux.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("tmux.nvim", 50) end,
    config = conf.tmux
}

tools['nvim-neorg/neorg'] = {
    opt = true,
    setup = function()
        require("doodleVim.extend.packer").add("neorg", function()
            require("doodleVim.utils.defer").immediate_load("neorg")
            local utils = require("doodleVim.utils.utils")
            if not (utils.ts_is_installed("norg") and utils.ts_is_installed("norg_meta")) then
                vim.cmd 'Neorg sync-parsers'
            end
        end)
    end,
    after = { "nvim-treesitter", "telescope.nvim", "nvim-cmp" },
    config = conf.neorg
}

tools['lewis6991/gitsigns.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("gitsigns.nvim", 99) end,
    config = conf.gitsigns,
}

tools['sindrets/diffview.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").defer_load("diffview.nvim", 100) end,
    config = conf.diffview,
}

return tools
