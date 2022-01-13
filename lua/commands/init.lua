
-- show signature in a function
vim.cmd [[autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')]]

-- enable syntax highlighting in solidity file
vim.cmd [[autocmd BufReadPost,BufNewFile *.sol setfiletype solidity]];

-- load all gruvbox dev tools
vim.cmd [[command GruvboxDump lua require('extend.gruvbox').dump()]]
