local completion = {}
local conf = require("doodleVim.modules.completion.config")

-- COMPLETION
completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("nvim-cmp", 50)
    end,
    config = conf.nvim_cmp,
}

completion["hrsh7th/cmp-nvim-lsp"] = {
    after = "nvim-cmp",
}

completion["saadparwaiz1/cmp_luasnip"] = {
    after = "nvim-cmp",
}

completion["hrsh7th/cmp-buffer"] = {
    after = "nvim-cmp",
}

completion["hrsh7th/cmp-path"] = {
    after = "nvim-cmp",
}

completion["tzachar/cmp-tabnine"] = {
    after = "nvim-cmp",
    run = "./install.sh",
}

completion["octaltree/cmp-look"] = {
    after = "nvim-cmp",
}

completion["hrsh7th/cmp-cmdline"] = {
    after = "nvim-cmp",
}

completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    config = conf.luasnip,
}

completion["doodleEsc/friendly-snippets"] = {
    opt = true,
}

completion["neovim/nvim-lspconfig"] = {
    after = "cmp-nvim-lsp",
}

completion["ray-x/lsp_signature.nvim"] = {
    after = "nvim-lspconfig",
}

completion["tamago324/nlsp-settings.nvim"] = {
    after = "nvim-lspconfig",
    config = conf.nlsp_settings,
}

completion["williamboman/mason.nvim"] = {
    opt = true,
    setup = function()
        require("doodleVim.extend.packer").add("mason", function()
            require("doodleVim.utils.defer").immediate_load("mason.nvim")
            vim.cmd [[MasonInstall gopls json-lsp lua-language-server python-lsp-server debugpy delve gotests gomodifytags ]]
        end)
    end,
    after = "nvim-cmp",
    config = conf.mason,
}

completion["williamboman/mason-lspconfig.nvim"] = {
    opt = true,
    after = {
        "mason.nvim",
        "nvim-lspconfig",
        "nlsp-settings.nvim",
        "lsp_signature.nvim"
    },
    config = conf.mason_lspconfig,
}

completion["doodleEsc/lightbulb.nvim"] = {
    after = "mason-lspconfig.nvim",
    config = conf.lightbulb,
}

completion["doodleEsc/gotools.nvim"] = {
    after = { "mason-lspconfig.nvim", "nui.nvim" },
    config = conf.gotools
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
    after = {
        "mason-lspconfig.nvim",
        "gotools.nvim"
    },
    config = conf.null_ls,
}

completion["danymat/neogen"] = {
    after = { "nvim-cmp", "LuaSnip" },
    config = conf.neogen,
}

completion["doodleEsc/rename.nvim"] = {
    after = { "nvim-lspconfig", "nui.nvim" },
}

return completion
