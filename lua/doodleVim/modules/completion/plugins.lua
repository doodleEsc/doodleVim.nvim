local completion = {}
local conf = require('doodleVim.modules.completion.config')

-- COMPLETION
completion['hrsh7th/nvim-cmp'] = {
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-path',
        'octaltree/cmp-look',
        'hrsh7th/cmp-cmdline',
        'ray-x/cmp-treesitter',
        'lukas-reineke/cmp-under-comparator',
        'doodleEsc/friendly-snippets',
        'windwp/nvim-autopairs',
        { 'danymat/neogen', config = conf.neogen },
        { 'L3MON4D3/LuaSnip', config = conf.luasnip },

    },
    config = conf.nvim_cmp,
}

completion['neovim/nvim-lspconfig'] = {
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
}

-- completion['tamago324/nlsp-settings.nvim'] = {
--     lazy = true,
--     dependencies = {
--         'neovim/nvim-lspconfig',
--     },
--     config = conf.nlsp_settings,
-- }

-- completion['williamboman/mason.nvim'] = {
--     lazy = true,
--     init = function()
--         require('doodleVim.utils.defer').add('mason.nvim', 50)
--         require('doodleVim.extend.packer').add('mason', function()
--             local binaries = { 'gopls', 'json-lsp', 'lua-language-server', 'python-lsp-server', 'delve',
--                 'gotests', 'gomodifytags', 'impl', 'clangd', 'debugpy' }
--             local register = require('mason-registry')
--             local bins = ''
--             for _, bin in ipairs(binaries) do
--                 if not register.is_installed(bin) then
--                     bins = bins .. ' ' .. bin
--                 end
--             end
--             if #bins > 0 then
--                 vim.cmd('MasonInstall' .. bins)
--             end
--         end)
--     end,
--     config = conf.mason,
-- }

completion['williamboman/mason-lspconfig.nvim'] = {
    lazy = true,
    init = function()
        require('doodleVim.utils.defer').add('mason-lspconfig.nvim', 60)
    end,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'ray-x/lsp_signature.nvim',
        {
            'tamago324/nlsp-settings.nvim',
            dependencies = {
                'neovim/nvim-lspconfig',
            },
            config = conf.nlsp_settings
        },
        {
            'williamboman/mason.nvim',
            init = function()
                require('doodleVim.extend.packer').add('mason', function()
                    local binaries = { 'gopls', 'json-lsp', 'lua-language-server', 'python-lsp-server', 'delve',
                        'gotests', 'gomodifytags', 'impl', 'clangd', 'debugpy' }
                    local register = require('mason-registry')
                    local bins = ''
                    for _, bin in ipairs(binaries) do
                        if not register.is_installed(bin) then
                            bins = bins .. ' ' .. bin
                        end
                    end
                    if #bins > 0 then
                        vim.cmd('MasonInstall' .. bins)
                    end
                end)
            end,
            config = conf.mason
        },
    },
    config = conf.mason_lspconfig,
}

completion['jose-elias-alvarez/null-ls.nvim'] = {
    lazy = true,
    init = function()
        require('doodleVim.utils.defer').add('null-ls.nvim', 50)
    end,
    dependencies = {
        {
            'neovim/nvim-lspconfig',
            'doodleEsc/gotools.nvim',
            dependencies = {
                'MunifTanjim/nui.nvim',
            },
            config = conf.gotools
        }
    },
    config = conf.null_ls,
}

completion['doodleEsc/rename.nvim'] = {
    lazy = true,
    init = function()
        require('doodleVim.utils.defer').add('rename.nvim', 50)
    end,
    dependencies = {
        'neovim/nvim-lspconfig',
        'MunifTanjim/nui.nvim',
    },
}

completion['doodleEsc/lightbulb.nvim'] = {
    lazy = true,
    init = function()
        require('doodleVim.utils.defer').add('lightbulb.nvim', 50)
    end,
    config = conf.lightbulb
}

return completion
