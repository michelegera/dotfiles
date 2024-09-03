local config = {}

config.check_for_updates = false
config.window_close_confirmation = "NeverPrompt"

-- Avoid unexpected config breakage and unusable terminal
config.automatically_reload_config = false

-- Make sure word selection stops on most punctuations.
--
-- Note that dot (.) & slash (/) are allowed though for
-- easy selection of (partial) paths.
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@│┃*…$"

-- Disable all noises
config.audible_bell = "Disabled"

return config
