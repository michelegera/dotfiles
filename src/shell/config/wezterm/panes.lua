local wezterm = require 'wezterm'

local module = {}

-- Define a keybinding to move a pane in a specified direction
function module.move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

-- Define a keybinding to resize a pane in a specified direction
function module.resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 2 }
  }
end

return module
