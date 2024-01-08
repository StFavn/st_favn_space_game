-- pause.lua

-- LIBS --
local lib_love   = require("love")
local mod_screen = require("screen")
local mod_state  = require("state")

-- VARIABLES --
local menu = {}
local settings = {}
local color = {}
local font = {}
local state_menu = "paused_menu"

-- CALLBACKS paused_menu --
local function callback_continue()
  mod_state.state_pause = false
end

local function callback_settings()
  state_menu = "paused_settings"
end

local function callback_exit()
  lib_love.event.quit()
end

-- CALLBACKS paused_settings --
local function callback_resol_800x600()
  mod_screen.screen_width = 800
  mod_screen.screen_height = 600

  lib_love.window.setMode(mod_screen.screen_width, mod_screen.screen_height)

  color.background.width_factor = mod_screen.screen_width / 800
  color.background.height_factor = mod_screen.screen_height / 600

  settings.resol_800x600.state = 1
  settings.resol_1024x768.state = 0
  settings.resol_1280x720.state = 0
  settings.full_screen_on.state = 0
  settings.full_screen_off.state = 1
end

local function callback_resol_1024x768()
  mod_screen.screen_width = 1024
  mod_screen.screen_height = 768

  lib_love.window.setMode(mod_screen.screen_width, mod_screen.screen_height)

  color.background.width_factor = mod_screen.screen_width / 800
  color.background.height_factor = mod_screen.screen_height / 600

  settings.resol_800x600.state = 0
  settings.resol_1024x768.state = 1
  settings.resol_1280x720.state = 0
  settings.full_screen_on.state = 0
  settings.full_screen_off.state = 1
end

local function callback_resol_1280x720()
  mod_screen.screen_width = 1280
  mod_screen.screen_height = 720

  lib_love.window.setMode(mod_screen.screen_width, mod_screen.screen_height)

  color.background.width_factor = mod_screen.screen_width / 800
  color.background.height_factor = mod_screen.screen_height / 600

  settings.resol_800x600.state = 0
  settings.resol_1024x768.state = 0
  settings.resol_1280x720.state = 1
  settings.full_screen_on.state = 0
  settings.full_screen_off.state = 1
end

local function callback_full_screen_on()
  local width, height = lib_love.window.getDesktopDimensions(1)
  lib_love.window.setMode(width, height, {fullscreen = true})

  color.background.width_factor = width / 800
  color.background.height_factor = height / 600

  settings.full_screen_on.state = 1
  settings.full_screen_off.state = 0
end

local function callback_full_screen_off()
  lib_love.window.setMode(mod_screen.screen_width, mod_screen.screen_height)
  settings.full_screen_on.state = 0
  settings.full_screen_off.state = 1
end

local function callback_settings_back()
  state_menu = "paused_menu"
end

-- CALLBACKS outside function --
local function callback_menu_deactivate()
  mod_state.state_pause = false
end

local function callback_menu_activate()
  state_menu = "paused_menu"
  mod_state.state_pause = true
end


-- LOADS --
local function load_pause()
  color.background = {
    image = lib_love.graphics.newImage("/assets/images/paused_800x600.png");
    width_factor = mod_screen.screen_width / 800;
    height_factor = mod_screen.screen_height / 600;
  }
  color.white = {1, 1, 1}
  color.orange = {1, 0.5, 0}
  color.green = {0, 1, 0}

  font.text = lib_love.graphics.newFont("/assets/fonts/pixel.otf", 20)
  font.title = lib_love.graphics.newFont("/assets/fonts/pixel.otf", 50)


  menu.title =    {text = "Пауза",      x = 100, y = 50,  w = 200, h = 50}
  menu.continue = {text = "Продолжить", x = 100, y = 150, w = 200, h = 25, m_state = 0, callback = callback_continue}
  menu.settings = {text = "Настройки",  x = 100, y = 200, w = 200, h = 25, m_state = 0, callback = callback_settings}
  menu.exit =     {text = "Выход",      x = 100, y = 250, w = 200, h = 25, m_state = 0, callback = callback_exit}

  settings.title =              {text = "Настройки",           x = 100, y = 50,  w = 200, h = 50}
  settings.window_state =       {text = "Оконный режим",       x = 100, y = 150, w = 200, h = 50}
  settings.resol_800x600 =      {text = "800x600",             x = 400, y = 150, w = 200, h = 25, state = 1, m_state = 0, callback = callback_resol_800x600}
  settings.resol_1024x768 =     {text = "1024x768",            x = 400, y = 175, w = 200, h = 25, state = 0, m_state = 0, callback = callback_resol_1024x768}
  settings.resol_1280x720 =     {text = "1280x720",            x = 400, y = 200, w = 200, h = 25, state = 0, m_state = 0, callback = callback_resol_1280x720}
  settings.full_screen =        {text = "Полноэкранный режим", x = 100, y = 250, w = 200, h = 50}
  settings.full_screen_on =     {text = "Вкл.",                x = 400, y = 250, w = 200, h = 25, state = 0, m_state = 0, callback = callback_full_screen_on}
  settings.full_screen_off =    {text = "Выкл.",               x = 400, y = 275, w = 200, h = 25, state = 1, m_state = 0, callback = callback_full_screen_off}
  settings.back =               {text = "Назад",               x = 100, y = 300, w = 200, h = 50, state = 0, m_state = 0, callback = callback_settings_back}
