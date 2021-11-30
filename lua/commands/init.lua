-- show signature in a function
vim.cmd [[autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')]]
vim.cmd [[au BufRead,BufNewFile *.sol setfiletype solidity]];
-- vim.cmd [[command! -nargs=+ Search ]]
