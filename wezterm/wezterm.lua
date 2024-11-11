local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_windows <const> = not is_darwin

-- windows only
if is_windows then
    config.default_prog = { 'powershell.exe' }
    config.win32_system_backdrop = 'Acrylic'
    config.window_background_opacity = 0.0
end

-- mac only
if is_darwin then
    config.macos_window_background_blur = 40
    config.window_background_opacity = 0.3
end

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
config.color_scheme = 'Gruvbox Material (Gogh)'
config.window_decorations = 'RESIZE'

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- keymap
local act = wezterm.action

config.keys = {
    {
        key = 't',
        mods = 'SHIFT|ALT',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
}

return config

