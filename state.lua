-- state.lua

-- LIBS --
local lib_love = require("love")

-- VARIABLES --
local state = "ship"
-- ship
-- player
-- paused_menu

local save_state = "ship"
-- ship
-- player

local ship_zoom = 0.25
local player_zoom = 1/ship_zoom

return {
  state = state;
  save_state = save_state;
  player_zoom = player_zoom;
  ship_zoom = ship_zoom
}