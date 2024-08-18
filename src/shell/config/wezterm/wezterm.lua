local wezterm = require 'wezterm'
local projects = require 'projects'
local appearance = require 'appearance'
local panes = require 'panes'

local config = wezterm.config_builder()

-- Set the default cursor style to a blinking underline
config.default_cursor_style = 'BlinkingUnderline'

-- Set the color scheme to 'Halcyon'
config.color_scheme = 'Halcyon'

-- Set the font to 'MonoLisa Nerd Font'
config.font = wezterm.font({ family = 'MonoLisa Nerd Font' })

-- Set the window background opacity and macOS window background blur
config.window_background_opacity = 0.98
config.macos_window_background_blur = 25

-- Configure the window decorations
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'

-- Configure the window frame font and font size
config.window_frame = {
  font = wezterm.font({ family = 'MonoLisa Nerd Font', weight = 'Bold' }),
  font_size = 11,
}

-- Set the leader key to 'CTRL+a' with a timeout of 1000 milliseconds
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Define keybindings for various actions
config.keys = {
  -- Split the pane horizontally
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split the pane vertically
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Send 'CTRL+a' to the terminal
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
  -- Activate the resize panes key table
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      one_shot = false,
      timeout_milliseconds = 1000,
    }
  },
  -- Trigger project selection using the LEADER+p keybinding
  {
    key = 'p',
    mods = 'LEADER',
    action = projects.choose_project(),
  },
  -- Show the launcher with fuzzy matching and workspaces using LEADER+f
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },

  -- Define keybindings for moving the pane
  panes.move_pane('j', 'Down'),
  panes.move_pane('k', 'Up'),
  panes.move_pane('h', 'Left'),
  panes.move_pane('l', 'Right'),
}

-- Define key tables for resizing panes
config.key_tables = {
  resize_panes = {
    panes.resize_pane('j', 'Down'),
    panes.resize_pane('k', 'Up'),
    panes.resize_pane('h', 'Left'),
    panes.resize_pane('l', 'Right'),
  },
}

-- Define a function to generate segments for the right status bar
local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M:%S'),
    wezterm.hostname(),
  }
end

-- Update the status bar when the 'update-status' event is triggered
wezterm.on('update-status', function(window, _)
  local SEPARATOR = wezterm.nerdfonts.ple_lower_right_triangle
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette

  local bg = wezterm.color.parse(color_scheme.background)
  local fg = wezterm.color.parse(color_scheme.foreground)

  local gradient_to = bg
  local gradient_from

  -- Determine the gradient color based on the appearance (dark or light)
  if appearance.is_dark() then
    gradient_from = gradient_to:lighten(0.2)
  else
    gradient_from = gradient_to:darken(0.2)
  end

  -- Create a horizontal gradient based on the number of segments
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments
  )

  local elements = {}

  -- Build the status bar elements from the segments
  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SEPARATOR })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  -- Set the right status with the formatted elements
  window:set_right_status(wezterm.format(elements))
end)

return config
