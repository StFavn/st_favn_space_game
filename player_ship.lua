-- player_ship.lua
package.path = package.path .. ";/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua"
local lib_love = require("love")
local lib_anim8 = require("anim8")
local mod_screen = require("screen")

-- SHIP VARIABLES --
local ship = {}

local ship_image = lib_love.graphics.newImage("/assets/images/ship_imagine_4_42x63.png")
local ship_trust_spriteSheet = lib_love.graphics.newImage("/assets/images/ship_trust_split_4_42x63.png")
local ship_trust_grid = lib_anim8.newGrid(63, 42, ship_trust_spriteSheet:getWidth(), ship_trust_spriteSheet:getHeight())
local ship_trust_animation = lib_anim8.newAnimation(ship_trust_grid('1-6', 1), 0.05)

-- LOADS --
local function load_player_ship()
  ship.width = ship_image:getWidth()
  ship.height = ship_image:getHeight()

  ship.x = mod_screen.screen_width / 2
  ship.y = mod_screen.screen_height / 2

  ship.vx = 0
  ship.vy = 0

  ship.angle = -1/2 * math.pi
  ship.trust = false

  ship.speed = 0
  ship.accel = 100
  ship.turn_speed = math.pi
end

-- UPDATES --
local function update_player_ship(dt)
  ship.x = ship.x + ship.vx * dt
  ship.y = ship.y + ship.vy * dt
  ship.speed = math.sqrt(ship.vx^2 + ship.vy^2)
end

local function update_player_ship_animation(dt)
  ship_trust_animation:update(dt)
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
local function draw_player_ship()
  lib_love.graphics.push()
  lib_love.graphics.translate(ship.x + ship.width / 2, ship.y + ship.height / 2)
  lib_love.graphics.rotate(ship.angle)
  lib_love.graphics.translate(-ship.width / 2, -ship.height / 2)

  if ship.trust then
    ship_trust_animation:draw(ship_trust_spriteSheet, 0, 0)
  else
    lib_love.graphics.draw(ship_image, 0, 0)
  end

  lib_love.graphics.pop()
end

-- RETURN --  
return {
  ship = ship;

  manual_aseleration = manual_aseleration;
  manual_turn_left = manual_turn_left;
  manual_turn_right = manual_turn_right;

  load_player_ship= load_player_ship;
  update_player_ship = update_player_ship;
  update_player_ship_animation = update_player_ship_animation;
  draw_player_ship = draw_player_ship;
}