require("constants")

local wezterm = require("wezterm")
local constants = require("constants")

wezterm.on("update-status", function(window, _pane)
  local color_scheme = window:effective_config().resolved_palette

  local bg = wezterm.color.parse(color_scheme.background)

  -- Defaults
  local stat = window:active_workspace()
  local stat_icon = wezterm.nerdfonts.fa_laptop
  local stat_color = wezterm.color.parse(color_scheme.ansi[4])

  if window:active_key_table() then
    stat = window:active_key_table()
    stat_icon = wezterm.nerdfonts.oct_table
    stat_color = wezterm.color.parse(color_scheme.ansi[5])
  end

  if window:leader_is_active() then
    stat = "leader"
    stat_icon = wezterm.nerdfonts.oct_command_palette
    stat_color = wezterm.color.parse(color_scheme.ansi[6])
  end

  -- Left status
  window:set_left_status(wezterm.format({
    { Background = { Color = stat_color } },
    { Foreground = { Color = bg } },
    { Text = constants.SPACER .. stat_icon .. constants.SPACER },
    { Text = constants.SPACER .. stat .. constants.SPACER },
    { Text = constants.SEPARATOR },
  }))

  -- Right status
  local segments = {
    {
      icon = wezterm.nerdfonts.md_server,
      color = wezterm.color.parse(color_scheme.ansi[6]),
      content = wezterm.hostname(),
    },
    {
      icon = wezterm.nerdfonts.md_calendar_clock,
      color = wezterm.color.parse(color_scheme.ansi[5]),
      content = wezterm.strftime("%Y-%m-%d %H:%M"),
    },
  }

  local elements = {}

  -- Build the status bar elements from the segments
  for _i, seg in ipairs(segments) do
    table.insert(elements, { Foreground = { Color = seg.color } })
    table.insert(elements, { Text = constants.SEPARATOR })
    table.insert(elements, { Foreground = { Color = bg } })
    table.insert(elements, { Background = { Color = seg.color } })
    table.insert(elements, { Text = constants.SPACER .. seg.icon })
    table.insert(elements, { Text = constants.SPACER .. seg.content .. constants.SPACER })
  end

  window:set_right_status(wezterm.format(elements))
end)
