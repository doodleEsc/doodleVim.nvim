local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#fabd2f',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#b8bb26',
  orange   = '#FE8019',
  violet   = '#a9a1e1',
  magenta  = '#d3869b',
  blue     = '#83a598',
  red      = '#fb4934',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    disabled_filetypes = {'Outline', 'NvimTree', 'packer'},
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = {
      -- a = { fg = colors.fg, bg = colors.bg },
      -- b = { fg = colors.fg, bg = colors.bg },
      c = { fg = colors.fg, bg = colors.bg },
    },
      inactive = {
      x = { fg = colors.fg, bg = colors.bg },
      -- y = { fg = colors.fg, bg = colors.bg },
      -- z = { fg = colors.fg, bg = colors.bg },
    },
    },
  always_divide_middle = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {'nvim-tree'}
}

local function ins(section, component)
  table.insert(section, component)
end

-- Inserts a component in lualine_c at left section
local function ins_a(component)
  ins(config.sections.lualine_a, component)
end

local function ins_b(component)
  ins(config.sections.lualine_b, component)
end

local function ins_c(component)
  ins(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_x(component)
  ins(config.sections.lualine_x, component)
end

local function ins_y(component)
  ins(config.sections.lualine_y, component)
end

local function ins_z(component)
  ins(config.sections.lualine_z, component)
end

ins_c {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    return ''
  end,
  color = 'LualineMode',
  padding = { left = 0, right = 1 },
}

ins_c {
  'filename',
  file_status = false,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.green, gui = 'bold' },
  padding = { left = 1, right = 1 },
  separator = "┃",
}

ins_c {
  'diagnostics',
  sources = {'nvim_lsp'},
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
  separator = "┃",
}

ins_x {
  'location',
  padding = { left = 0, right = 0 },
  color = { fg = colors.fg, gui = 'bold' },
  separator = "-",
}

ins_x {
  'progress',
  padding = { left = 0, right = 1 },
  color = { fg = colors.fg, gui = 'bold' },
  separator = "-",
}

ins_x {
  'filesize',
  cond = conditions.buffer_not_empty,
  padding = { left = 1, right = 1 },
  color = { fg = colors.fg, gui = 'bold' },
  separator = "┃",
}

-- Add components to right sections
ins_x {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
  padding = { left = 1, right = 0 },
}

ins_x {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
  padding = { left = 1, right = 1 },
  separator = "┃",
}

ins_x {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
  padding = { left = 1, right = 0},
}

ins_x {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

-- Now don't forget to initialize lualine
lualine.setup(config)
