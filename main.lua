-- defines levelTable, objTable, eventTable, messages hero
-- everything that makes up the actual map is in "levels"
require("mapData")
require("event")
require("map")

-- next steps:
--  1) implement choices on the text box events 
--   done! 
--   Subtasks a) make responsive to hero position
--            b) show another text box after choice, push hero off event  
--  2) implement a simple inventory
--  3) pick up a key, add it to the inventory, open a locked door

-- efficiency changes to do:
--  * Code text box coordinates in load event, not every frame in draw

-- define globals and constants
level = 1
scene = "map"

KEYTABLE = {
  ["left"]  = {-1, 0},
  ["up"]    = { 0,-1},
  ["right"] = { 1, 0},
  ["down"]  = { 0, 1},
  ["Z"]     = { 0, 0}
}

COLORTABLE = {
  ["white"]  = { 1,1,1 },
  ["black"]  = { 0,0,0 },
  ["pink"]   = { 1,0,1 },
  ["yellow"] = { 1,1,0 },
  ["grey"] = {.8,.8,.8 }
}


function love.load()
  -- window settings
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.window.setTitle("Custom RPG Engine")

  -- set font
  font = love.graphics.newFont("cmd.ttf", 16)
  love.graphics.setFont(font)
  
  loadMap()
end

-- iterating tables used by map and event functions
function iterateTable(T, func)
  for i, v in ipairs(T) do
    func(i,v)
  end
end

function iterate2DTable(T, func)
  for i, v in ipairs(T) do
    for j, w in ipairs(T[i]) do
      func(j,i,w,v)
    end
  end
end


function love.update()  
  -- since this game is turn based, the state only needs
  -- to update on movement or when the game starts
end

function love.keypressed(key, scancode, isrepeat)
  if scene == "map" then
    moveHero(key)
  elseif scene == "textBox" then
    eventKeyPressed(key)
  end
end


function setColor(c)
  -- used by all draw events
  love.graphics.setColor(COLORTABLE[c][1],COLORTABLE[c][2],COLORTABLE[c][3])
end

function love.draw()
  -- set scale to x2
  love.graphics.push()
  love.graphics.scale(2, 2)
    
  -- translate to middle of screen
  -- always draw map, textBox and battle take place on top of map
  love.graphics.push()
  love.graphics.translate(50,25)
  
  drawMap()  
  
  love.graphics.pop()
  
  -- draw text box
  if scene == "textBox" then
    drawTextBoxEvent()
  end
  
  -- pop x2 scale
  love.graphics.pop()
end