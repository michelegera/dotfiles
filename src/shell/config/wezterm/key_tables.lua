local wezterm = require 'wezterm'
local config = {}

local key_tables = {
  resize_pane = {
    { key = 'h', action = wezterm.action.AdjustPaneSize { 'Left', 2 } },
    { key = 'j', action = wezterm.action.AdjustPaneSize { 'Down', 2 } },
    { key = 'k', action = wezterm.action.AdjustPaneSize { 'Up', 2 } },
    { key = 'l', action = wezterm.action.AdjustPaneSize { 'Right', 2 } },
  },

  move_tab = {
    { key = 'h', action = wezterm.action.MoveTabRelative(-1) },
    { key = 'l', action = wezterm.action.MoveTabRelative(1) },
  }
}

config.key_tables = key_tables

return config
