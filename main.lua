-- main.lua

-- LIBS --
local lib_love = require("love")
local mod_camera = require("libs/camera")

-- MY MODS --
local mod_utils_main = require("src/utils_main")
local mod_player_ship = require("src/player_ship")
local mod_player = require("src/player")
local mod_view_params = require("src/view_params")
local mod_background = require("src/background")
local mod_main_menu = require("src/menu/main_menu")

-- VARIABLES --
local cam = mod_camera()

-- LOADS --
function lib_love.load()
  mod_player_ship.load_player_ship()
  mod_player.load_player()
  mod_utils_main.load_screen()
  mod_main_menu.load_main_menu()
end

-- UPDATES --
function lib_love.update(dt)
  if mod_utils_main.pause_state then
    mod_main_menu.update_main_menu()
    return
  end

  mod_player_ship.update_player_ship(dt)
  mod_player.update_player(dt)
  mod_view_params.update_params()

  if mod_utils_main.play_state == "manual_ship" then
    mod_player_ship.handle_input_ship(dt)
    cam:lookAt(mod_player_ship.ship.x, mod_player_ship.ship.y)
  end

  if mod_utils_main.play_state == "manual_player" then
    mod_player.handle_input_player(dt)
    cam:lookAt(mod_player.player.x, mod_player.player.y)
  end
end

-- KEY PRESSED --
function lib_love.keypressed(key)
  if key == "escape" then
    if mod_utils_main.pause_state then
      mod_main_menu.callback_menu_deactivate()
    else
      mod_main_menu.callback_menu_activate()
    end

  elseif key == "e" then
    if mod_utils_main.play_state == "manual_ship" then
      mod_utils_main.play_state = "manual_player"
      cam:zoom(mod_utils_main.player_zoom)
      cam:rotate(-mod_player_ship.ship.angle)
    elseif mod_utils_main.play_state == "manual_player" then
      mod_utils_main.play_state = "manual_ship"
      cam:zoom(mod_utils_main.ship_zoom)
      cam:rotate(mod_player_ship.ship.angle)
    end
  end
end

-- MOUSE PRESSED --
function lib_love.mousepressed(x, y, button)
  if button == 1 then
    if mod_utils_main.pause_state then
      mod_main_menu.mousepressed_left_pause()
    end
  end
end

-- DRAW --
function lib_love.draw()
  cam:attach()
    mod_background.draw_bacground()
    if mod_utils_main.play_state == "manual_ship" then
      mod_player_ship.draw_player_ship_state_ship()
    end
    if mod_utils_main.play_state == "manual_player" then
      mod_player_ship.draw_player_ship_state_player()
      mod_player.draw_player()
    end
  cam:detach()

  mod_view_params.draw_params()

  if mod_utils_main.pause_state then
    mod_main_menu.draw_main_menu()
  end
  lib_love.graphics.print("FPS: " .. lib_love.timer.getFPS(), 300, 10)
end
