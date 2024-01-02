-- player.lua

-- LIBS --
local lib_love = require("love")
local mod_player_ship = require("player_ship")

-- VARIABLES --
local player = {}

-- LOADS --
local function load_player()
  player.image = lib_love.graphics.newImage("/assets/images/player_image_6x6.png")

  player.width = player.image:getWidth()
  player.height = player.image:getHeight()

  player.x = mod_player_ship.ship.manual_zone.center_x
  player.y = mod_player_ship.ship.manual_zone.center_y

  player.ship_vx = mod_player_ship.ship.vx
  player.ship_vy = mod_player_ship.ship.vy
  player.angle = mod_player_ship.ship.angle

  player.speed = 10
end

-- UPDATES --
local function update_player(dt)
  player.angle = mod_player_ship.ship.angle

  player.ship_vx = mod_player_ship.ship.vx
  player.ship_vy = mod_player_ship.ship.vy

  player.x = player.x + player.ship_vx * dt
  player.y = player.y + player.ship_vy * dt
end

-- MANUAL OPERATIONS --
local function move_up(dt)
  local dx = -math.sin(-mod_player_ship.ship.angle) * player.speed * dt
  local dy = -math.cos(-mod_player_ship.ship.angle) * player.speed * dt
  player.x = player.x + dx
  player.y = player.y + dy
end

local function move_down(dt)
  local dx = math.sin(-player.angle) * player.speed * dt
  local dy = math.cos(-player.angle) * player.speed * dt
  player.x = player.x + dx
  player.y = player.y + dy
end

local function move_left(dt)
  local dx = -math.cos(-player.angle) * player.speed * dt
  local dy = math.sin(-player.angle) * player.speed * dt
  player.x = player.x + dx
  player.y = player.y + dy
end

local function move_right(dt)
  local dx = math.cos(-player.angle) * player.speed * dt
  local dy = -math.sin(-player.angle) * player.speed * dt
  player.x = player.x + dx
  player.y = player.y + dy
end


-- DRAW --
local function draw_player()
  lib_love.graphics.push()
  lib_love.graphics.translate(player.x + player.width / 2, player.y + player.height / 2)
  lib_love.graphics.rotate(player.angle)
  lib_love.graphics.translate(-player.width / 2, -player.height / 2)
  lib_love.graphics.draw(player.image, 0, 0)
  lib_love.graphics.pop()
end

return {
  player = player;
  load_player = load_player;
  update_player = update_player;
  draw_player = draw_player;

  move_up = move_up;
  move_down = move_down;
  move_left = move_left;
  move_right = move_right;
}