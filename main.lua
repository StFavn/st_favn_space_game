-- main.lua

-- UTILS --
local lib_love = require("love")
local mod_camera = require("libs/camera")

-- MY MODS --
local mod_player_ship = require("player_ship")
local mod_screen = require("screen")
local mod_view_params = require("view_params")
local mod_handle_input = require("handle_input")

-- VARIABLES --
local background = lib_love.graphics.newImage("/assets/images/background.png")
local cam_ship = mod_camera()
local cam_ship_flag = true
local params = {
  ship_x = 0,
  ship_y = 0,
  ship_speed = 0
}

-- LOADS --
function lib_love.load()
  mod_player_ship.load_player_ship()
  mod_screen.load_screen()
end

-- UPDATES --
local function update_player_ship_view_params()
  params = {
    ship_x = mod_player_ship.ship.x,
    ship_y = mod_player_ship.ship.y,
    ship_speed = mod_player_ship.ship.speed
  }
end

function lib_love.update(dt)
  update_player_ship_view_params()
  mod_handle_input.handle_input(dt)
  mod_player_ship.update_player_ship(dt)
  if mod_player_ship.ship.trust then
    mod_player_ship.update_player_ship_animation(dt)
  end

  if cam_ship_flag then
    cam_ship:lookAt(mod_player_ship.ship.x, mod_player_ship.ship.y)
  end
end

-- DRAW --
function lib_love.draw()
  if  cam_ship_flag then
    cam_ship:attach()
      lib_love.graphics.draw(background)
      mod_player_ship.draw_player_ship()
    cam_ship:detach()
    mod_view_params.view_params(params)
  end
end
