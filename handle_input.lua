-- handle_input

-- LIBS --
local lib_love = require("love")

-- MODS --
local mod_player_ship = require("player_ship")
local mod_player = require("player")
local mod_state = require("state")

-- FUNCTIONS --
local function handle_input_ship(dt)
  if lib_love.keyboard.isDown("w") then
    mod_player_ship.manual_aseleration(dt)
  else
    mod_player_ship.ship.trust = false
  end

  if lib_love.keyboard.isDown("a") then
    mod_player_ship.manual_turn_left(dt)
  end

  if lib_love.keyboard.isDown("d") then
    mod_player_ship.manual_turn_right(dt)
  end
end

local function handle_input_player(dt)
  if lib_love.keyboard.isDown("w") then
    mod_player.move_up(dt)
  end

  if lib_love.keyboard.isDown("s") then
    mod_player.move_down(dt)
  end

  if lib_love.keyboard.isDown("a") then
    mod_player.move_left(dt)
  end

  if lib_love.keyboard.isDown("d") then
    mod_player.move_right(dt)
  end
end

local function handle_input(dt)
  if mod_state.state == "ship" then
    handle_input_ship(dt)
  end
  if mod_state.state == "player" then
    handle_input_player(dt)
  end
end

return {
  handle_input = handle_input
}