end


-- UPDATES --
-- Проверка наведения мыши на пункт меню
local function check_m_state(point)
  local mouse_x, mouse_y = lib_love.mouse.getPosition()
  if mouse_x >= point.x and mouse_x <= point.x + point.w
  and mouse_y >= point.y and mouse_y <= point.y + point.h then
    return 1
  else
    return 0
  end
end

-- Проверка нажатия на пункт меню
local function check_click(point)
  if point.m_state == 1 then
    point.callback()
  end
end

local function mousepressed_left_pause()
  if state_menu == "paused_menu" then
    check_click(menu.continue)
    check_click(menu.settings)
    check_click(menu.exit)
  elseif state_menu == "paused_settings" then
    check_click(settings.resol_800x600)
    check_click(settings.resol_1024x768)
    check_click(settings.resol_1280x720)
    check_click(settings.full_screen_on)
    check_click(settings.full_screen_off)
    check_click(settings.back)
  end
end

local function update_pause()
  if state_menu == "paused_menu" then
    menu.continue.m_state = check_m_state(menu.continue)
    menu.settings.m_state = check_m_state(menu.settings)
    menu.exit.m_state = check_m_state(menu.exit)
  elseif state_menu == "paused_settings" then
    settings.resol_800x600.m_state = check_m_state(settings.resol_800x600)
    settings.resol_1024x768.m_state = check_m_state(settings.resol_1024x768)
    settings.resol_1280x720.m_state = check_m_state(settings.resol_1280x720)
    settings.full_screen_on.m_state = check_m_state(settings.full_screen_on)
    settings.full_screen_off.m_state = check_m_state(settings.full_screen_off)
    settings.back.m_state = check_m_state(settings.back)
  end
end

-- DRAWS --
local function draw_point_with_m_state(point)
  if point.m_state == 1 then
    lib_love.graphics.setColor(color.orange)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color.white)
  else
    lib_love.graphics.print(point.text, point.x, point.y)
  end
end

local function draw_selected_with_m_state(point)
  if point.state == 1 then
    lib_love.graphics.setColor(color.green)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color.white)
  elseif point.m_state == 1 then
    lib_love.graphics.setColor(color.orange)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color.white)
  else
    lib_love.graphics.print(point.text, point.x, point.y)
  end
end

local function draw_pause()
  lib_love.graphics.draw(color.background.image, 0, 0, 0, color.background.width_factor, color.background.height_factor)
  lib_love.graphics.setColor(color.white)
  if state_menu == "paused_menu" then
    lib_love.graphics.setFont(font.title)
    lib_love.graphics.print(menu.title.text, menu.title.x, menu.title.y)
    lib_love.graphics.setFont(font.text)
    draw_point_with_m_state(menu.continue)
    draw_point_with_m_state(menu.settings)
    draw_point_with_m_state(menu.exit)
  elseif state_menu == "paused_settings" then
    lib_love.graphics.setFont(font.title)
    lib_love.graphics.print(settings.title.text, settings.title.x, settings.title.y)
    lib_love.graphics.setFont(font.text)
    lib_love.graphics.print(settings.window_state.text, settings.window_state.x, settings.window_state.y)
    draw_selected_with_m_state(settings.resol_800x600)
    draw_selected_with_m_state(settings.resol_1024x768)
    draw_selected_with_m_state(settings.resol_1280x720)
    lib_love.graphics.print(settings.full_screen.text, settings.full_screen.x, settings.full_screen.y)
    draw_selected_with_m_state(settings.full_screen_on)
    draw_selected_with_m_state(settings.full_screen_off)
    draw_point_with_m_state(settings.back)
  end
end

return {
  -- FUNCTIONS --
  load_pause = load_pause;
  update_pause = update_pause;
  draw_pause = draw_pause;
  mousepressed_left_pause = mousepressed_left_pause;

  callback_menu_activate = callback_menu_activate;
  callback_menu_deactivate = callback_menu_deactivate;
}