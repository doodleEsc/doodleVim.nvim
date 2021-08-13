local config = {}

function config.caw()
	vim.api.nvim_set_keymap('n', 'mc', '<Plug>(caw:prefix)', {})
	vim.api.nvim_set_keymap('x', 'mc', '<Plug>(caw:prefix)', {})
end

function config.easymotion()
	vim.api.nvim_set_keymap('n', '<Leader>s', '<Plug>(easymotion-overwin-f2)', {})
end

function config.easyalign()
	vim.api.nvim_set_keymap('x', 'ma', '<Plug>(EasyAlign)', {})
	vim.api.nvim_set_keymap('n', 'ma', '<Plug>(EasyAlign)<CR>', {})
end

return config
