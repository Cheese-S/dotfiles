local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_windows <const> = not is_darwin

-- windows only
if is_windows then
	config.default_prog = { "powershell.exe" }
	config.win32_system_backdrop = "Acrylic"
	config.window_background_opacity = 0.9
end

-- mac only
if is_darwin then
	config.macos_window_background_blur = 40
	config.window_background_opacity = 0.3
end

-- font
config.font = wezterm.font_with_fallback({
	{
		family = "CaskaydiaCove Nerd Font Mono",
	},
	{
		family = "Cascadia Code",
	},
})

config.font_size = 16.0

-- looks
config.color_scheme = "Gruvbox dark, hard (base16)"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.max_fps = 240
config.enable_tab_bar = false

-- keymap
local act = wezterm.action

-- custom toggle tabbar event
wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

-- workspace
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

-- plugins
-- splits
local splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- resurrect
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save()

-- workspace_switcher
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.get_choices = function(opts)
	-- this will ONLY show the workspace elements, NOT the Zoxide results
	return workspace_switcher.choices.get_workspace_elements({})
end

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
end)

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- tabs
	{
		key = "t",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	-- panes
	{
		key = "l",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Left",
			size = { Percent = 50 },
		}),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Up",
			size = { Percent = 50 },
		}),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
			resurrect.tab_state.save_tab_action()
		end),
	},
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					relative = true,
					restore_text = true,
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
				}
				if type == "workspace" then
					local state = resurrect.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	},
	-- workspaces
	{
		key = "g",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	--misc
	{
		key = "F9",
		action = act.EmitEvent("toggle-tabbar"),
	},
}

for i = 1, 4 do
	-- F1 through F4 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

-- Splits that work across nvim and wezterm
splits.apply_to_config(config, {
	direction_keys = {
		move = { "h", "j", "k", "l" },
		resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	},
	modifiers = {
		move = "CTRL",
		resize = "CTRL",
	},
})

return config
