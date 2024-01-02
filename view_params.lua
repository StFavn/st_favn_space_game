-- view_params.lua

-- LiBS --
local lib_love = require("love")

-- VARIABLES --
local view_coordinates = true
local view_speed = true

-- Не работает с цветом
local view_color = {
  r = 102,
  g = 255,
  b = 227
}

local function param_coordinates(ship_x, ship_y)
  lib_love.graphics.setColor(view_color.r, view_color.g, view_color.b)
  lib_love.graphics.setFont(lib_love.graphics.newFont(20))
  local roundedX = math.floor(ship_x)
  local roundedY = math.floor(ship_y)
  lib_love.graphics.print("x = " .. roundedX, 10, 10)
  lib_love.graphics.print("y = " .. roundedY, 10, 30)
end

local function param_speed(ship_speed)
  lib_love.graphics.setColor(view_color.r, view_color.g, view_color.b)
  lib_love.graphics.setFont(lib_love.graphics.newFont(20))
  local roundedSpeed = math.floor(ship_speed)
  lib_love.graphics.print("speed = " .. roundedSpeed, 10, 60)
end

local function view_params(params)
  if view_coordinates then
    param_coordinates(params.ship_x, params.ship_y)
  end

  if view_speed then
    param_speed(params.ship_speed)
  end
end

return {
  view_params = view_params
}