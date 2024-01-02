-- player_ship.lua
package.path = package.path .. ";/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua"
local lib_love = require("love")
local lib_anim8 = require("anim8")
local mod_background = require("background")

-- SHIP VARIABLES --
local ship = {}

-- LOADS --
local function load_player_ship()
  ship.image_state_ship = lib_love.graphics.newImage("/assets/images/ship_image_state_ship_42x63.png")
  ship.image_state_player = lib_love.graphics.newImage("/assets/images/ship_image_state_player_42x63.png")

  ship.trust_spriteSheet = lib_love.graphics.newImage("/assets/images/ship_trust_split_4_42x63.png")
  ship.trust_grid = lib_anim8.newGrid(63, 42, ship.trust_spriteSheet:getWidth(), ship.trust_spriteSheet:getHeight())
  ship.trust_animation = lib_anim8.newAnimation(ship.trust_grid('1-6', 1), 0.05)

  ship.width = ship.image_state_ship:getWidth()
  ship.height = ship.image_state_ship:getHeight()

  ship.x = mod_background.map_x_center
  ship.y = mod_background.map_y_center

  ship.vx = 0
  ship.vy = 0

  ship.angle = -1/2 * math.pi
  ship.trust = false

  ship.speed = 0
  ship.accel = 100
  ship.turn_speed = math.pi

  -- в разработке. временное решение. Здесь игрок должен появляться, когда происходит смена режима. И здесь игрок должен находиться, чтобы сменить режим.
  ship.manual_zone = {
    center_x = ship.x + ship.width / 2,
    center_y = ship.y + ship.height / 2,
    angle = ship.angle
  }
end

-- UPDATES --
local function update_player_ship(dt)
  ship.x = ship.x + ship.vx * dt
  ship.y = ship.y + ship.vy * dt
  ship.speed = math.sqrt(ship.vx^2 + ship.vy^2)
end

local function update_player_ship_animation(dt)
  ship.trust_animation:update(dt)
end

-- MANUAL OPERATIONS --
local function manual_aseleration(dt)
  ship.trust = true
  ship.vx = ship.vx + math.cos(ship.angle) * ship.accel * dt
  ship.vy = ship.vy + math.sin(ship.angle) * ship.accel * dt
end

local function manual_turn_left(dt)
  ship.angle = ship.angle - ship.turn_speed * dt
end

local function manual_turn_right(dt)
  ship.angle = ship.angle + ship.turn_speed * dt
end

-- DRAWS --
local function draw_player_ship_state_ship()
  lib_love.graphics.push()
  lib_love.graphics.translate(ship.x + ship.width / 2, ship.y + ship.height / 2)
  lib_love.graphics.rotate(ship.angle)
  lib_love.graphics.translate(-ship.width / 2, -ship.height / 2)

  if ship.trust then
    ship.trust_animation:draw(ship.trust_spriteSheet, 0, 0)
  else
    lib_love.graphics.draw(ship.image_state_ship, 0, 0)
  end

  lib_love.graphics.pop()
end

local function draw_player_ship_state_player()
  lib_love.graphics.push()
  lib_love.graphics.translate(ship.x + ship.width / 2, ship.y + ship.height / 2)
  lib_love.graphics.rotate(ship.angle)
  lib_love.graphics.translate(-ship.width / 2, -ship.height / 2)
  lib_love.graphics.draw(ship.image_state_player, 0, 0)
  lib_love.graphics.pop()
end

-- RETURN --  
return {
  ship = ship;

  load_player_ship= load_player_ship;
  update_player_ship = update_player_ship;
  update_player_ship_animation = update_player_ship_animation;
  draw_player_ship_state_ship = draw_player_ship_state_ship;
  draw_player_ship_state_player = draw_player_ship_state_player;

  manual_aseleration = manual_aseleration;
  manual_turn_left = manual_turn_left;
  manual_turn_right = manual_turn_right;
}