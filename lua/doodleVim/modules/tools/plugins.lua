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
  config = conf.telescope,
  requires = {
    {'nvim-telescope/telescope-fzy-native.nvim', opt = true},
    {'nvim-telescope/telescope-file-browser.nvim', opt = true},
	{'nvim-telescope/telescope-ui-select.nvim', opt = true}
  }
}

tools["cinuor/project.nvim"] = {
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

tools['cinuor/lightbulb.nvim'] = {
    after = 'telescope.nvim',
    config = conf.lightbulb
}

tools['kyazdani42/nvim-tree.lua'] = {
  opt = true,
  setup = function()
    require("doodleVim.modules.tools.config").nvim_tree_setup()
    require("doodleVim.utils.defer").register("nvim-tree", "nvim-tree.lua")
  end,
  config = conf.nvim_tree
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  setup = conf.mkdp,
  run = function() vim.cmd [[:call mkdp#util#install()]] end,
}

tools['simrat39/symbols-outline.nvim'] = {
  opt = true,
  setup = function()
    require("doodleVim.modules.tools.config").symbols_outline()
    require("doodleVim.utils.defer").register("symbols-outline", "symbols-outline.nvim")
  end
}

tools['voldikss/vim-floaterm'] = {
  opt = true,
  setup = function()
    require("doodleVim.modules.tools.config").floaterm()
    require("doodleVim.utils.defer").packer_defer_load("vim-floaterm", 500)
  end
}

tools['voldikss/vim-translator'] = {
  cmd = {'TranslateW'},
  setup = conf.translator()
}

tools['jbyuki/venn.nvim'] = {
  cmd = {'VBox', 'VFill'}
}

tools['towolf/vim-helm'] = {
  ft='yaml'
}

tools['nvim-lua/plenary.nvim'] = {
  opt = true
}

tools['kyazdani42/nvim-web-devicons'] = {}

-- tools['bfredl/nvim-luadev'] = {}

tools['cinuor/gotests.nvim'] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").register("gotests", "gotests.nvim")
  end,
  config = conf.gotests
}

tools['cinuor/which-key.nvim'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").packer_defer_load("which-key.nvim", 100) end,
  config = conf.which_key
}

tools['nathom/filetype.nvim'] = {
  setup = function() vim.g.did_load_filetypes = 1 end
}

tools['rcarriga/nvim-notify'] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").packer_defer_load("nvim-notify", 100)
  end,
  config = conf.notify
}

tools['AckslD/nvim-neoclip.lua'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").add("nvim-neoclip.lua", 80) end,
  config = conf.neoclip
}

tools['tami5/sqlite.lua'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").add("sqlite.lua", 90) end,
}

return tools
