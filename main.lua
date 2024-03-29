require("src.util")
require("src.map")
require("src.battle")
require("src.event")
require("src.ui") 

-- define globals
level = 1
scene = "map"
hero = {
  x = 11 ,
  y = 2 ,
  level = 1 ,
  maxHealth = 20 ,
  health = 20 ,
  strength = 8 ,
  exp = 0 ,
  expDisplay = 0 ,
}

function love.load()
  -- window settings
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.graphics.setLineStyle("rough")
  love.window.setTitle("Custom RPG Engine")

  -- set font
  font = love.graphics.newFont("cmd.ttf", 16)
  love.graphics.setFont(font)
  
  -- load images
  spr_snake = love.graphics.newImage("assets/images/battlers/snake.png")
  
  loadMap()
end

function love.update()  
  -- since this game is turn based, the state only needs
  -- to update on movement or when the game starts
end

function love.keypressed(key, scancode, isrepeat)
  if scene == "map" then
    if key == "z" then
      restHero()
    else
      moveHero(key)
    end
  elseif scene == "event" then
    eventKeyPressed(key)
  end
end

function love.draw()
   -- set scale to x2
  love.graphics.push()
  love.graphics.scale(2, 2)
 
 -- background color
  local i = 0
  while (i < 225) do
    setColor("darkTeal")
    love.graphics.line(0,i,300,i)  
    setColor("black")
    love.graphics.line(0,i+1,300,i+1)
    i = i + 2
  end 
 
  -- translate to middle of screen
  if (not getBattleActive()) then
    love.graphics.push()
    love.graphics.translate(16,8+1)  
    drawMap()  
    love.graphics.pop()
  end
  
  -- draw UI
  love.graphics.push()
  love.graphics.translate(16+180+12,8+1)  
  drawUI()  
  love.graphics.pop()
  
  -- draw room message
  love.graphics.push()
  love.graphics.translate(16,180+20+1)  
  drawMessage()
  love.graphics.pop()
  
  -- draw event
  if scene == "event" then
    drawEvent()
  end
  
  -- pop x2 scale
  love.graphics.pop()
end