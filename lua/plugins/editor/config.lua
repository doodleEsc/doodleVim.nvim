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

function config.autopairs()
	require('nvim-autopairs').setup{}
	require("nvim-autopairs.completion.cmp").setup({
	  map_cr = true, --  map <CR> on insert mode
	  map_complete = true, -- it will auto insert `(` after select function or method item
	  auto_select = true -- automatically select the first item
	})
end

return config
