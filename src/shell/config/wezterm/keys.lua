local wezterm = require 'wezterm'
local constants = require 'constants'
local config = {}

config.leader = {
  key = 'a',
  mods = 'CTRL',
  timeout_milliseconds = constants.TIMEOUT_MS
}

config.keys = {
  -- Workspace management
  ------------------------------------------------------------------------------

  -- Switch
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },

  -- Rename
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for workspace',
      action = wezterm.action_callback(function(_window, _pane, line)
        if line then
          wezterm.mux.rename_workspace(
            wezterm.mux.get_active_workspace(), line
          )
        end
      end),
    },
  },


  -- Tab management
  ------------------------------------------------------------------------------

  -- Create
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain'
  },

  -- Rename
  {
    key = 'e',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _pane, input)
        if input then
          window:active_tab():set_title(input)
        end
      end),
    },
  },

  -- Navigate
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = ']',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1)
  },

  -- Move
  {
    key = 'm',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'move_tab',
      one_shot = false,
      timeout_milliseconds = constants.TIMEOUT_MS,
    }
  },

  -- Navigate
  {
    key = 't',
    mods = 'LEADER',
    action = wezterm.action.ShowTabNavigator
  },


  -- Pane management
  ------------------------------------------------------------------------------

  -- Split
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- Move
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },

  -- Close
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },

  -- Resize
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
      timeout_milliseconds = constants.TIMEOUT_MS,
    }
  },

  -- Misc
  ------------------------------------------------------------------------------

  -- Send CTRL+A to terminal
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
}

-- Dynamically add keys for switching tabs
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end


return config
