local config = {}

function config.caw()
	vim.api.nvim_set_keymap('n', '<Leader>c', '<Plug>(caw:prefix)', {})
	vim.api.nvim_set_keymap('x', '<Leader>c', '<Plug>(caw:prefix)', {})
end

function config.easymotion()
	vim.api.nvim_set_keymap('n', '<Leader>s', '<Plug>(easymotion-overwin-f2)', {})
end

function config.easyalign()
	vim.api.nvim_set_keymap('x', 'ma', '<Plug>(EasyAlign)', {})
	vim.api.nvim_set_keymap('n', 'ma', '<Plug>(EasyAlign)<CR>', {})
end

function config.todo()
	require("todo-comments").setup {}
end

return config
