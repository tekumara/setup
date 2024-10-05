-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

local act = wezterm.action

config.keys = {
  { key = 'PageUp', action = act.ScrollByPage(-1) },
  { key = 'PageDown', action = act.ScrollByPage(1) },
    -- clear scroll back and viewport
  { key = 'k', mods = 'CMD', action = act.ClearScrollback("ScrollbackAndViewport") },
  -- https://wezfurlong.org/wezterm/config/lua/keyassignment/SendKey.html
    -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  { key = 'LeftArrow', mods = 'OPT', action = act.SendKey { key = 'b', mods = 'ALT', }, },
  { key = 'RightArrow', mods = 'OPT', action = act.SendKey { key = 'f', mods = 'ALT' }, },
}

-- and finally, return the configuration to wezterm
return config
