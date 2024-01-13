-- settings_menu.lua

local lib_love = require("love")
local mod_utils_menu = require("src/menu/utils_menu")

-- VARIABLES --
local settings_menu = {}


-- CALLBACKS paused_settings --
local function callback_resol_800x600()
  mod_utils_menu.change_screen(800, 600)
  mod_utils_menu.change_setmod()
  mod_utils_menu.change_background()


  settings_menu.resol_800x600.state = true
  settings_menu.resol_1024x768.state = false
  settings_menu.resol_1280x720.state = false
  settings_menu.full_screen_on.state = false
  settings_menu.full_screen_off.state = true
end

local function callback_resol_1024x768()
  mod_utils_menu.change_screen(1024, 768)
  mod_utils_menu.change_setmod()
  mod_utils_menu.change_background()

  settings_menu.resol_800x600.state = false
  settings_menu.resol_1024x768.state = true
  settings_menu.resol_1280x720.state = false
  settings_menu.full_screen_on.state = false
  settings_menu.full_screen_off.state = true
end

local function callback_resol_1280x720()
  mod_utils_menu.change_screen(1280, 720)
  mod_utils_menu.change_setmod()
  mod_utils_menu.change_background()

  settings_menu.resol_800x600.state = false
  settings_menu.resol_1024x768.state = false
  settings_menu.resol_1280x720.state = true
  settings_menu.full_screen_on.state = false
  settings_menu.full_screen_off.state = true
end

local function callback_full_screen_on()
  local width, height = lib_love.window.getDesktopDimensions(1)
  lib_love.window.setMode(width, height, {fullscreen = true})

  mod_utils_menu.background_menu.width_factor = width / 800
  mod_utils_menu.background_menu.height_factor = height / 600

  settings_menu.full_screen_on.state = true
  settings_menu.full_screen_off.state = false
end

local function callback_full_screen_off()
  lib_love.window.setMode(mod_utils_menu.screen_width, mod_utils_menu.screen_height)
  settings_menu.full_screen_on.state = false
  settings_menu.full_screen_off.state = true
end

local function callback_settings_back()
  mod_utils_menu.state_menu = "start_menu"
end

-- LOADS --
local function load_settings_menu()
  settings_menu.title =              {text = "Настройки",           x = 100, y = 50,  w = 200, h = 50}
  settings_menu.window_state =       {text = "Оконный режим",       x = 100, y = 150, w = 200, h = 50}
  settings_menu.resol_800x600 =      {text = "800x600",             x = 400, y = 150, w = 200, h = 25, state = false, m_state = false, callback = callback_resol_800x600}
  settings_menu.resol_1024x768 =     {text = "1024x768",            x = 400, y = 175, w = 200, h = 25, state = false, m_state = false, callback = callback_resol_1024x768}
  settings_menu.resol_1280x720 =     {text = "1280x720",            x = 400, y = 200, w = 200, h = 25, state = true,  m_state = false, callback = callback_resol_1280x720}
  settings_menu.full_screen =        {text = "Полноэкранный режим", x = 100, y = 250, w = 200, h = 50}
  settings_menu.full_screen_on =     {text = "Вкл.",                x = 400, y = 250, w = 200, h = 25, state = false, m_state = false, callback = callback_full_screen_on}
  settings_menu.full_screen_off =    {text = "Выкл.",               x = 400, y = 275, w = 200, h = 25, state = true,  m_state = false, callback = callback_full_screen_off}
  settings_menu.back =               {text = "Назад",               x = 100, y = 300, w = 200, h = 50, state = false, m_state = false, callback = callback_settings_back}
end

-- UPDATES --
local function update_settings_menu()
  settings_menu.resol_800x600.m_state = mod_utils_menu.check_m_state(settings_menu.resol_800x600)
  settings_menu.resol_1024x768.m_state = mod_utils_menu.check_m_state(settings_menu.resol_1024x768)
  settings_menu.resol_1280x720.m_state = mod_utils_menu.check_m_state(settings_menu.resol_1280x720)
  settings_menu.full_screen_on.m_state = mod_utils_menu.check_m_state(settings_menu.full_screen_on)
  settings_menu.full_screen_off.m_state = mod_utils_menu.check_m_state(settings_menu.full_screen_off)
  settings_menu.back.m_state = mod_utils_menu.check_m_state(settings_menu.back)
end

local function check_click_settings_menu()
  mod_utils_menu.check_click(settings_menu.resol_800x600)
  mod_utils_menu.check_click(settings_menu.resol_1024x768)
  mod_utils_menu.check_click(settings_menu.resol_1280x720)
  mod_utils_menu.check_click(settings_menu.full_screen_on)
  mod_utils_menu.check_click(settings_menu.full_screen_off)
  mod_utils_menu.check_click(settings_menu.back)
end

-- DRAWS --
local function draw_settings_menu()
  lib_love.graphics.setFont(mod_utils_menu.font_menu.title)
  lib_love.graphics.print(settings_menu.title.text, settings_menu.title.x, settings_menu.title.y)
  lib_love.graphics.setFont(mod_utils_menu.font_menu.text)
  lib_love.graphics.print(settings_menu.window_state.text, settings_menu.window_state.x, settings_menu.window_state.y)
  mod_utils_menu.draw_selected_with_m_state(settings_menu.resol_800x600)
  mod_utils_menu.draw_selected_with_m_state(settings_menu.resol_1024x768)
  mod_utils_menu.draw_selected_with_m_state(settings_menu.resol_1280x720)
  lib_love.graphics.print(settings_menu.full_screen.text, settings_menu.full_screen.x, settings_menu.full_screen.y)
  mod_utils_menu.draw_selected_with_m_state(settings_menu.full_screen_on)
  mod_utils_menu.draw_selected_with_m_state(settings_menu.full_screen_off)
  mod_utils_menu.draw_point_with_m_state(settings_menu.back)
end

return {
  load_settings_menu = load_settings_menu;
  update_settings_menu = update_settings_menu;
  draw_settings_menu = draw_settings_menu;

  check_click_settings_menu = check_click_settings_menu
}