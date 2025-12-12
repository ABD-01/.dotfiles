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
  'Nord (Gogh)',
  'NvimDark',
  'OneDark (base16)',
  'OneDark (Gogh)',
  'rebecca',
}
local current_theme = 6
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
local x64_vcvars_cmd = {
  label = "x64 Native Tools Command Prompt for VS 2022",
  args = { os.getenv("COMSPEC"), "/k", [[C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat]] },
}
local ssh_noble_cmd = {
  label = "SSH into noble VM running in QEMU",
  args = { "ssh", "noble" },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	table.insert(launch_menu, ucrt_cmd)
	table.insert(launch_menu, x64_vcvars_cmd)
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
  { key = 'v', mods = 'LEADER|ALT', action = act.SplitHorizontal(ssh_noble_cmd) },
  { key = 'h', mods = 'LEADER|ALT', action = act.SplitVertical(ssh_noble_cmd) },

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
  { key = 't', mods = 'LEADER|CTRL', action = act.SpawnCommandInNewTab(ssh_noble_cmd) },

  -- Cycle themes
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = act.EmitEvent("cycle-theme"),
  },
  -- toast theme
  {
    key = "Y",
    mods = "CTRL|SHIFT",
    action = act.EmitEvent("show-theme"),
  },

  -- next bg
  {
    key = "B",
    mods = "CTRL|SHIFT",
    action = act.EmitEvent("toggle-next-background"),
  },
  {
    key = "B", 
    mods = "LEADER|CTRL", 
    action = act.EmitEvent("show-sensitive-bg"),
  },

  -- brightness
  { key = 'n', mods = 'LEADER|CTRL', action = act.EmitEvent("increase-brightness") },
  { key = 'm', mods = 'LEADER|CTRL', action = act.EmitEvent("decrease-brightness") },

  -- QEMU Ctrl+a x
  { key = 'x', mods = 'LEADER', action = act.SendKey { key = 'a', mods = 'CTRL' } },
}


wezterm.on("cycle-theme", function(window, pane)
  current_theme = current_theme + 1
  if current_theme > #themes then
    current_theme = 1
  end
  window:set_config_overrides({ color_scheme = themes[current_theme], })
end)

wezterm.on("show-theme", function(window, pane)
  local theme = window:effective_config().color_scheme or "Default"
  window:toast_notification("WezTerm Theme", "Current theme: " .. theme, nil, 4000)
end)

-- GPU Preference
config.webgpu_preferred_adapter = {
  backend = "Dx12",
  -- backend = "Vulcan",
  device = 27015,
  device_type = "DiscreteGpu",
  driver_info = "21.30.23.04",
  name = "AMD Radeon (TM) RX 640",
  vendor = 4098
}
config.webgpu_power_preference = 'HighPerformance'

-- Terminal settings
config.window_close_confirmation = 'NeverPrompt'
config.term = "xterm-256color" 
config.window_background_opacity = 0.8
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false


-- Window appearance
-- config.window_decorations = "NONE | RESIZE"
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

config.initial_rows = 32
config.initial_cols = 120

config.front_end = "WebGpu"

-- config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.7 }
config.inactive_pane_hsb = { brightness = 1 }

local lollipop = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/wallhaven-5gvgy3.jpg"},
    hsb = {brightness=0.06},
    vertical_offset = "-15cell",
    horizontal_align = "Center"
}

local sandstorm = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/GuboP3NaUAAv0Sp.jpg"},
    hsb = {hue=1.5, saturation=1.1, brightness=0.103},
    horizontal_align = "Center"
}

local yxkp6x = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/wallhaven-yxkp6x.jpg"},
    height = 'Contain',
    hsb = {brightness=0.05},
}

local city_lights = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/wallhaven-5yd6d5.png" },
    hsb = {brightness=0.07},
}


local katana = {
    source = { File = "C:/Users/Abdullah/Downloads/Wallpapers/samurai-katana-warrior-sword-silhouette-fighting-battle-artw.jpg" },
    hsb = {hue=0.07, saturation=1.1, brightness=0.07},
    vertical_offset = "-3cell",
}

local bike = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/wallhaven-l3dd1r.jpg" },
    hsb = {brightness=0.13},
}

local gwen = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/image.jpg" },
    hsb = {hue=0.9, saturation=1.1, brightness=0.016},
}

local tifa = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/wallhaven-x6kk2o.jpg"},
    height = 'Contain',
    hsb = {brightness=0.05},
}

local desktopHut_3960 = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/desktopHut_3960.gif" },
    hsb = {brightness=0.04},
    horizontal_align = "Center",
}

local rrzz6m = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/wallhaven-rrzz6m.png" },
    hsb = {brightness=0.08},
    vertical_offset = "-40cell",
}


local artstation = {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/artstation.jpg" },
    hsb = {brightness=0.08},
}

local cp1bmwginjrd1= {
    source = { File = "C:/Users/Abdullah/Downloads/wallpapers3/cp1bmwginjrd1.jpg" },
    hsb = {brightness=0.04},
}

local nutcracker = {
    source = { File = "C:/Users/Abdullah/Downloads/OccasionalKindlyNutcracker-ezgif.com-video-to-gif-converter.gif" },
    hsb = {brightness=0.04},
}

local backgrounds = {
  lollipop,
  sandstorm,
  artstation,
  city_lights,
  katana,
  bike,
}

local sfw_sensitive = {
  yxkp6x,
  gwen,
  desktopHut_3960,
  tifa,
  rrzz6m,
  cp1bmwginjrd1,
  nutcracker,
}

local current_bg = 1
-- config.background = {backgrounds[current_bg]}
-- config.background = {kokkoro}

wezterm.on("toggle-next-background", function(window, pane)
  current_bg = (current_bg % #backgrounds) + 1
  window:set_config_overrides({
    background = {backgrounds[current_bg]}
  })
end)

wezterm.on("show-sensitive-bg", function(window, pane)
  window:perform_action(
    wezterm.action.InputSelector {
      action = wezterm.action_callback(function(win, _, id, label)
        if label == "Yes" then
          current_bg = (current_bg % #sfw_sensitive) + 1
          win:set_config_overrides({
            background = {sfw_sensitive[current_bg]}
            -- background = {sfw_sensitive[math.random(#sfw_sensitive)]}
          })
        end
      end),
      title = "Are you sure?",
      choices = {
        { label = "Yes", id = "yes" },
        { label = "No", id = "no" },
      },
    },
    pane
  )
end)


local current_brightness = backgrounds[current_bg].hsb.brightness or 0.1

wezterm.on("increase-brightness", function(window, _)
  local overrides = window:get_config_overrides() or {}
  local bg = overrides.background and overrides.background[1] or backgrounds[current_bg]
  current_brightness = math.min((bg.hsb and bg.hsb.brightness or 0.1) + 0.03, 1.0)
  bg.hsb = bg.hsb or {}
  bg.hsb.brightness = current_brightness
  window:set_config_overrides({ background = {bg} })
end)

wezterm.on("decrease-brightness", function(window, _)
  local overrides = window:get_config_overrides() or {}
  local bg = overrides.background and overrides.background[1] or backgrounds[current_bg]
  current_brightness = math.max((bg.hsb and bg.hsb.brightness or 0.1) - 0.03, 0.0)
  bg.hsb = bg.hsb or {}
  bg.hsb.brightness = current_brightness
  window:set_config_overrides({ background = {bg} })
end)

return config
