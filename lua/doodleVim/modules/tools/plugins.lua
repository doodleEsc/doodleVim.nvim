local tools = {}
local conf = require("doodleVim.modules.tools.config")

tools['dstein64/vim-startuptime'] = {
    cmd = 'StartupTime'
}

tools['folke/todo-comments.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("todo-comments.nvim", 80) end,
    config = conf.todo
}

tools['doodleEsc/project.nvim'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("project.nvim", 80)
    end,
    requires = {
        { 'rmagatti/auto-session', opt = true, config = conf.autosession },
    },
    config = conf.project
}

tools['nvim-telescope/telescope.nvim'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("telescope.nvim", 50)
    end,
    requires = {
        { 'folke/todo-comments.nvim', opt = true },
        { 'doodleEsc/project.nvim', opt = true },
        { 'nvim-telescope/telescope-fzf-native.nvim', opt = true, run = 'make' },
        { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
        { 'nvim-telescope/telescope-ui-select.nvim', opt = true },
        { 'LukasPietzschmann/telescope-tabs', opt = true },
        { 'AckslD/nvim-neoclip.lua', config = conf.neoclip }
    },
    config = conf.telescope
}


tools['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("nvim-tree.lua", 75)
    end,
    requires = {
        { 'romgrk/barbar.nvim', opt = true },
    },
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
        require("doodleVim.utils.defer").add("vim-floaterm", 40)
    end
}

tools['anuvyklack/hydra.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("hydra.nvim", 40) end,
    requires = {
        { 'jbyuki/venn.nvim', opt = true },
        { 'lewis6991/gitsigns.nvim', opt = true },
        { 'nvim-telescope/telescope.nvim', opt = true },
        { 'mfussenegger/nvim-dap', opt = true },
    },
    config = conf.hydra
}

tools['towolf/vim-helm'] = {
    ft = 'yaml'
}

tools['folke/which-key.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("which-key.nvim", 40) end,
    config = conf.which_key
}

tools['aserowy/tmux.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("tmux.nvim", 40) end,
    config = conf.tmux
}

tools['nvim-neorg/neorg'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("neorg", 40) end,
    config = conf.neorg
}

tools['sindrets/diffview.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("diffview.nvim", 40) end,
    config = conf.diffview,
}

return tools
