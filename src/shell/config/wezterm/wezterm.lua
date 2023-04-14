local wezterm = require 'wezterm'
local act = wezterm.action

return {
	-- Hide tab bar, since we use tmux
	enable_tab_bar = false,

	-- Remove vertical padding
	window_padding = {
    top = 0,
    bottom = 0,
  },

	-- Use a nerd font
	font = wezterm.font 'MonoLisa Nerd Font',
	font_size = 13.0,

	-- Set color scheme
	color_scheme = "Catppuccin Macchiato", -- or Mocha, Frappe, Latte

  -- Set cursor style
  default_cursor_style = "SteadyUnderline",
}
