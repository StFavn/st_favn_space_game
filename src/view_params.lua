-- view_params.lua

-- LiBS --
local lib_love = require("love")

-- MODS --
local mod_player_ship = require("src/player_ship")
local mod_background = require("src/background")

-- VARIABLES --
local view_coordinates = true
local view_speed = true

local color = {
  white_blue = {0.4, 1, 0.8}
}

local params = {
  ship_x = nil;
  ship_y = nil;
  ship_speed = nil;
}


local function draw_param_coordinates()
  lib_love.graphics.setColor(color.white_blue)
  lib_love.graphics.setFont(lib_love.graphics.newFont(20))
  local roundedX = math.floor(params.ship_x)
  local roundedY = math.floor(params.ship_y)
  lib_love.graphics.print("x = " .. roundedX, 10, 10)
  lib_love.graphics.print("y = " .. roundedY, 10, 30)
end

local function draw_param_speed()
  lib_love.graphics.setColor(color.white_blue)
  lib_love.graphics.setFont(lib_love.graphics.newFont(20))
  local roundedSpeed = math.floor(params.ship_speed)
  lib_love.graphics.print("speed = " .. roundedSpeed, 10, 60)
end

local function draw_params()
  if view_coordinates then
    draw_param_coordinates()
  end

  if view_speed then
    draw_param_speed()
  end
end

local function update_params()
    -- Смещаю центр координат на центр отображаемой карты и превожу координаты корабля в соответствие с этим
    params.ship_x = mod_player_ship.ship.x - mod_background.map_x_center
    params.ship_y = mod_player_ship.ship.y - mod_background.map_y_center
    params.ship_speed = mod_player_ship.ship.speed
end

return {
  update_params = update_params;
  draw_params = draw_params;
}