-- WezTerm configuration
-- Symlinked to ~/.wezterm.lua by setup.zsh
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"JetBrains Mono",
	"Hack Nerd Font",
})
config.font_size = 12.0
config.line_height = 1.05

-- Window
config.window_background_opacity = 0.98
-- config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.scrollback_lines = 10000

-- Behavior
config.audible_bell = "Disabled"
config.check_for_updates = false

return config
