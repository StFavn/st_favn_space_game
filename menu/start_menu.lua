-- start_menu.lua

-- LIBS --
local lib_love = require("love")
local mod_state = require("state")

-- MODS_MENU --
local mod_utils = require("/menu/utils_menu")

-- VARIABLES --
local start_menu = {}

-- CALLBACKS --
local function callback_continue()
  mod_state.state_pause = false
end

local function callback_create()
  mod_utils.state_menu = "create_menu"
end

local function callback_settings()
  mod_utils.state_menu = "settings_menu"
end

local function callback_exit()
  lib_love.event.quit()
end

-- LOADS --
local function load_start_menu()
  start_menu.title =    {text = "Пауза",      x = 100, y = 50,  w = 200, h = 50}
  start_menu.continue = {text = "Продолжить", x = 100, y = 150, w = 200, h = 25, m_state = 0, callback = callback_continue}
  start_menu.create =   {text = "Редактор",   x = 100, y = 200, w = 200, h = 25, m_state = 0, callback = callback_create}
  start_menu.settings = {text = "Настройки",  x = 100, y = 250, w = 200, h = 25, m_state = 0, callback = callback_settings}
  start_menu.exit =     {text = "Выход",      x = 100, y = 300, w = 200, h = 25, m_state = 0, callback = callback_exit}
end

-- UPDATES --
local function update_start_menu()
  start_menu.continue.m_state = mod_utils.check_m_state(start_menu.continue)
  start_menu.create.m_state = mod_utils.check_m_state(start_menu.create)
  start_menu.settings.m_state = mod_utils.check_m_state(start_menu.settings)
  start_menu.exit.m_state = mod_utils.check_m_state(start_menu.exit)
end

local function check_click_start_menu()
  mod_utils.check_click(start_menu.continue)
  mod_utils.check_click(start_menu.create)
  mod_utils.check_click(start_menu.settings)
  mod_utils.check_click(start_menu.exit)
end

-- DRAWS --
local function draw_start_menu()
  lib_love.graphics.setFont(mod_utils.font_menu.title)
  lib_love.graphics.print(start_menu.title.text, start_menu.title.x, start_menu.title.y)
  lib_love.graphics.setFont(mod_utils.font_menu.text)
  mod_utils.draw_point_with_m_state(start_menu.continue)
  mod_utils.draw_point_with_m_state(start_menu.create)
  mod_utils.draw_point_with_m_state(start_menu.settings)
  mod_utils.draw_point_with_m_state(start_menu.exit)
end

return {
  load_start_menu = load_start_menu;
  update_start_menu = update_start_menu;
  draw_start_menu = draw_start_menu;

  check_click_start_menu = check_click_start_menu
}