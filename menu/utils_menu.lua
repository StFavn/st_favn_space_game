-- utils_menu.lua

-- LIBS --
local lib_love = require("love")
local mod_screen = require("screen")
local mod_state = require("state")

-- VARIABLES --
local color_menu = {}
local font_menu = {}
local state_menu = "start_menu"
-- start_menu
-- settings_menu

-- CALLBACKS outside function --
local function callback_menu_deactivate()
  mod_state.state_pause = false
end

local function callback_menu_activate()
  state_menu = "start_menu"
  mod_state.state_pause = true
end

-- LOADS --
local function load_utils_menu()
  color_menu.background = {
    image = lib_love.graphics.newImage("assets/images/paused_800x600.png");
    width_factor = mod_screen.screen_width / 800;
    height_factor = mod_screen.screen_height / 600;
  }
  color_menu.white = {1, 1, 1}
  color_menu.orange = {1, 0.5, 0}
  color_menu.green = {0, 1, 0}

  font_menu.text = lib_love.graphics.newFont("assets/fonts/pixel.otf", 20)
  font_menu.title = lib_love.graphics.newFont("assets/fonts/pixel.otf", 50)
end

-- DRAWS --
local function draw_utils_menu()
  lib_love.graphics.draw(color_menu.background.image, 0, 0, 0, color_menu.background.width_factor, color_menu.background.height_factor)
  lib_love.graphics.setColor(color_menu.white)
end

-- UTILS --
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

-- Отрисовка с учетом наведения мыши (ораньжевое выделение)
local function draw_point_with_m_state(point)
  if point.m_state == 1 then
    lib_love.graphics.setColor(color_menu.orange)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color_menu.white)
  else
    lib_love.graphics.print(point.text, point.x, point.y)
  end
end

-- Отрисовка в случае, когда имеется уже выбранный пункт (зеленый)
local function draw_selected_with_m_state(point)
  if point.state == 1 then
    lib_love.graphics.setColor(color_menu.green)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color_menu.white)
  elseif point.m_state == 1 then
    lib_love.graphics.setColor(color_menu.orange)
    lib_love.graphics.print(point.text, point.x, point.y)
    lib_love.graphics.setColor(color_menu.white)
  else
    lib_love.graphics.print(point.text, point.x, point.y)
  end
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
  font_menu = font_menu;
  state_menu = state_menu;
}