local config = {}

function config.delimimate()
  vim.g.delimitMate_expand_cr = 0
  vim.g.delimitMate_expand_space = 1
  vim.g.delimitMate_smart_quotes = 1
  vim.g.delimitMate_expand_inside_quotes = 0
  vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
end

function config.caw()
	vim.api.nvim_set_keymap('n', '<Leader>c', '<Plug>(caw:prefix)', {})
	vim.api.nvim_set_keymap('v', '<Leader>c', '<Plug>(caw:prefix)', {})
end

function config.easymotion()
	vim.api.nvim_set_keymap('n', '<Leader>s', '<Plug>(easymotion-overwin-f2)', {})
end

function config.easyalign()
	vim.api.nvim_set_keymap('x', 'ma', '<Plug>(EasyAlign)', {})
	vim.api.nvim_set_keymap('n', 'ma', '<Plug>(EasyAlign)<CR>', {})
end

return config
