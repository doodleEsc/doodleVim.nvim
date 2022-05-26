local editor = {}
local conf = require("doodleVim.modules.editor.config")

editor['numToStr/Comment.nvim'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").packer_defer_load("Comment.nvim", 200) end,
  config = conf.comment,
}

editor['phaazon/hop.nvim'] = {
  opt = true,
  -- setup = function() require("doodleVim.utils.defer").packer_defer_load("hop.nvim", 500) end,
  setup = function() require("doodleVim.utils.defer").register("hop", "hop.nvim") end,
  config = conf.hop
}

editor['andymass/vim-matchup'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").packer_defer_load("vim-matchup", 200) end,
}

editor['junegunn/vim-easy-align'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").packer_defer_load("vim-easy-align", 500) end,
}

editor['karb94/neoscroll.nvim'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").register("neoscroll", "neoscroll.nvim") end,
  config = conf.neoscroll,
}

editor['folke/todo-comments.nvim'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").add("todo-comments.nvim", 100) end,
  config = conf.todo
}

editor['windwp/nvim-autopairs'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").packer_defer_load("nvim-autopairs", 200) end,
  config = conf.autopairs
}

editor['romgrk/barbar.nvim'] = {
  opt = true,
  setup = function()
    require("doodleVim.modules.editor.config").barbar()
    -- require("doodleVim.utils.defer").register("bufferline", "barbar.nvim")
    require("doodleVim.utils.defer").add("barbar.nvim", 100)
  end,
  requires = {'kyazdani42/nvim-web-devicons'},
}

editor['lewis6991/gitsigns.nvim'] = {
  opt = true,
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim'},
  setup = function() require("doodleVim.utils.defer").add("gitsigns.nvim", 90) end,
}

editor['lukas-reineke/indent-blankline.nvim'] = {
  opt = true,
  setup = function() require("doodleVim.utils.defer").add("indent-blankline.nvim", 90) end,
  config = conf.blankline,
}

editor['jakewvincent/mkdnflow.nvim'] = {
    ft = "markdown",
    config = conf.mkdnflow
}

editor['matbme/JABS.nvim'] = {
    setup = function() require("doodleVim.utils.defer").add("JABS.nvim", 90) end,
    config = conf.jabs,
}

return editor
