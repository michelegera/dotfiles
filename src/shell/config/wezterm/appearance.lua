local wezterm = require 'wezterm'

local module = {}

-- Check if the current appearance is dark mode
function module.is_dark()
  if wezterm.gui then
    -- Return true if the appearance contains "Dark"
    return wezterm.gui.get_appearance():find("Dark")
  end

  -- Default to true (dark mode) if wezterm.gui is not available
  return true
end

return module
