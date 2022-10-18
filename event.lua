local textBox = {}
  textBox.choiceStatus = 0
  textBox.choice1 = ""
  textBox.choice2 = ""
  textBox.text = eventTable[1][1][4]
  textBox.WIDTH = 250
  textBox.HEIGHT = 75
  textBox.X = (300 - textBox.WIDTH) / 2
  textBox.Y = textBox.X + 10
  textBox.BORDER = 2
  
local eventID = 0
local subeventID = 0
local eventLog

function getEvent(level,x,y)
  eventID = nil
  local checkEvents = function (i,v)
    if x == v[2] and y == v[3] then
      eventID = i
    end
  end
    
  iterateTable(eventTable[level],checkEvents)
  
  return eventID
end

function getEventByID(level,eventID)
  return eventTable[level][eventID]
end

function getSubEvent(level,eventID,subeventID)
  return eventTable[level][eventID][4][subeventID]
end

  
function checkEventOverlap()
  -- check if hero overlaps event
  eventID = getEvent(level,hero.x,hero.y)
  
  if eventID ~= nil then
    subeventID = 0
    scene = "event"
    eventLog = getEventByID(level,eventID)[4]
    eventStep()
  end
end

function eventStep()
  if subeventID < #eventLog then
    subeventID = subeventID + 1
    if eventLog[subeventID][1] == "textBox" then
      textBox.text = eventLog[subeventID][2]
    elseif eventLog[subeventID][1] == "flagBranch" then          
      if eventLog[subeventID][2] then
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
        
      --  print("choice 1")--eventLog = eventLog[subeventID][choice + 1]
      --else
      --  print("choice 2")--eventLog = eventLog[subeventID][choice + 2]
      end
    end
  else
    scene = "map"
  end
end

function eventKeyPressed(key)
  if textBox.choiceStatus > 0 then
    if key == "up" then 
      textBox.choiceStatus = 1
    elseif key == "down" then
      textBox.choiceStatus = 2
    elseif key == "z" then
      eventStep()
      --eventTable[level][textBox.eventID][1] = "NULL"
    end
    return
  elseif key == "z" then 
    eventStep()
  end
end


function drawEvents()
  -- draw events
  do
    local drawEvent = function (i,v)
      if v[1] ~= "NULL" then
        love.graphics.rectangle("fill", (v[2] - 1) * 10+3, (v[3] - 1) * 10 + 3, 4, 4)
      end
    end
    
    setColor("pink")    
    iterateTable(eventTable[level], drawEvent)
  end
end

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

function drawTextBoxEvent()
  -- draw text box
  local y_offset 
  if hero.y > 10 then 
    y_offset = 0
  else 
    y_offset = 180 - textBox.HEIGHT
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