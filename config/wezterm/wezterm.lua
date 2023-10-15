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

config.font = wezterm.font("Fira Code", { weight = "Regular" })
config.font_size = 13.0
config.line_height = 1.1
config.disable_default_key_bindings = true
config.keys = {}
config.harfbuzz_features = {"zero" , "ss01", "cv05"}

-- setup color scheme
local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()
config.colors = colors
config.window_frame = window_frame

return config
