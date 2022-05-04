-- vim.cmd [[command! GruvboxDump lua require('doodleVim.extend.gruvbox').dump()]]
-- vim.cmd [[command! ReloadConfig lua require("doodleVim.extend.misc").reload()]]
-- vim.cmd [[command! OpenTree lua require('doodleVim.extend.tree').toggle()]]

vim.api.nvim_create_user_command("GruvboxDump", "lua require('doodleVim.extend.gruvbox').dump()", {})
vim.api.nvim_create_user_command("ReloadConfig", "lua require('doodleVim.extend.misc').reload()", {})
vim.api.nvim_create_user_command("OpenTree", "lua require('doodleVim.extend.tree').toggle()", {})
