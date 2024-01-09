-- utils_main.lua

-- LIBS --
local lib_love = require("love")

-- STATE VARIABLES --
local play_state = "manual_ship"
-- manual_ship
-- manual_player

local pause_state = false
-- true
-- false

local ship_zoom = 0.25
local player_zoom = 1/ship_zoom

-- SCREEN VARIABLES --
local screen_width = 1280
local screen_height = 720

local function load_screen()
    lib_love.window.setMode(screen_width, screen_height)
    lib_love.window.setTitle("St_favn space_ship")
end

return {
  play_state = play_state;
  pause_state = pause_state;

  player_zoom = player_zoom;
  ship_zoom = ship_zoom;

  screen_width = screen_width;
  screen_height = screen_height;
  load_screen = load_screen;
}

