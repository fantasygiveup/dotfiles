-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices.

config.line_height = 1.0
config.font_size = ${TTY_FONT_SIZE}

wezterm.on("increase-font-size", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.font_size = (overrides.font_size or config.font_size) + 1.0
  overrides.line_height = (overrides.line_height or config.line_height) + 0.4
  window:set_config_overrides(overrides)
end)

wezterm.on("decrease-font-size", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.font_size = math.max((overrides.font_size or config.font_size) - 1.0, ${TTY_FONT_SIZE}) -- Keep it reasonable
  overrides.line_height = math.max((overrides.line_height or config.line_height) - 0.4, 1.0) -- Keep it reasonable
  window:set_config_overrides(overrides)
end)

wezterm.on("reset-font-size", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.font_size = ${TTY_FONT_SIZE}
  overrides.line_height = 1.0
  window:set_config_overrides(overrides)
end)

config.initial_cols = 511
config.initial_rows = 511
config.audible_bell = "Disabled" -- disable audio bell
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold" })
config.warn_about_missing_glyphs = false
config.use_fancy_tab_bar = false
config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "HorizontalLcd"
config.window_decorations = "NONE"
config.cell_width = 0.9 -- letter spacing
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = ${TTY_INACTIVE_PANE_BRIGHTNESS},
}
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
  foreground = "${TTY_COLOR_FG0}",
  background = "${TTY_COLOR_BG0}",
  cursor_bg = "${TTY_COLOR_FG0}",
  cursor_fg = "${TTY_COLOR_BG0}",
  split = "${TTY_COLOR_WHITE}",
  selection_bg = "${TTY_COLOR_FG0}",
  selection_fg = "${TTY_COLOR_BG0}",

  ansi = {
    "${TTY_COLOR_BLACK}",
    "${TTY_COLOR_RED}",
    "${TTY_COLOR_GREEN}",
    "${TTY_COLOR_YELLOW}",
    "${TTY_COLOR_BLUE}",
    "${TTY_COLOR_MAGENTA}",
    "${TTY_COLOR_CYAN}",
    "${TTY_COLOR_WHITE}",
  },
  brights = {
    "${TTY_COLOR_BRIGHT_BLACK}",
    "${TTY_COLOR_BRIGHT_RED}",
    "${TTY_COLOR_BRIGHT_GREEN}",
    "${TTY_COLOR_BRIGHT_YELLOW}",
    "${TTY_COLOR_BRIGHT_BLUE}",
    "${TTY_COLOR_BRIGHT_MAGENTA}",
    "${TTY_COLOR_BRIGHT_CYAN}",
    "${TTY_COLOR_BRIGHT_WHITE}",
  },
  tab_bar = {
    background = "${TTY_COLOR_BG0}",
    -- Disable new tab by hiding under bg color.
    new_tab = {
      fg_color = "${TTY_COLOR_BG0}",
      bg_color = "${TTY_COLOR_BG0}",
    },
    new_tab_hover = {
      fg_color = "${TTY_COLOR_BG0}",
      bg_color = "${TTY_COLOR_BG0}",
    },
  },
}

config.window_frame = {
  active_titlebar_bg = "${TTY_COLOR_BG2}",
  inactive_titlebar_bg = "${TTY_COLOR_BG2}",
}

config.disable_default_key_bindings = false
config.keys = {
  {
    key = "=",
    mods = "CTRL",
    action = wezterm.action.EmitEvent("increase-font-size"),
  },
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.EmitEvent("decrease-font-size"),
  },
  {
    key = "0",
    mods = "CTRL",
    action = wezterm.action.EmitEvent("reset-font-size"),
  },
}

return config
