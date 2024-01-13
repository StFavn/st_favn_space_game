-- utils_main.lua

-- LIBS --
local lib_love = require("love")

-- STATE VARIABLES --
local state_manual = "manual_ship"
-- manual_ship
-- manual_player

local state_pause = false
-- true
-- false

local zoom_ship = 0.25
local zoom_player = 1/zoom_ship

-- SCREEN VARIABLES --
local screen_width = 1280
local screen_height = 720

local function load_screen()
    lib_love.window.setMode(screen_width, screen_height)
    lib_love.window.setTitle("St_favn space_ship")
end

return {
  state_manual = state_manual;
  state_pause = state_pause;

  zoom_ship = zoom_ship;
  zoom_player = zoom_player;

  screen_width = screen_width;
  screen_height = screen_height;

  load_screen = load_screen;
}

