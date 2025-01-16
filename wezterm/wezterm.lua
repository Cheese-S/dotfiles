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

config.font_size = 13.0

-- looks
config.color_scheme = "Gruvbox Material (Gogh)"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.max_fps = 240

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
    -- workspaces
    {
        key = "p",
        mods = "LEADER",
        action = act.ShowLauncherArgs({
            flags = "FUZZY|WORKSPACES",
        }),
    },
    {
        key = "n",
        mods = "LEADER",
        action = act.PromptInputLine({
            description = wezterm.format({
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Enter name for new workspace" },
            }),
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace({
                            name = line,
                        }),
                        pane
                    )
                end
            end),
        }),
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

-- plugins
-- splits
local splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
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

-- resurrect

return config
