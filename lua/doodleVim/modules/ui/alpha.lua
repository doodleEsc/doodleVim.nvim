local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local logo = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- local function pick_color()
-- 	local colors = {"String", "Identifier", "Keyword", "Number"}
-- 	return colors[math.random(#colors)]
-- end

local function footer()
	local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

dashboard.section.header.val = logo

dashboard.section.buttons.val = {
	dashboard.button("SPC f h", "  Recent Projects"),
	dashboard.button("SPC f f", "  Find File"),
	dashboard.button("SPC f b", "  File Browser"),
	dashboard.button("SPC p u", "  Update Plugins"),
	dashboard.button("e"      , "  New file", "<cmd>ene <CR>"),
    dashboard.button("s"      , "  Configuration", "<cmd>e $MYVIMRC<CR>"),
	dashboard.button("q"      , "  Quit", "<cmd>qa<cr>"),
}


-- dashboard.section.buttons.val = {
--   button("SPC t o", "  Recently opened files"),
--   button("SPC t f", "  Find file"),
--   button("SPC t l", "  Find word"),
--   button("SPC t F", "  File browser"),
--   button("SPC t 1", "  Find repo"),
--   button("SPC s s", "  Open session"),
--   button("SPC c n", "  New file"),
--   button("SPC p u", "  Update plugins"),
--   button("q", "  Quit", "<Cmd>qa<CR>"),
-- }
--


-- dashboard.section.buttons.val = {
--     dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
--     dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
--     dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
--     dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
--     dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
-- }


        -- button("e", "  New file", "<cmd>ene <CR>"),
        -- button("SPC f f", "  Find file"),
        -- button("SPC f h", "  Recently opened files"),
        -- button("SPC f r", "  Frecency/MRU"),
        -- button("SPC f g", "  Find word"),
        -- button("SPC f m", "  Jump to bookmarks"),
        -- button("SPC s l", "  Open last session"),

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

dashboard.opts = {
    layout = {
        { type = "padding", val = 4 },
        dashboard.section.header,
        { type = "padding", val = 4 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
    },
    opts = {
        margin = 5,
    },
}

alpha.setup(dashboard.opts)

vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  command = "set showtabline=0 laststatus=0 noruler",
})

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  callback = function()
    vim.api.nvim_create_autocmd("BufUnload", {
      group = "alpha_tabline",
      buffer = 0,
      command = "set showtabline=2 ruler laststatus=3",
    })
  end,
})
