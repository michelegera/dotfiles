local wezterm = require 'wezterm'
local config = {}

config.adjust_window_size_when_changing_font_size = false
config.font = wezterm.font 'MonoLisa Nerd Font'
config.font_size = 12.0
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

return config
