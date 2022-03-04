-- local lsp = vim.lsp
local format = {}

local function nvim_create_augroup(group_name,definitions)
  vim.api.nvim_command('augroup '..group_name)
  vim.api.nvim_command('autocmd!')
  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end
  vim.api.nvim_command('augroup END')
end


function format.lsp_before_save()
  local defs = {}
  local ext = vim.fn.expand('%:e')
  table.insert(defs,{"BufWritePre", '*.'..ext ,
                    "lua vim.lsp.buf.formatting_sync(nil,1000)"})
  if ext == 'go' then
    table.insert(defs,{"BufWritePre","*.go",
            "lua require('modules.completion.format').go_organize_imports_sync(1000)"})
  end
  nvim_create_augroup('lsp_before_save',defs)
end

return format
