local debug = {}

debug.debug_set_cond_breakpoint = function()
  if not packer_plugins['nvim-dap'].loaded then
    vim.notify("`nvim-dap` not loaded", "warn")
    return
  end
  require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

debug.debug_run_last = function()
  if not packer_plugins['nvim-dap'].loaded then
    vim.notify("`nvim-dap` not loaded", "warn")
    return
  end
  require'dap'.run_last()
end

debug.debug_pause = function()
  if not packer_plugins['nvim-dap'].loaded then
    vim.notify("`nvim-dap` not loaded", "warn")
    return
  end
  require'dap'.pause()
end

debug.debug_run_to_cursor = function()
  if not packer_plugins['nvim-dap'].loaded then
    vim.notify("`nvim-dap` not loaded", "warn")
    return
  end
  require'dap'.run_to_cursor()
end

debug.debug_restart = function()
  if not packer_plugins['nvim-dap'].loaded then
    vim.notify("`nvim-dap` not loaded", "warn")
    return
  end
  require'dap'.restart()
end

return debug
