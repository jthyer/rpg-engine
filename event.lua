---------------------------------------------------------
-- EVENTS
--   Event code is as separate from map code as possible.
--   An event doesn't care about its location, hence why
--   event x and y is defined in MAPDATA instead of 
--   EVENTDATA. An event calls a text/choice box, pushes 
--   the hero, plays a sound, flashes the screen. Event
--   scenes are wholly separate from map scenes. The only 
--   outside variables events call are part of the hero 
--   object defined in main.lua.
---------------------------------------------------------  

local EVENTDATA = require("EVENTDATA")

local textBox = {}
  textBox.choiceStatus = 0
  textBox.choice1 = ""
  textBox.choice2 = ""
  textBox.text = ""
  textBox.WIDTH = 250
  textBox.HEIGHT = 75
  textBox.X = (300 - textBox.WIDTH) / 2
  textBox.Y = textBox.X + 10
  textBox.BORDER = 2

local eventID = 0
local subeventID = 0
local eventLog
local flash = 0

---------------------------------------------------------
-- EVENT EXECUTION
--   Some events happen instantly on overlap, others 
--   iterate over Z presses like text boxes. The event
--   step function runs recursively to allow for 
--   branching based on flag values or choices.
---------------------------------------------------------  
function eventLoad(ID) -- called by map.lua when hero overlaps an events x y
  eventID = ID
  subeventID = 0
  flash = 0
  scene = "event"
  eventLog = EVENTDATA[level][ID] -- defined in EVENTDATA.lua
  eventStep()
end

function eventStep()
  if subeventID < #eventLog then
    subeventID = subeventID + 1
    if eventLog[subeventID][1] == "textBox" then
      textBox.text = eventLog[subeventID][2]
    elseif eventLog[subeventID][1] == "flagSet" then  
      setFlag("snakeRepellant", true) -- defined in map.lua
      eventStep()
    elseif eventLog[subeventID][1] == "flagBranch" then          
      if getFlag(eventLog[subeventID][2]) then
        eventLog = eventLog[subeventID][3]
      else
        eventLog = eventLog[subeventID][4]
      end
      subeventID = 0
      eventStep()
    elseif eventLog[subeventID][1] == "choiceBranch" then
      if textBox.choiceStatus == 0 then
        textBox.text = eventLog[subeventID][2]
        textBox.choice1 = eventLog[subeventID][3]
        textBox.choice2 = eventLog[subeventID][4]
        textBox.choiceStatus = 1
        subeventID = subeventID - 1
      else
        eventLog = eventLog[subeventID][textBox.choiceStatus + 4]
        subeventID = 0
        textBox.choiceStatus = 0
        eventStep()
      end
    elseif eventLog[subeventID][1] == "flash" then
      flash = 5
      eventStep()
    elseif eventLog[subeventID][1] == "push" then
      hero.x = hero.x + eventLog[subeventID][2]
      hero.y = hero.y + eventLog[subeventID][3]
      eventStep()
    elseif eventLog[subeventID][1] == "erase" then
      eraseEvent(eventID) -- function in map.lua
      eventStep()
    end
  else
    eventLog = nil
    scene = "map"
  end
end

function eventKeyPressed(key) -- referenced by main.lua
  if textBox.choiceStatus > 0 then
    if key == "up" then 
      textBox.choiceStatus = 1
    elseif key == "down" then
      textBox.choiceStatus = 2
    elseif key == "z" then
      eventStep()
    end
    return
  elseif key == "z" then 
    eventStep()
  end
end

---------------------------------------------------------
-- DRAW EVENT EXECUTION
--   Text boxes, choices, screen flashes
---------------------------------------------------------
function drawTextBox(text, x, y, w, h, b)  
  setColor("black")
  love.graphics.rectangle("fill",x-b-1,y-b-1,w+(b*2)+2,h+(b*2)+2)
  setColor("white")
  love.graphics.rectangle("fill",x-b,y-b,w+(b*2),h+(b*2))
  setColor("black")
  love.graphics.rectangle("fill",x,y,w,h)
  setColor("white")
  love.graphics.printf(text,x+10,y+10,w-20,"left")
end

function drawEvent()
  local y_offset 
  if hero.y > 10 then 
    y_offset = 0
  else 
    y_offset = 180 - textBox.HEIGHT
  end

  if flash > 0 then
    setColor("red")
    love.graphics.rectangle("fill",0,0,600,500)
    setColor("white")
    flash = flash - 1
  end

  drawTextBox(textBox.text, textBox.X, textBox.Y + y_offset, 
    textBox.WIDTH, textBox.HEIGHT,textBox.BORDER)
  
  if textBox.choiceStatus > 0 then
    local choiceOffset = 0
    local w,h = 20, 20
    local c1, c2 = textBox.choice1, textBox.choice2 
    if textBox.choiceStatus == 1 then
      c1 = "<" .. textBox.choice1 .. ">"
      c2 = "  " .. textBox.choice2 .. " "
    else
      c1 = "  " .. textBox.choice1 .. " "
      c2 = "<" .. textBox.choice2 .. ">"
    end
    setColor("black")
    drawTextBox(c1 .. "\n" .. c2, 
        textBox.X, textBox.Y + y_offset - 60, 60, 50, 2)
  end
  
end