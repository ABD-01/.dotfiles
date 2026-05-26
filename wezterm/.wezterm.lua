local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

local home = wezterm.home_dir
local hostname = wezterm.hostname()

-- Per-machine wallpaper base directories
local wp_dir, wp4_dir, wp_misc_dir
if hostname == "TODO_ABDUL_HOSTNAME" then  -- main machine (abdul)
  wp_dir      = home .. "/Downloads/wallpapers3"
  wp4_dir     = home .. "/Downloads/Wallpapers4"
  wp_misc_dir = home .. "/Downloads/Wallpapers"
else  -- muhsha machine
  wp_dir      = home .. "/Downloads/Previous/Icons-and-Wallpapaers/wallpapers3"
  wp4_dir     = home .. "/Downloads/Previous/Wallpapers4"
  wp_misc_dir = home .. "/Downloads/Previous/Wallpapers"
end

-- Font settings
config.font = wezterm.font('FiraCode Nerd Font Mono')
config.font_size = 12.0

-- Color themes cycling setup
local themes = {
  'Sonokai (Gogh)',
  'Dracula (base16)',
  'Gruvbox dark, soft (base16)',
  'Catppuccin Latte (Gogh)',
  'Papercolor Dark (Gogh)',
  'Clone Of Ubuntu (Gogh)',
  'Nord (Gogh)',
  'NvimDark',
  'OneDark (base16)',
  'OneDark (Gogh)',
  'rebecca',
}
local current_theme = 3
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

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(launch_menu, {
    label = "PowerShell",
    args = { "powershell.exe", "-NoLogo" },
  })
  table.insert(launch_menu, ucrt_cmd)
  table.insert(launch_menu, x64_vcvars_cmd)
end

config.launch_menu = launch_menu

config.ssh_domains = {
  {
    name = 'devcompute',
    remote_address = 'devcompute',
    multiplexing = 'None',
  },
}


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
  { key = 'v', mods = 'LEADER|ALT', action = act.SplitHorizontal { domain = { DomainName = 'devcompute' } } },
  { key = 'h', mods = 'LEADER|ALT', action = act.SplitVertical { domain = { DomainName = 'devcompute' } } },

  -- pane resize
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'UpArrow'  , mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },

  -- Rotate panes counter-clockwise
  { key = 'R', mods = 'CTRL|SHIFT', action = act.RotatePanes 'CounterClockwise' },

  -- New tab
  { key = 't', mods = 'CTRL|ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  
  -- Launch devcompute SSH in a new tab
  { key = 't', mods = 'LEADER|CTRL', action = wezterm.action_callback(function(window, pane)
      local tab, _, _ = window:mux_window():spawn_tab({ domain = { DomainName = 'devcompute' } })
      tab:set_title("Dev Compute")
    end)
  },

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

  -- Wrap current command with run(): Ctrl+A (BOL) → "r " → Enter
  {
    key = 'Enter', mods = 'CTRL',
    action = act.Multiple {
      act.SendString '\x01_r ',
      act.SendKey { key = 'Enter' },
    },
  },

  -- change title
  {
    key = "E", 
    mods = "CTRL|SHIFT", 
    action = act.EmitEvent("change-tab-title"),
  }
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

config.webgpu_power_preference = 'HighPerformance'

-- Terminal settings
config.window_close_confirmation = 'NeverPrompt'
config.term = "xterm-256color" 
config.window_background_opacity = 1
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



local rubiks = {
    source = { File = wp4_dir .. "/rubiks-cube.png"},
    hsb = {brightness=0.9},
    --vertical_offset = "-15cell",
    horizontal_align = "Center"
}

local lollipop = {
    source = { File = wp_dir .. "/wallhaven-5gvgy3.jpg"},
    hsb = {brightness=0.06},
    vertical_offset = "-15cell",
    horizontal_align = "Center"
}

local sandstorm = {
    source = { File = wp_dir .. "/GuboP3NaUAAv0Sp.jpg"},
    hsb = {hue=1.5, saturation=1.1, brightness=0.103},
    horizontal_align = "Center"
}

local yxkp6x = {
    source = { File = wp_dir .. "/wallhaven-yxkp6x.jpg"},
    -- Gwen upsidedown
    height = 'Contain',
    hsb = {brightness=0.05},
}

local city_lights = {
    source = { File = wp_dir .. "/wallhaven-5yd6d5.png" },
    hsb = {brightness=0.07},
}


local katana = {
    source = { File = wp_misc_dir .. "/samurai-katana-warrior-sword-silhouette-fighting-battle-artw.jpg" },
    hsb = {hue=0.07, saturation=1.1, brightness=0.07},
    vertical_offset = "-3cell",
}

local bike = {
    source = { File = wp_dir .. "/wallhaven-l3dd1r.jpg" },
    hsb = {brightness=0.13},
}

local gwen = {
    source = { File = wp_dir .. "/image.jpg" },
    hsb = {hue=0.9, saturation=1.1, brightness=0.016},
}

local tifa = {
    source = { File = wp_dir .. "/wallhaven-x6kk2o.jpg"},
    -- height = 'Contain',
    hsb = {brightness=0.05},
}

local desktopHut_3960 = {
    source = { File = wp_dir .. "/desktopHut_3960.gif" },
    hsb = {brightness=0.04},
    horizontal_align = "Center",
}

local rrzz6m = {
    source = { File = wp_dir .. "/wallhaven-rrzz6m.png" },
    hsb = {brightness=0.08},
    vertical_offset = "-40cell",
}


local artstation = {
    source = { File = wp_dir .. "/artstation.jpg" },
    hsb = {brightness=0.08},
}

local cp1bmwginjrd1= {
    source = { File = wp_dir .. "/cp1bmwginjrd1.jpg" },
    hsb = {brightness=0.04},
}

local nutcracker = {
    source = { File = wp_dir .. "/RDT_20240626_1615582191250765174800272.jpg" },
    hsb = {brightness=0.04},
    vertical_offset = "-4cell",
}

local backgrounds = {
  rubiks,
  lollipop,
  sandstorm,
  artstation,
  city_lights,
  katana,
  bike,
}

local sfw_sensitive = {
  nutcracker,
  yxkp6x,
  gwen,
  desktopHut_3960,
  tifa,
  rrzz6m,
  cp1bmwginjrd1,
}

local current_bg = 1
-- config.background = {backgrounds[current_bg]}

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
          win:set_config_overrides({
            background = {sfw_sensitive[current_bg]}
            -- background = {sfw_sensitive[math.random(#sfw_sensitive)]}
          })
          current_bg = (current_bg % #sfw_sensitive) + 1
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


wezterm.on("increase-brightness", function(window, _)
  local overrides = window:get_config_overrides() or {}
  local bg = overrides.background and overrides.background[1] or backgrounds[current_bg]
  bg.hsb = bg.hsb or {}
  bg.hsb.brightness = math.min((bg.hsb.brightness or 0.1) + 0.03, 1.0)
  window:set_config_overrides({ background = {bg} })
end)

wezterm.on("decrease-brightness", function(window, _)
  local overrides = window:get_config_overrides() or {}
  local bg = overrides.background and overrides.background[1] or backgrounds[current_bg]
  bg.hsb = bg.hsb or {}
  bg.hsb.brightness = math.max((bg.hsb.brightness or 0.1) - 0.03, 0.0)
  window:set_config_overrides({ background = {bg} })
end)

wezterm.on("change-tab-title", function(window, pane)
  window:perform_action(
    wezterm.action.PromptInputLine {
      description = 'Enter new name for the tab',
      action = wezterm.action_callback(function(win, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
    pane
  )
end)

return config
