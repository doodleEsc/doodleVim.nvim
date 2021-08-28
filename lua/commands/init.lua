-- show signature in a function
-- vim.cmd [[autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')]]
vim.cmd [[autocmd CursorHoldI * silent! lua require('lspsaga.signaturehelp').signature_help()]]
