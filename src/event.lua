---------------------------------------------------------
-- EVENTS
--   Event code is as separate from map code as possible.
--   An event doesn't care about its location, hence why
--   event x and y is defined in MAPDATA instead of 
--   EVENTDATA. An event calls a text/choice box, pushes 
--   the hero, plays a sound, flashes the screen. Event
--   scenes are wholly separate from map scenes. The only 
--   outside variables events call are part of the hero 
--   object defined in main.lua, and flag manipulation in
--   map.lua.
---------------------------------------------------------  
local EVENTDATA = require("gamedata.eventdata")

local eventExec = {}
local textBox = {}
  textBox.choiceStatus = 0
  textBox.choice1 = ""
  textBox.choice2 = ""
  textBox.text = ""

local eventID = 0
local subEventID = 0
local eventLog = {}
local eventStack = {}
local flash = 0

---------------------------------------------------------
-- EVENT EXECUTION
--   Some events happen instantly on overlap, others 
--   iterate over Z presses like text boxes. The event
--   step function runs recursively to allow for 
--   branching based on flag values or choices.
--------------------------------------------------------- 
function eventLoad(ID) -- called by map.lua when hero overlaps an events x y
  scene = "event" 

  eventID = ID
  subEventID = 0
  flash = 0
  eventLog = deepcopy(EVENTDATA[level][ID]) -- defined in EVENTDATA.lua
  eventStack = {}
  eventStep()
end

eventExec["textBox"] = function(subEvent)
  textBox.text = eventLog[subEventID][2]
  return false
end

eventExec["flagSet"] = function(subEvent)
  setFlag(subEvent[2], true) -- defined in map.lua
  return true
end

eventExec["flagBranch"] = function(subEvent)
  table.insert(eventStack,{subEventID,eventLog})
  if getFlag(subEvent[2]) then
    eventLog = subEvent[3]
  else
    eventLog = subEvent[4]
  end
  subEventID = 0
  return true
end

eventExec["randomBranch"] = function(subEvent)
  table.insert(eventStack,{subEventID,eventLog})
  local randomCheck = math.random(subEvent[2])
  if randomCheck ~= 1 then
    eventLog = subEvent[3]
  else
    eventLog = subEvent[4]
  end
  subEventID = 0
  return true
end

eventExec["choiceBranch"] = function(subEvent)
  if textBox.choiceStatus == 0 then
    textBox.text = subEvent[2]
    textBox.choice1 = subEvent[3]
    textBox.choice2 = subEvent[4]
    textBox.choiceStatus = 1
    subEventID = subEventID - 1
    return false
  else
    table.insert(eventStack,{subEventID,eventLog})
    eventLog = subEvent[textBox.choiceStatus + 4]
    subEventID = 0
    textBox.choiceStatus = 0
    return true
  end
end

eventExec["callEvent"] = function(subEvent)
  eventLoad(subEvent[2])
  return true
end    

eventExec["healHero"] = function(subEvent)
  hero.health = hero.maxHealth
  return true
end

eventExec["flash"] = function(subEvent)
  flash = 5
  return true
end

eventExec["push"] = function(subEvent)
  hero.x = hero.x + subEvent[2]
  hero.y = hero.y + subEvent[3]
  return true
end

eventExec["erase"] = function(subEvent)
  eraseEvent(eventID) -- function in map.lua
  return true
end

eventExec["battleInit"] = function(subEvent)
  local battleEvent = battleInit(subEvent[2])
  for i = 1, #battleEvent do
    table.insert(eventLog,subEventID+i,battleEvent[i])
  end
  return true
end

eventExec["battle"] = function(subEvent)
  local battleEvent = battleExec[subEvent[2]]()
  for i = 1, #battleEvent do
    table.insert(eventLog,subEventID+i,battleEvent[i])
  end
  return true
end

function eventStep()
  if subEventID < #eventLog then
    subEventID = subEventID + 1
    local subEvent = eventLog[subEventID]
    local step = eventExec[subEvent[1]](subEvent) 
    if step then eventStep() end
  elseif #eventStack > 0 then
    subEventID = eventStack[#eventStack][1]
    eventLog = eventStack[#eventStack][2]
    table.remove(eventStack)
    eventStep()
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
function drawTextBox(text, x, y, w, h)  
  drawBorder(x, y, w, h)
  love.graphics.printf(text,x+10,y+10,w-20,"left")
end

function drawChoiceBox(status, choice1, choice2, y_offset)
  if status > 0 then
    if status == 1 then
      c1 = "<" .. choice1 .. ">"
      c2 = "  " .. choice2 .. " "
    else
      c1 = "  " .. choice1 .. " "
      c2 = "<" .. choice2 .. ">"
    end
    drawTextBox(c1 .. "\n" .. c2, 16, 32 + y_offset - 60, 70, 50, 2)
  end
end

function drawEvent()
  local y_offset 
  if hero.y > 17 and not getBattleActive() then 
    y_offset = 0
  else 
    y_offset = 105
  end

  if flash > 0 then
    setColor("red")
    love.graphics.rectangle("fill",0,0,600,500)
    setColor("white")
    flash = flash - 1
  end

  drawTextBox(textBox.text, 16, 34 + y_offset, 268, 77)
  
  drawChoiceBox(textBox.choiceStatus, textBox.choice1, textBox.choice2, y_offset)
end