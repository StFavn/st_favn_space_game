-- elements_editor.lua

-- LIBS --
local lib_love = require("love")

local Element = {}
local Class_element = {}

Element.__index = Element
Element.Type = "Element"

function Element:new(Class_element, image)
  self = setmetatable({}, self)
  self.Class_element = Class_element
  self.image = image
  return self
end

function Element:draw(x, y, w, h, zoom, angle)
  lib_love.graphics.push()
  lib_love.graphics.translate(x + w / 2, y + h / 2)
  lib_love.graphics.rotate(angle)
  lib_love.graphics.translate(-w / 2, -h / 2)
  lib_love.graphics.draw(self.image, 0, 0, 0, zoom, zoom)
  lib_love.graphics.pop()
end