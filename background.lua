-- background.lua

local lib_love = require("love")

local background_chunk = lib_love.graphics.newImage("/assets/images/background_4096x4096.png")
local background_width = background_chunk:getWidth()
local background_height = background_chunk:getHeight()
local map_i_max = 9
local map_j_max = 9
local map_i_center = math.floor(map_i_max / 2)
local map_j_center = math.floor(map_j_max / 2)
local map_x_center = map_i_center * background_width
local map_y_center = map_j_center * background_height

local function draw_bacground()
  lib_love.graphics.setColor(1, 1, 1)
  lib_love.graphics.setFont(lib_love.graphics.newFont(20))
  for i = 0, map_i_max do
    for j = 0, map_j_max do
      lib_love.graphics.draw(background_chunk, i * background_width, j * background_height)
      map_x_center = (i - map_i_center) * background_width
      map_y_center = (j - map_j_center) * background_height
      lib_love.graphics.print("(" .. i - map_i_center .. ", " .. j - map_j_center .. ")", i * background_width + 10, j * background_height + 10)
      lib_love.graphics.print("(" .. map_x_center .. ", " .. map_y_center .. ")", i * background_width + 10, j * background_height + 30)
    end
  end
end

return {
  map_x_center = map_x_center,
  map_y_center = map_y_center,
  draw_bacground = draw_bacground
}