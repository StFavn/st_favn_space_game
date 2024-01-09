-- player_ship.lua
local lib_love = require("love")
local lib_anim8 = require("libs/anim8")
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

  ship.speed_x = 0             -- Начальная скорость по оси X
  ship.speed_y = 0             -- Начальная скорость по оси Y

  ship.angle = -1/2 * math.pi  -- Начальное положение угла
  ship.trust = false           -- Состояние двигателя

  ship.speed = 0               -- Объявляю переменную для скорости
  ship.accel = 100             -- Мощность ускорителей
  ship.turn_speed = math.pi    -- Скорость изменения поворота

  -- в разработке. временное решение. Здесь игрок должен появляться, когда происходит смена режима. 
  -- И здесь игрок должен находиться, чтобы сменить режим.
  ship.manual_zone = {
    center_x = ship.x + ship.width / 2,
    center_y = ship.y + ship.height / 2,
    angle = ship.angle
  }
end

-- MANUAL OPERATIONS --
local function manual_aseleration(dt)      -- Нажатие клавиши W
  ship.trust = true
  ship.speed_x = ship.speed_x + math.cos(ship.angle) * ship.accel * dt
  ship.speed_y = ship.speed_y + math.sin(ship.angle) * ship.accel * dt
end

local function manual_turn_left(dt)        -- Нажатие клавиши A
  ship.angle = ship.angle - ship.turn_speed * dt
end

local function manual_turn_right(dt)       -- Нажатие клавиши D
  ship.angle = ship.angle + ship.turn_speed * dt
end

local function handle_input_ship(dt)
  if lib_love.keyboard.isDown("w") then
    manual_aseleration(dt)
  else
    ship.trust = false
  end

  if lib_love.keyboard.isDown("a") then
    manual_turn_left(dt)
  end

  if lib_love.keyboard.isDown("d") then
    manual_turn_right(dt)
  end
end

-- UPDATES --
local function update_params_player_ship(dt)
  ship.x = ship.x + ship.speed_x * dt
  ship.y = ship.y + ship.speed_y * dt
  ship.speed = math.sqrt(ship.speed_x^2 + ship.speed_y^2)
end

local function update_player_ship_animation(dt)
  if ship.trust then
    ship.trust_animation:update(dt)
  end
end

local function update_player_ship(dt)
  update_params_player_ship(dt)
  update_player_ship_animation(dt)
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
  handle_input_ship = handle_input_ship;
  draw_player_ship_state_ship = draw_player_ship_state_ship;
  draw_player_ship_state_player = draw_player_ship_state_player;

  manual_aseleration = manual_aseleration;
  manual_turn_left = manual_turn_left;
  manual_turn_right = manual_turn_right;
}