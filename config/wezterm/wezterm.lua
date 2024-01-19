local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- window settings
config.enable_tab_bar = false
config.check_for_updates = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = 'NeverPrompt'

-- cursor stuff
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'Linear'

if wezterm.gui then
	local gpus = wezterm.gui.enumerate_gpus()
	config.webgpu_preferred_adapter = gpus[1]
	config.front_end = 'WebGpu'
end

-- font
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 13.0
config.line_height = 1.1
config.harfbuzz_features = {"zero" , "ss01", "cv05"}

-- disable alt+enter
config.keys = {
	{
		key = 'Enter',
		mods = 'META',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'h',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'l',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'j',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'k',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.DisableDefaultAssignment
	}
}

-- setup color scheme
local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()
config.colors = colors
config.window_frame = window_frame

return config
