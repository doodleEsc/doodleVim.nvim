-- enable syntax highlighting in solidity file
vim.cmd [[autocmd BufReadPost,BufNewFile *.sol setfiletype solidity]];

-- load all gruvbox dev tools
vim.cmd [[command GruvboxDump lua require('extend.gruvbox').dump()]]
