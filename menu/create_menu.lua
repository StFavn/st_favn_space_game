-- create_menu.lua

-- LIBS --
local lib_love = require("love")

-- MODS --
local mod_utils = require("/menu/utils_menu")
local mod_ship_editor = require("/ship_editor/main_editor")

-- VARIABLES --
local create_menu = {}

-- CALLBACKS --
local function callback_back()
  mod_utils.state_menu = "start_menu"
end

local function callback_save()
  return
end

-- LOADS --
local function load_create_menu()
  create_menu.work_zone = {x = 300, y = 150}
  create_menu.store_zone = {x = 800, y = 150}
  mod_ship_editor.load_ship_editor(create_menu.work_zone, create_menu.store_zone)

  create_menu.title = {text = "Создание",  x = 100, y = 50,  w = 200, h = 50}
  create_menu.save =  {text = "Сохранить", x = 100, y = 150, w = 200, h = 25, m_state = 0, callback = callback_save}
  create_menu.back =  {text = "Назад",     x = 100, y = 200, w = 200, h = 25, m_state = 0, callback = callback_back}
end

-- UPDATES --
local function check_click_create_menu()
  mod_utils.check_click(create_menu.save)
  mod_utils.check_click(create_menu.back)
end

local function update_create_menu()
  create_menu.save.m_state = mod_utils.check_m_state(create_menu.save)
  create_menu.back.m_state = mod_utils.check_m_state(create_menu.back)

  mod_ship_editor.update_ship_editor()
end

-- DRAWS --
local function draw_side_menu()
  lib_love.graphics.setFont(mod_utils.font_menu.title)
  lib_love.graphics.print(create_menu.title.text, create_menu.title.x, create_menu.title.y)
  lib_love.graphics.setFont(mod_utils.font_menu.text)
  mod_utils.draw_point_with_m_state(create_menu.save)
  mod_utils.draw_point_with_m_state(create_menu.back)
end

local function draw_create_menu()
  draw_side_menu()
  mod_ship_editor.draw_ship_editor()
end

return {
  load_create_menu = load_create_menu;
  update_create_menu = update_create_menu;
  draw_create_menu = draw_create_menu;
  
  check_click_create_menu = check_click_create_menu;
}