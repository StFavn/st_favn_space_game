-- state.lua

-- LIBS --
local lib_love = require("love")

-- VARIABLES --
local state = "ship"
-- ship
-- player

local state_pause = false
-- true
-- false

local ship_zoom = 0.25
local player_zoom = 1/ship_zoom

return {
  state = state;
  player_zoom = player_zoom;
  ship_zoom = ship_zoom
}