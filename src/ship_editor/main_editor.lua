-- main_editor.lua

-- LIBS --
local lib_love = require("love")

local work_zone = {}
local store_zone = {}
local images = {}

local function init_fields_zone(point)
  point.fields = {}
  for i = 0, point.size_fields_w - 1 do
    point.fields[i] = {}
    for j = 0, point.size_fields_h - 1 do
      point.fields[i][j] = {}
      point.fields[i][j].image = point.field_empty_image
      point.fields[i][j].x = point.on_screen_x + i * point.width_field
      point.fields[i][j].y = point.on_screen_y + j * point.height_field
      point.fields[i][j].m_state = false
      point.fields[i][j].fill = nil
    end
  end
end

local function load_ship_editor(work_zone_xy, store_zone_xy)
  images.empty_field = lib_love.graphics.newImage("assets/images/space_editor/0_empty_field.png")
  images.empty_field_selected = lib_love.graphics.newImage("assets/images/space_editor/0_empty_field_selected.png")

  work_zone.size_fields_w = 10
  work_zone.size_fields_h = 10
  work_zone.zoom = 1.5
  work_zone.width_field = 32 * work_zone.zoom
  work_zone.height_field = 32 * work_zone.zoom
  work_zone.on_screen_x = work_zone_xy.x
  work_zone.on_screen_y = work_zone_xy.y
  work_zone.field_empty_image = images.empty_field
  work_zone.field_empty_image_selected = images.empty_field_selected

  store_zone.size_fields_w = 5
  store_zone.size_fields_h = 10
  store_zone.zoom = 1.5
  store_zone.width_field = 32 * store_zone.zoom
  store_zone.height_field = 32 * store_zone.zoom
  store_zone.on_screen_x = store_zone_xy.x
  store_zone.on_screen_y = store_zone_xy.y
  store_zone.field_empty_image = images.empty_field
  store_zone.field_empty_image_selected = images.empty_field_selected

  init_fields_zone(work_zone)
  init_fields_zone(store_zone)
end

-- UPDATES --
local function cycle_fields_zone(point, callback)
  for i = 0, point.size_fields_w - 1 do
    for j = 0, point.size_fields_h - 1 do
      callback(point, i, j)
    end
  end
end

local function check_m_state_fields_zone(point, i, j)
  local mouse_x, mouse_y = lib_love.mouse.getPosition()
  if mouse_x >= point.fields[i][j].x and mouse_x <= point.fields[i][j].x + point.width_field 
  and mouse_y >= point.fields[i][j].y and mouse_y <= point.fields[i][j].y + point.height_field then
    point.fields[i][j].m_state = true
  else
    point.fields[i][j].m_state = false
  end
end

local function change_image_m_state_fields_zone(point, i, j)
  if not point.fields[i][j].fill then
    if point.fields[i][j].m_state and not point.fields[i][j].fill then
      point.fields[i][j].image = point.field_empty_image_selected
    else
      point.fields[i][j].image = point.field_empty_image
    end
  end
end

-- UPDATES --
local function update_image_work_zone()
  cycle_fields_zone(work_zone, check_m_state_fields_zone)
  cycle_fields_zone(work_zone, change_image_m_state_fields_zone)
end

-- UPDATES --
local function update_image_store_zone()
  cycle_fields_zone(store_zone, check_m_state_fields_zone)
  cycle_fields_zone(store_zone, change_image_m_state_fields_zone)
end

local function update_ship_editor()
  update_image_work_zone()
  update_image_store_zone()
end

-- DRAWS --
local function draw_field(point, i, j)
  lib_love.graphics.draw(point.fields[i][j].image, point.fields[i][j].x, point.fields[i][j].y, 0, point.zoom, point.zoom)
end

local function draw_ship_editor()
  cycle_fields_zone(work_zone, draw_field)
  cycle_fields_zone(store_zone, draw_field)
end

return {
  load_ship_editor = load_ship_editor;
  update_ship_editor = update_ship_editor;
  draw_ship_editor = draw_ship_editor;
}


