local lsp = {}
local conf = require('doodleVim.modules.lsp.config')
local setup = require('doodleVim.modules.lsp.setup')

lsp['neovim/nvim-lspconfig'] = {
    lazy = true,
    event = "BufReadPost",
    dependencies = {
        'williamboman/mason.nvim',
        "williamboman/mason-lspconfig.nvim",
        'tamago324/nlsp-settings.nvim',
        'mortepau/codicons.nvim',
        'j-hui/fidget.nvim',
        {
            "hrsh7th/cmp-nvim-lsp",
            cond = function()
                return require("doodleVim.utils.utils").has("nvim-cmp")
            end,
        },
    },
    config = conf.lspconfig
}

lsp['j-hui/fidget.nvim'] = {
    lazy = true,
    config = conf.fidget
}

lsp['tamago324/nlsp-settings.nvim'] = {
    lazy = true,
    config = conf.nlsp_settings,
}

lsp['williamboman/mason.nvim'] = {
    lazy = true,
    init = setup.mason,
    config = conf.mason,
}

lsp['jose-elias-alvarez/null-ls.nvim'] = {
    lazy = true,
    event = "BufReadPost",
    dependencies = {
        'doodleEsc/gotools.nvim',
        'williamboman/mason.nvim',
    },
    config = conf.null_ls,
}

lsp['doodleEsc/rename.nvim'] = {
    lazy = true,
    dependencies = {
        'neovim/nvim-lspconfig',
        'MunifTanjim/nui.nvim',
    },
}

lsp['doodleEsc/gotools.nvim'] = {
    lazy = true,
    config = conf.gotools
}

lsp['kosayoda/nvim-lightbulb'] = {
    lazy = true,
    event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
    dependencies = {
        'neovim/nvim-lspconfig',
        'mortepau/codicons.nvim'
    },
    config = conf.lightbulb
}

lsp['ray-x/lsp_signature.nvim'] = {
    lazy = true,
    init = setup.lsp_signature,
}

return lsp
