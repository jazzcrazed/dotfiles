-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "Batman"

config.enable_tab_bar = false

if wezterm.target_triple:find("linux") ~= nil then
  config.window_decorations = "NONE"
end

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

-- Leader key
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- splitting
	{
		mods = "LEADER",
		key = "%",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = '"',
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = ";",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

-- and finally, return the configuration to wezterm
return config
