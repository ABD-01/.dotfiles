local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

-- Font settings
config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 12.0

-- Color themes cycling setup
local themes = {
  'Sonokai (Gogh)',
  'Dracula (base16)',
  'Gruvbox dark, soft (base16)',
  'Papercolor Dark (Gogh)',
  'Clone Of Ubuntu (Gogh)',
}
local current_theme = 2
config.color_scheme = themes[current_theme]

-- Set default program to Git Bash
config.default_prog = { 'C:/Program Files/Git/bin/bash.exe', '-i', '-l' }

-- Powershell and UCRT64 shells
-- ref: https://github.com/wezterm/wezterm/discussions/4643#discussioncomment-7771091
local launch_menu = {}
local ucrt_cmd = {
  label = "MSYS UCRT64",
  args = { "cmd.exe", "/c", "C:\\msys64\\msys2_shell.cmd -defterm -here -no-start -ucrt64" },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	table.insert(launch_menu, ucrt_cmd)
	table.insert(launch_menu, {
		label = "Command Prompt",
		args = { "cmd.exe" },
	})
end

config.launch_menu = launch_menu


-- Keybindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Pane navigation with Ctrl+h/j/k/l
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- Pane splits
  { key = 'v', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER|ALT', action = act.SplitHorizontal(ucrt_cmd) },
  { key = 'h', mods = 'LEADER|ALT', action = act.SplitVertical(ucrt_cmd) },

  -- pane resize
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'UpArrow'  , mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },

  -- Rotate panes counter-clockwise
  { key = 'R', mods = 'CTRL|SHIFT', action = act.RotatePanes 'CounterClockwise' },

  -- New tab
  { key = 't', mods = 'CTRL|ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  
  -- Launch MSYS2 UCRT64 in a new tab
  { key = 't', mods = 'LEADER|CTRL', action = act.SpawnCommandInNewTab(ucrt_cmd) },

  -- Cycle themes
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      current_theme = current_theme + 1
      if current_theme > #themes then
        current_theme = 1
      end
      window:set_config_overrides({
        color_scheme = themes[current_theme],
      })
    end),
  },
  {
    key = "Y",
    mods = "CTRL|SHIFT",
    action = act.EmitEvent("show-theme"),
  },
}

wezterm.on("show-theme", function(window, pane)
    local theme = window:effective_config().color_scheme or "Default"
    window:toast_notification("WezTerm Theme", "Current theme: " .. theme, nil, 4000)
end)

-- GPU Preference
-- config.webgpu_preferred_adapter = {
--   backend = "Dx12",
--   device = 27015,
--   device_type = "DiscreteGpu",
--   driver_info = "21.30.23.04",
--   name = "AMD Radeon (TM) RX 640",
--   vendor = 4098
-- }
-- config.webgpu_power_preference = 'HighPerformance'

-- Terminal settings
config.window_close_confirmation = 'NeverPrompt'
config.term = "xterm-256color" 
config.window_background_opacity = 0.8
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false


-- Window appearance
-- config.window_decorations = "NONE | RESIZE"
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

config.front_end = "WebGpu"

config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.7 }

-- config.background = {
-- ( ){
--    source = {
--       File = "C:/Users/Abdullah/Downloads/Wallpapers2/31213062-desert-wallpaper-4k-doom-sand-dunes.jpg",
--     },
--     opacity = 0.99,
--     horizontal_align = "Center"
--   }
-- }

return config
