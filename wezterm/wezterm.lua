local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { 'powershell.exe' }

-- font
config.font = wezterm.font_with_fallback({
	{
		family = "CaskaydiaCove Nerd Font Mono"
	},
	{
		family = "Cascadia Code"
	},
})

-- looks
config.color_scheme = 'Catppuccin Macchiato'
config.window_background_opacity = 0.0
config.window_decorations = 'RESIZE'
config.win32_system_backdrop = 'Acrylic'

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config

