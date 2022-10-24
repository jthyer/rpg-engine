------------------------------------------------------------------------
-- MAPS
--   Contains all the code to draw the dungeon map. MAPDATA contains
--   all the walls, tiles, messages, and the locations of events.
--   This file tracks map state, including hero, event status (visible, 
--   hidden, erased), flags, the current message, and fog of war.
--   MAPDATA knows the the location of events, and checks when they 
--   overlap the hero when they do, it calls the eventLoad function 
--   to enter the event scene and run the event.
--
------------------------------------------------------------------------

local ROOMWIDTH = 20
local ROOMHEIGHT = 20

local MAPDATA = require("mapData")
local fogOfWar = {} 
local flags = {}
local eventStatus = {}
local message = ""

function loadMap()
  -- initialize fog of war
  for i = 1, ROOMHEIGHT do
    local row = {}
    for j = 1, ROOMWIDTH do
      table.insert(row, 1)
    end
    table.insert(fogOfWar,row)
  end
  
  -- initialize fog of war
  for i = 1, 20 do
    table.insert(flags,false)
  end
  
  -- initialize event status
  for i,v in ipairs(MAPDATA.eventStatus[level]) do
    eventStatus[v[1]] = v[2]
  end
  
  updateMap()
end

function moveHero(key)
  if KEYTABLE[key] == nil then
    return
  end  
  
  -- move hero if no walls in the way
  local move_x = hero.x + KEYTABLE[key][1]
  local move_y = hero.y + KEYTABLE[key][2]
  
  if move_x > 0 and move_x <= ROOMWIDTH and
    move_y > 0 and move_y <= ROOMHEIGHT then
    if MAPDATA.levelTable[level][move_y][move_x] ~= 1 then
      hero.x = move_x
      hero.y = move_y
    end
  end
  
  updateMap()
end

function updateMap()
  -- check if hero overlaps event
  local eventID
  local checkEvents = function (i,v)
    if hero.x == v[2] and hero.y == v[3] and 
        (eventStatus[v[1]] == 0 or eventStatus[v[1]] == 1) then
      eventID = v[1]
    end
  end

  iterateTable(MAPDATA.eventLocTable[level],checkEvents)  

  if eventID ~= nil then
    eventLoad(eventID) -- function in event.lua
  end
    
  -- update message
  local code = MAPDATA.levelTable[level][hero.y][hero.x]
  message = MAPDATA.msgTable[level][code]
  
  --update fog of war
  for i = -1, 1 do
    for j = -1, 1 do
      local x,y = hero.x+j,hero.y+i
      if x >= 1 and x <= ROOMWIDTH and 
        y >= 1 and y <= ROOMHEIGHT then
        fogOfWar[y][x] = 0
      end
    end
  end
end


function drawMap()
  -- draw pink border and black background
  setColor("pink")
  love.graphics.rectangle("fill",-5,-5,(ROOMWIDTH*10)+10,(ROOMHEIGHT*10)+10)
  setColor("black")
  love.graphics.rectangle("fill",0,0,(ROOMWIDTH*10),(ROOMHEIGHT*10))  

  -- draw objects
  local drawObject = function(i,v)
    local x = (v[2]-1) * 10
    local y = (v[3]-1) * 10
    if v[1] == "doorV" then
      love.graphics.line(x+4,y,x+4,y+10)
      love.graphics.line(x+6,y,x+6,y+10)
    end
    if v[1] == "doorH" then
      love.graphics.line(x,y+4,x+10,y+4)
      love.graphics.line(x,y+6,x+10,y+6)
    end
  end
  
  setColor("pink")
  iterateTable(MAPDATA.objTable[level],drawObject)
  
  -- draw events
  local drawEvent = function (i,v)
    if eventStatus[v[1]] == 1 then
      love.graphics.rectangle("fill", (v[2] - 1) * 10+3, (v[3] - 1) * 10 + 3, 4, 4)
    end
  end
  
  setColor("pink")    
  iterateTable(MAPDATA.eventLocTable[level], drawEvent)

  -- draw walls, fog of war, hero
  local drawRect = function (x,y,w)
    if w == 1 then
      love.graphics.rectangle("fill", (x - 1) * 10, (y - 1) * 10, 10, 10)
    end
  end
  
  setColor("white")
  iterate2DTable(MAPDATA.levelTable[level],drawRect)
  setColor("grey")
  iterate2DTable(fogOfWar,drawRect)
  setColor("yellow")
  drawRect(hero.x,hero.y,1)
  
  -- draw room message
  setColor("white")
  love.graphics.printf(message,-50,ROOMHEIGHT*10+8,300,"center")
end

-- Event functions referenced by event.lua
function getFlag(s)
  return flags[s]
end
  
function setFlag(s,b)
  flags[s] = b
end

function eraseEvent(eventID,s) 
  eventStatus[eventID] = -1
end