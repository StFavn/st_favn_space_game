-- handle_input

-- LIBS --
local lib_love = require("love")

-- MODS --
local mod_player_ship = require("player_ship")

-- FUNCTIONS --
local function handle_input(dt)
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

return {
  handle_input = handle_input
}