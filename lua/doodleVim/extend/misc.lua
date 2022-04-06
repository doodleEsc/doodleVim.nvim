local utils = require("doodleVim.utils.utils")

local misc = {}

misc.safe_exit = function()
  require('doodleVim.utils.defer').load_immediately({'vim-floaterm', 'nvim-tree.lua'})

  -- close floaterm
  local floatermBufnr = vim.call("floaterm#buflist#gather")
  if #floatermBufnr ~= 0 then
    vim.cmd[[FloatermKill]]
  end

  -- close nvim-tree
  local view = require'nvim-tree.view'
  if view.is_visible() then
    require('doodleVim.extend.tree').toggle()
  end

  -- quit
  vim.cmd[[confirm qa]]
end

misc.safe_save = function()
  require('doodleVim.utils.defer').load_immediately('auto-session')
  vim.cmd[[write]]
  require("auto-session").SaveSession()
end

misc.gotests = function(type)
  require('doodleVim.utils.defer').load_immediately({'auto-session', 'nvim-tree.lua'})

  if type == "func" then
    require'gotests'.fun_test()
  elseif type == "exported" then
    require'gotests'.exported_test()
  elseif type == "all" then
    require'gotests'.all_test()
  end

  require'nvim-tree.actions.reloaders'.reload_explorer()
end

misc.wrapped_notify = function(m, l, o)
  local wrapped_msg = require("doodleVim.utils.utils").wrap(m, 52)
  require("notify")(wrapped_msg, l, o)
end

misc.toggle_nu = function()
  vim.cmd[[:set nornu]]
  if vim.wo.nu then
    vim.cmd[[:set nonu]]
  else
    vim.cmd[[:set nu]]
  end
end

misc.toggle_rnu = function()
  vim.cmd[[:set nonu]]
  if vim.wo.rnu then
    vim.cmd[[:set nornu]]
  else
    vim.cmd[[:set rnu]]
  end
end

misc.reload = function()
    utils.remove_cached_package("^doodleVim")
	require("doodleVim.core")
	vim.notify("Configuration Reloaded")
end

return misc
