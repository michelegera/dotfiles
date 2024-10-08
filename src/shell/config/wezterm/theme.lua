local config = {}

-- Halcyon theme (https://halcyon-theme.netlify.app)
local colors = {
  background = "#1d2433",
  foreground = '#a2aabc',

  cursor_bg = '#ffd580',
  cursor_fg = '#171c28',
  cursor_border = '#ffd580', -- same as cursor_bg

  selection_bg = '#2f3b54',
  selection_fg = '#d7dce2',

  ansi = {
    '#171c28', -- black
    '#ef6b73', -- red
    '#bae67e', -- green
    '#ffae57', -- yellow
    '#5ccfe6', -- blue
    '#c3a6ff', -- orange (magentas usually)
    '#5ccfe6', -- cyan
    '#d7dce2', -- white
  },

  brights = {
    '#8695b7', -- black
    '#f07178', -- red
    '#bae67e', -- green
    '#ffd580', -- yellow
    '#5ccfe6', -- blue
    '#c3a6ff', -- orange (magentas usually)
    '#5ccfe6', -- cyan
    '#d7dce2', -- white
  },

  tab_bar = {
    background = '#1d2433',

    active_tab = {
      bg_color = '#2f3b54',
      fg_color = '#d7dce2',
    },

    inactive_tab = {
      bg_color = '#1d2433',
      fg_color = '#a2aabc',
    },
  },
}

config.colors = colors

return config
