local wezterm = require 'wezterm'
local constants = require 'constants'

local function tab_title(tab)
  local title = tab.tab_title

  if title and #title > 0 then
    return title
  end

  return tab.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local palette = config.resolved_palette.tab_bar

  local colors = {
    bg = palette.background,
    tab = tab.is_active and palette.active_tab.bg_color or palette.inactive_tab.bg_color,
    fg = tab.is_active and palette.active_tab.fg_color or palette.inactive_tab.fg_color,
  }

  local title = tab_title(tab)

  if #title > max_width - 4 then -- two spacers plus two separators
    title = wezterm.truncate_right(title, max_width - 5) .. "…"
  end

  return {
    { Background = { Color = colors.bg } },
    { Foreground = { Color = colors.tab } },
    { Text = constants.SEPARATOR },
    { Background = { Color = colors.tab } },
    { Foreground = { Color = colors.fg } },
    { Text = constants.SPACER .. title .. constants.SPACER },
    { Background = { Color = colors.tab } },
    { Foreground = { Color = colors.bg } },
    { Text = constants.SEPARATOR },
  }
end)
