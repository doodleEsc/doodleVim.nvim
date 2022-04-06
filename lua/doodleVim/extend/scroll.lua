local scroll = {}

scroll.scroll_up = function()
  require('doodleVim.utils.defer').load_immediately('neoscroll.nvim')
  local neoscroll = require("neoscroll")
  neoscroll.scroll(-vim.wo.scroll, true, 150)
end

scroll.scroll_down = function()
  require('doodleVim.utils.defer').load_immediately('neoscroll.nvim')
  local neoscroll = require("neoscroll")
  neoscroll.scroll(vim.wo.scroll, true, 150)
end

return scroll
