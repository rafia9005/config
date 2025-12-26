local colors = {
  bg       = '#1a1b26',
  fg       = '#c0caf5',
  yellow   = '#e0af68',
  cyan     = '#7dcfff',
  darkblue = '#565f89',
  green    = '#9ece6a',
  orange   = '#ff9e64',
  violet   = '#9d7cd8',
  magenta  = '#bb9af7',
  blue     = '#7aa2f7',
  red      = '#f7768e'
}

local tokyonight_custom = {
  normal = {
    a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.darkblue },
    c = { fg = colors.fg, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
  },
  visual = {
    a = { fg = colors.bg, bg = colors.magenta, gui = 'bold' },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
  },
  inactive = {
    a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  },
}

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = tokyonight_custom,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    global_status = true,
  },
}
