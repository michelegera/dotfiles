local wezterm = require("wezterm")

return {
  -- Hide tab bar, since we use a terminal multiplexer
  enable_tab_bar = false,

  -- Remove vertical padding
  window_padding = {
    top = 0,
    bottom = 0,
  },

  -- Use a nerd font
  font = wezterm.font("MonoLisa Nerd Font"),
  font_size = 12.0,

  -- Set color scheme
  color_scheme = "tokyonight_moon",

  -- Set cursor style
  default_cursor_style = "BlinkingUnderline",
}
