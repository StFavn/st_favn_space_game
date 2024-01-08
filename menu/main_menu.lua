-- pause.lua

-- LIBS --
local lib_love   = require("love")

-- MODS_MENU --
local mod_start_menu = require("/menu/start_menu")
local mod_settings_menu = require("/menu/setting_menu")
local mod_utils = require("/menu/utils_menu")
--local mod_create_ship = require("create_ship_menu")

-- LOADS --
local function load_main_menu()
  mod_utils.load_utils_menu()
  mod_start_menu.load_start_menu()
  mod_settings_menu.load_settings_menu()
end

-- UPDATES --
local function mousepressed_left_pause()
  if mod_utils.state_menu == "start_menu" then
    mod_start_menu.check_click_start_menu()
  elseif mod_utils.state_menu == "settings_menu" then
    mod_settings_menu.check_click_settings_menu()
  end
end

local function update_main_menu()
  if mod_utils.state_menu == "start_menu" then
    mod_start_menu.update_start_menu()
  elseif mod_utils.state_menu == "settings_menu" then
    mod_settings_menu.update_settings_menu()
  end
end

-- DRAWS --
local function draw_main_menu()
  mod_utils.draw_utils_menu()
  if mod_utils.state_menu == "start_menu" then
    mod_start_menu.draw_start_menu()
  elseif mod_utils.state_menu == "settings_menu" then
    mod_settings_menu.draw_settings_menu()
  end
end

return {
  -- FUNCTIONS --
  load_main_menu = load_main_menu;
  update_main_menu = update_main_menu;
  draw_main_menu = draw_main_menu;
  mousepressed_left_pause = mousepressed_left_pause;

  callback_menu_activate = mod_utils.callback_menu_activate;
  callback_menu_deactivate = mod_utils.callback_menu_deactivate;
}