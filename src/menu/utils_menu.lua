-- utils_menu.lua

-- LIBS --
local lib_love = require("love")

-- MODS --
local mod_utils_main = require("src/utils_main")


-- VARIABLES --
local color_menu = {}
local font_menu = {}
local background_menu = {}
local state_menu = "start_menu"
-- start_menu
-- create_menu
-- settings_menu

-- CALLBACKS outside function --
local function callback_menu_deactivate()
  mod_utils_main.state_pause = false
end

local function callback_menu_activate()
  state_menu = "start_menu"
  mod_utils_main.state_pause = true
end

-- LOADS --
local function load_utils_menu()
  background_menu.image = lib_love.graphics.newImage("assets/images/paused_800x600.png");
  background_menu.width = background_menu.image:getWidth();
  background_menu.height = background_menu.image:getHeight();
  background_menu.width_factor = mod_utils_main.screen_width / background_menu.width;
  background_menu.height_factor = mod_utils_main.screen_height / background_menu.height;

  color_menu.white = {1, 1, 1}
  color_menu.orange = {1, 0.5, 0}
  color_menu.green = {0, 1, 0}

  font_menu.text = lib_love.graphics.newFont("assets/fonts/pixel.otf", 20)
  font_menu.title = lib_love.graphics.newFont("assets/fonts/pixel.otf", 50)
end

-- DRAWS --
local function draw_utils_menu()
  lib_love.graphics.draw(background_menu.image, 0, 0, 0, background_menu.width_factor, background_menu.height_factor)
  lib_love.graphics.setColor(color_menu.white)
end

-- UTILS --
-- Проверка наведения мыши на пункт меню
local function check_m_state(point)
  local mouse_x, mouse_y = lib_love.mouse.getPosition()
  if mouse_x >= point.x and mouse_x <= point.x + point.w
  and mouse_y >= point.y and mouse_y <= point.y + point.h then
    return true
  else
    return false
  end
end

-- Проверка нажатия на пункт меню
local function check_click(point)
  if point.m_state then
    point.callback()
  end
end

-- Отрисовка с учетом наведения мыши (ораньжевое выделение)
local function draw_point_with_m_state(point)
  if point.m_state then
    lib_love.graphics.setColor(color_menu.orange)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color_menu.white)
  else
    lib_love.graphics.print(point.text, point.x, point.y)
  end
end

-- Отрисовка в случае, когда имеется уже выбранный пункт (зеленый)
local function draw_selected_with_m_state(point)
  if point.state then
    lib_love.graphics.setColor(color_menu.green)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color_menu.white)
  elseif point.m_state then
    lib_love.graphics.setColor(color_menu.orange)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color_menu.white)
  else
    lib_love.graphics.print(point.text, point.x, point.y)
  end
end

-- изменение значений внешних переменных
local function change_state_pause(bool)
  mod_utils_main.state_pause = bool
end

local function change_screen(width, height)
  mod_utils_main.screen_width = width
  mod_utils_main.screen_height = height
end

local function change_setmod()
  lib_love.window.setMode(mod_utils_main.screen_width, mod_utils_main.screen_height)
end

local function change_background()
  background_menu.width_factor = mod_utils_main.screen_width / background_menu.width
  background_menu.height_factor = mod_utils_main.screen_height / background_menu.height
end

return {
  load_utils_menu = load_utils_menu;
  draw_utils_menu = draw_utils_menu;

  check_m_state = check_m_state;
  check_click = check_click;

  draw_point_with_m_state = draw_point_with_m_state;
  draw_selected_with_m_state = draw_selected_with_m_state;

  callback_menu_activate = callback_menu_activate;
  callback_menu_deactivate = callback_menu_deactivate;

  color_menu = color_menu;
  background_menu = background_menu;
  font_menu = font_menu;
  state_menu = state_menu;

  -- Обработка внешних значений
  change_state_pause = change_state_pause;
  change_screen = change_screen;
  change_setmod = change_setmod;
  change_background = change_background;
}