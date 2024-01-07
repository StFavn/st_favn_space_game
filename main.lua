-- main.lua

-- LIBS --
local lib_love = require("love")
local mod_camera = require("libs/camera")

-- MY MODS --
local mod_player_ship = require("player_ship")
local mod_player = require("player")
local mod_screen = require("screen")
local mod_view_params = require("view_params")
local mod_handle_input = require("handle_input")
local mod_background = require("background")
local mod_state = require("state")

-- VARIABLES --
local cam = mod_camera()
local params = {
  ship_x = nil,
  ship_y = nil,
  ship_speed = nil
}

-- LOADS --
function lib_love.load()
  mod_player_ship.load_player_ship()
  mod_player.load_player()
  mod_screen.load_screen()
end

-- UPDATES --
local function update_player_ship_view_params()
  params = {
    -- Смещаю центр координат на центр отображаемой карты и превожу координаты корабля в соответствие с этим
    ship_x = mod_player_ship.ship.x - mod_background.map_x_center,
    ship_y = mod_player_ship.ship.y - mod_background.map_y_center,
    ship_speed = mod_player_ship.ship.speed
  }
end

function lib_love.update(dt)
  update_player_ship_view_params()
  mod_handle_input.handle_input(dt)
  mod_player_ship.update_player_ship(dt)
  mod_player.update_player(dt)
  if mod_player_ship.ship.trust then
    mod_player_ship.update_player_ship_animation(dt)
  end

  if mod_state.state == "ship" then
    cam:lookAt(mod_player_ship.ship.x, mod_player_ship.ship.y)
  end
  if mod_state.state == "player" then
    cam:lookAt(mod_player.player.x, mod_player.player.y)
  end
end

-- KEY PRESSED --
function lib_love.keypressed(key)
  if key == "e" then
    if mod_state.state == "ship" then
      -- cam:rotate(mod_player_ship.ship.angle)
      mod_state.state = "player"
      cam:zoom(4.0)
      cam:rotate(-mod_player_ship.ship.angle)
    elseif mod_state.state == "player" then
      mod_state.state = "ship"
      cam:zoom(0.25)
      cam:rotate(mod_player_ship.ship.angle)
    end
  end
end

-- DRAW --
function lib_love.draw()
    cam:attach()
      mod_background.draw_bacground()
      if mod_state.state == "ship" then
        mod_player_ship.draw_player_ship_state_ship()
      end
      if mod_state.state == "player" then
        mod_player_ship.draw_player_ship_state_player()
        mod_player.draw_player()
      end
    cam:detach()
    mod_view_params.view_params(params)
end
