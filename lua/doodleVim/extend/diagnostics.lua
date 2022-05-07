local diag = {}

diag.config = {
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
	debug_sign = "   ",
	use_diagnostic_virtual_text = true,
}

local extend_config = function(opts)
  opts = opts or {}
  if next(opts) == nil then
    return
  end
  for key, value in pairs(opts) do
    if diag.config[key] == nil then
      error(string.format("[Lspdiag] Key %s not exist in config values", key))
      return
    end
    if type(diag.config[key]) == "table" then
      for k, v in pairs(value) do
        diag.config[key][k] = v
      end
    else
      diag.config[key] = value
    end
  end
end

diag.setup = function(opts)
  extend_config(opts)
  local config = diag.config
  for type, icon in pairs {
    Error = config.error_sign,
    Warn = config.warn_sign,
    Hint = config.hint_sign,
    Info = config.infor_sign,
  } do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = "",
    })
  end
  vim.diagnostic.config({virtual_text = config.use_diagnostic_virtual_text})
end

diag.toggle_virtual_text = function()
  diag.config.use_diagnostic_virtual_text = not diag.config.use_diagnostic_virtual_text
  vim.diagnostic.config({virtual_text = diag.config.use_diagnostic_virtual_text})
end

return diag
