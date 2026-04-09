local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font('MesloLGS Nerd Font', { weight = 'Regular' })
config.font_size = 14.0
config.line_height = 1.2
config.cell_width = 1.0

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'

-- Window - frosted glass look
config.window_background_opacity = 0.85
config.macos_window_background_blur = 40
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
  left = 20,
  right = 20,
  top = 15,
  bottom = 15,
}
config.initial_cols = 140
config.initial_rows = 40

-- Custom tab bar - sleek minimal style
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32

config.colors = {
  tab_bar = {
    background = 'rgba(30, 30, 46, 0.9)',
    active_tab = {
      bg_color = '#cba6f7',
      fg_color = '#1e1e2e',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = 'rgba(49, 50, 68, 0.8)',
      fg_color = '#6c7086',
    },
    inactive_tab_hover = {
      bg_color = '#45475a',
      fg_color = '#cdd6f4',
    },
    new_tab = {
      bg_color = 'rgba(30, 30, 46, 0.9)',
      fg_color = '#6c7086',
    },
    new_tab_hover = {
      bg_color = '#45475a',
      fg_color = '#cba6f7',
    },
  },
}

-- Fancy tab title with icons
wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
  local title = tab.active_pane.title
  if title and #title > 20 then
    title = title:sub(1, 20) .. '…'
  end
  local icon = tab.active_pane.title:find('zsh') and '  ' or '  '
  if tab.is_active then
    return {
      { Text = ' ' .. icon .. title .. ' ' },
    }
  end
  return {
    { Text = ' ' .. icon .. title .. ' ' },
  }
end)

-- Cursor - smooth blinking underline
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = 'EaseIn'
config.cursor_blink_ease_out = 'EaseOut'

-- Inactive pane dimming
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.6,
}

-- Scrollback
config.scrollback_lines = 10000

-- Key bindings
config.keys = {
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = false } },
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  -- Quick pane zoom toggle
  { key = 'z', mods = 'CMD', action = wezterm.action.TogglePaneZoomState },
  -- Font size
  { key = '=', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },
}

-- Default shell
config.default_prog = { '/opt/homebrew/bin/zsh', '-l' }

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 150,
  target = 'CursorColor',
}

-- Performance
config.max_fps = 120
config.animation_fps = 120
config.front_end = 'WebGpu'

-- Smooth window resize
config.window_frame = {
  font = wezterm.font('MesloLGS Nerd Font', { weight = 'Bold' }),
  font_size = 12.0,
}

-- Non-blocking status bar: reads from cache files written by background scripts
local function read_cache(path, fallback)
  local f = io.open(path, 'r')
  if not f then return fallback end
  local text = f:read('*a'):gsub('%s+$', '')
  f:close()
  return text ~= '' and text or fallback
end

local function trigger_bg_refresh()
  os.execute('~/.local/bin/get_temp.sh > /dev/null 2>&1 &')
  os.execute('~/.local/bin/get_location.sh > /dev/null 2>&1 &')
end

-- Kick off initial background fetch
trigger_bg_refresh()

wezterm.on('update-right-status', function(window, pane)
  local weather = read_cache('/tmp/weather_cache.txt', '🌡️ …')
  local location = read_cache('/tmp/location_cache.txt', '📍 …')
  local date = wezterm.strftime('%m/%d')
  local time = wezterm.strftime('%I:%M %p %Z')

  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#a6e3a1' } }, { Text = '📍 ' .. location .. '  ' },
    { Foreground = { Color = '#f9e2af' } }, { Text = weather .. '  ' },
    { Foreground = { Color = '#89b4fa' } }, { Text = '📅 ' .. date .. '  ' },
    { Foreground = { Color = '#cba6f7' } }, { Text = '🕘 ' .. time .. ' ' },
  }))
end)

return config
