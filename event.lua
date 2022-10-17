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

  
function updateEvents()
  -- check if hero overlaps event
  do 
    local checkEvents = function (i,v)
      if hero.x == v[2] and hero.y == v[3] then
        eventID = i
        subeventID = 1
        scene = "event"
        textBox.text = eventTable[level][eventID][4][subeventID][2]
        do
        --elseif v[1] == "choiceBox" then
        --  textBox.text = eventTable[level][i][4]
        --  textBox.choice1 = eventTable[level][i][5]
        --  textBox.choice2 = eventTable[level][i][6]
        --  textBox.choiceStatus = 1
        --  scene = "event"
        end
      end
    end
    
    iterateTable(eventTable[level],checkEvents)
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
  --draw text box
  local y_offset 
  if hero.y > 10 then 
    y_offset = 0
  else 
    y_offset = 180 - textBox.HEIGHT
  end

  drawTextBox(textBox.text, textBox.X, textBox.Y + y_offset, 
    textBox.WIDTH, textBox.HEIGHT,textBox.BORDER)
  
  do
--  if textBox.choiceStatus > 0 then
--    local choiceOffset = 0
--    local w,h = 20, 20
--    local c1, c2 = textBox.choice1, textBox.choice2 
--    if textBox.choiceStatus == 1 then
--      c1 = "<" .. textBox.choice1 .. ">"
--      c2 = "  " .. textBox.choice2 .. " "
--    else
--      c1 = "  " .. textBox.choice1 .. " "
--      c2 = "<" .. textBox.choice2 .. ">"
--    end
--    setColor("black")
--    drawTextBox(c1 .. "\n" .. c2, 
--        textBox.X, textBox.Y + y_offset - 60, 60, 50, 2)
--  end
  end
end

function eventKeyPressed(key)
  do
 -- if textBox.choiceStatus > 0 then
 --   if key == "up" then 
 --     textBox.choiceStatus = 1
 --   elseif key == "down" then
 --     textBox.choiceStatus = 2
 --   elseif key == "z" then
 --     textBox.choiceStatus = 0
 --     scene = "map"
 --     eventTable[level][textBox.eventID][1] = "NULL"
 --   end
 --   return
 -- --elseif key == "z" then 
 end
  if key == "z" then
    local eventLog = eventTable[level][eventID][4]
   
    if subeventID < #eventLog then
      subeventID = subeventID + 1
      textBox.text = eventLog[subeventID][2]
    else
      scene = "map"
    end
  end
end